import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/custom_outlined_button.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/features/cart/data/data/cart_repo_impl.dart';
import 'package:hezmart/features/cart/data/models/cart_payload.dart';
import 'package:hezmart/features/cart/presentations/cartbloc/cart_bloc.dart';
import 'package:hezmart/features/homescreen/data/data/product_repo_impl/product_repo_impl.dart';
import 'package:hezmart/features/homescreen/presentations/bloc/products_bloc.dart';
import 'package:hezmart/features/homescreen/presentations/widgets/description_details.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/theme/pallets.dart';
import '../../../authentication/presentations/user_bloc/user_bloc.dart';
import '../../../categories/data/data/category_repo_impl/category_repo.dart';
import '../../../categories/presentations/category_bloc/category_bloc.dart';
import '../../data/models/singleproduct_response.dart';
import 'homescreen.dart';
class ProductDetails extends StatefulWidget {
  String id;
  ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final PageController _pageController = PageController();
  final single = ProductsBloc(ProductRepositoryImpl(NetworkService()));
  final cart = CartBloc(CartRepositoryImpl(NetworkService()));
  final subcat = CategoryBloc(CategoryRepositoryImpl(NetworkService()));

  int _currentPage = 0;
  int length = 4;
  String formattedDate(String dateString) {
    final DateTime parsedDate = DateTime.parse(dateString);
    return DateFormat('MM/dd/yyyy').format(parsedDate);
  }
  final mycart = injector.get<CartBloc>();

  @override
  void initState() {
    // TODO: implement initState
    single.add(SingleProductsEvent(widget.id.toString()));
    mycart.add(GetCartEvent());

    super.initState();
  }
  String formatNumberWithCommas(String number) {
    try {
      final parsedNumber = double.parse(number.replaceAll(',', ''));
      return parsedNumber.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
      );
    } catch (e) {
      return number;
    }
  }

  int number = 1;
  Map<String, String> selectedOptionValues = {};


  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  SingleProductsResponse? singleRes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: CustomAppBar(tittle: TextView(text: "Product Details"),actions: [
        InkWell(
          onTap: (){
            context.goNamed(PageUrl.mycart);
          },
          child: BlocConsumer<CartBloc, CartState>(
            bloc: mycart,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is GetCartSuccessState) {
                final cartitems = state.response.data?.items;
                if(cartitems!.isEmpty){
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(Icons.shopping_cart_outlined),

                    ],
                  );
                }

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(Icons.shopping_cart_outlined),
                    Positioned(
                      right: -3,
                      top: -5,
                      child: CircleAvatar(
                        backgroundColor: Color(0xffE67002),
                        radius: 8,
                        child: TextView(
                          text: cartitems!.length.toString(),
                          color: Pallets.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Icon(Icons.shopping_cart_outlined);
            },
          ),
        ),
        15.horizontalSpace,
      ],),

      body: BlocConsumer<ProductsBloc, ProductsState>(
        bloc: single,
        listener: _listentToProductState,
        builder: (context, state) {
          if (state is ProductsFailiureState) {
            return Center(
              child: AppPromptWidget(
                onTap: (){
                  single.add(SingleProductsEvent(widget.id.toString()));

                },
              ),
            );

          }
          if (state is SingleProductSuccessState) {
            singleRes = state.response;
            final product = state.response.data?.product;

            int calculateDiscountPercentage(
              String price,
              String discountPrice,
            ) {
              final double originalPrice = double.tryParse(price) ?? 0;
              final double discountedPrice =
                  double.tryParse(discountPrice) ?? 0;
              if (discountedPrice <= 0 || discountedPrice >= originalPrice)
                return 0;
              return ((1 - discountedPrice / originalPrice) * 100).round();
            }

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 320,
                            child: Stack(
                              children: [
                                PageView.builder(
                                  controller: _pageController,
                                  itemCount: product?.coverImage?.length ?? 1,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return ImageWidget(
                                      imageUrl:
                                          product!.coverImage.toString(),
                                      height: 300,
                                      width: 1.sw,
                                      fit: BoxFit.contain,
                                    );
                                  },
                                ),
                                if ((product?.images?.length ?? 0) > 1)
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        product?.images?.length ?? 0,
                                        (index) => Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                _currentPage == index
                                                    ? Colors.white
                                                    : Colors.white
                                                        .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          if (product?.images.isNotEmpty ?? false)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  product!.images.length,
                                  (i) => Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      right: 10,
                                    ),
                                    child: ImageWidget(
                                      imageUrl: product.images[i],
                                      size: 100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          20.verticalSpace,
                          TextView(
                            text: product!.category!.name.toString(),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Pallets.grey35,
                          ),
                          10.verticalSpace,
                          TextView(
                            text: product.name.toString(),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          10.verticalSpace,
                          4.verticalSpace,
                          if (product.options.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(product.options.length, (optionIndex) {
                                final option = product.options[optionIndex];
                                final optionName = option.name ?? "Option";

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      text: optionName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    10.verticalSpace,
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: List.generate(option.values.length, (valueIndex) {
                                        final value = option.values[valueIndex].value ?? "";
                                        final isSelected = selectedOptionValues[optionName] == value;

                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedOptionValues[optionName] = value;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: isSelected ?  Color(0xff992002) : Colors.transparent,
                                              border: Border.all(
                                                color: isSelected ?  Color(0xff992002) : Pallets.grey95,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: TextView(
                                              text: value,
                                              fontSize: 13,
                                              color: isSelected ?  Pallets.white: Colors.black,
                                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    20.verticalSpace,
                                  ],
                                );
                              }),
                            ),


                          10.verticalSpace,
                          Row(
                            children: [
                              Text(
                                 "₦${formatNumberWithCommas(product.discountPrice??'')}",
                               style: TextStyle( fontSize: 18,
                                 fontWeight: FontWeight.w500,),
                              ),
                              20.horizontalSpace,
                              Text(
                                "₦${formatNumberWithCommas(product.price??'')}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),

                              10.horizontalSpace,
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red.withOpacity(0.3),
                                ),
                                child: TextView(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                  text:
                                      "${calculateDiscountPercentage(product.price.toString(), product.discountPrice.toString())}% OFF",
                                ),
                              ),
                            ],
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating:
                            double.tryParse(
                              product.ratingsAverage.toString(),
                            )!.toDouble(),
                            direction:
                            Axis.horizontal,
                            itemSize: 20,
                            allowHalfRating: false,
                            itemCount: 5,
                            unratedColor:
                            Pallets.grey90,
                            itemPadding:
                            EdgeInsets.symmetric(
                              horizontal: 0.0,
                            ),
                            itemBuilder:
                                (
                                context,
                                _,
                                ) => const Icon(
                              Icons
                                  .star_border_outlined,
                              color: Colors.amber,
                              size: 14,
                            ),
                            onRatingUpdate:
                                (double value) {},
                            // onRatingUpdate: (rating) {
                            //   print(rating);
                            //   setState(() {
                            //     setState(() {
                            //       // _rating = rating;
                            //     });
                            //   });
                            // },
                          ),

                          20.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              context.pushNamed(PageUrl.description_details,
                                extra:
                                DesParams(product?.category?.name??'', product?.subCategory?.name??'', product?.weight.toString()??'', product!.taxable.toString(), product!.isDigital.toString(),
                                    product?.description??''

                                ),

                             );
                            },
                            splashColor: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              TextView(text: "Product details",fontSize: 14,fontWeight: FontWeight.w600,),
                              Icon(Icons.arrow_forward_ios_rounded,size: 18,),
                            ],),
                          ),
                          Divider(),
                          TextView(
                            text: product!.description ?? "",
                            fontSize: 13,
                            maxLines: 6,
                            textOverflow: TextOverflow.ellipsis,
                          ),

                        ],
                      ),
                    ),
                    10.verticalSpace,
                Container(padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white

                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(text: "Others"),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Catalog",
                          fontSize: 12,
                          color: Pallets.grey35,

                        ),
                        TextView(
                          text:product.subCategory?.name??'',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Taxable",
                          fontSize: 12,
                          color: Pallets.grey35,

                        ),
                        TextView(
                          text:product.taxable==false?"No":"Yes",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        TextView(
                          text: "Digital Product",
                          fontSize: 12,
                          color: Pallets.grey35,

                        ),
                        TextView(
                          text:product.isDigital==false?"No":"Yes",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),),
                    15.verticalSpace,
                    if (product.reviews.isEmpty)
                     SizedBox()
                    else
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white


                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(text: "Product Ratings & Reviews",fontWeight: FontWeight.w600,fontSize: 14,),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:Colors.yellow.withOpacity(0.05),
                                  border: Border.all(color: Colors.yellow)),
                                    child: TextView(text:"${ product.ratingsAverage.toString()}/5",color: CupertinoColors.systemYellow,fontSize: 12,),),
                                4.horizontalSpace,
                                TextView(text: "(${product.ratingsQuantity.toString()} rating)",fontSize: 10,),
                              ],
                            ),
                            // 20.verticalSpace,
                            Divider(),
                            ...List.generate(product.reviews.length, (reviewIndex) {
                              final review = product.reviews[reviewIndex];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [


                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [

                                          5.verticalSpace,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child:     RatingBarIndicator(
                                                  rating: double.tryParse(review['rating'].toString()) ?? 0.0,
                                                  itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                                                  itemCount: 5,
                                                  itemSize: 16.0,
                                                  unratedColor: Pallets.grey90,
                                                ),
                                              ),
                                              TextView(
                                                text: formattedDate(review['createdAt'] ?? ''),
                                                fontSize: 11,
                                              ),
                                            ],
                                          ),
                                          5.verticalSpace,
                                          TextView(
                                            text: review['review'] ?? "",
                                            fontSize: 12,
                                          ),
                                          5.verticalSpace,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextView(text: "by ${review['reviewUser']?['firstName'] ?? ''} "
                                                  "${review['reviewUser']?['lastName'] ?? ''}",
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.verified,color: Colors.green,size: 14,),
                                                  TextView(text: "Verified Purchase",fontSize: 10,color: Colors.green,),
                                                ],
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                20.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: BlocConsumer<CartBloc, CartState>(
                        bloc: cart,
                        listener: _listenToAddCatState,
                        builder: (context, state) {
                          return CustomButton(
                            onPressed: injector.get<UserBloc>().appUser != null?() {
                              addToCart();
                            }:(){
                              CustomDialogs.showToast("Login to add to cart");
                            },
                            child: TextView(
                              text: "Add To Cart",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                    ),
                    20.verticalSpace,
                    SimilaProduct(catId: product.categoryId.toString(), subcatId: product.subCategoryId.toString(), productname: product.name.toString(),),

                  ],

                ),
              )
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _listentToProductState(BuildContext context, ProductsState state) {
    if (state is ProductsloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is ProductsFailiureState) {
      context.pop();
    }
    if (state is SingleProductSuccessState) {
      context.pop();
    }
  }

  void _listenToAddCatState(BuildContext context, CartState state) {
    if (state is AddCartloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is CartfailiureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is AddCartSuccessState) {
      context.pop();
      CustomDialogs.success("Item added to cart");

    }
  }

  // void addToCart() {
  //   cart.add(
  //     AddItemToCart(
  //       AddToCartpayload(
  //         productId: singleRes?.data?.product?.id.toString(),
  //         quantity: "1",
  //         options: Options(size: "", color: ""),
  //       ),
  //     ),
  //   );
  // }

  void addToCart() {
    final selectedColor = selectedOptionValues['Color'] ?? '';
    final selectedSize = selectedOptionValues['Size'] ?? '';

    cart.add(
      AddItemToCart(
        AddToCartpayload(
          productId: singleRes?.data?.product?.id.toString(),
          quantity: "1",
          options: Options(
            size: selectedSize,
            color: selectedColor,
          ),
        ),
      ),
    );
  }

}


class SimilaProduct extends StatefulWidget {
  final String catId;
  final String subcatId;
  final String productname;
  const SimilaProduct({super.key, required this.catId, required this.subcatId, required this.productname});

  @override
  State<SimilaProduct> createState() => _SimilaProductState();
}

class _SimilaProductState extends State<SimilaProduct> {
  final subcat = CategoryBloc(CategoryRepositoryImpl(NetworkService()));
  @override
  void initState() {
    super.initState();
    subcat.add(GetSimilarProductEvent(widget.catId,));
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      bloc: subcat,
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
        if(state is SimilarproductSuccess){
          final subcatResponse = state.response.data!.products
              .where((product) => product.name?.toLowerCase().trim() != widget.productname.toLowerCase().trim())
              .toList();
          if(subcatResponse.isEmpty){
            return Center(child:  TextView(text: "",fontSize: 15,fontWeight: FontWeight.w500,),);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "Other similar Products",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                10.verticalSpace,
                SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 400,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(subcatResponse.length, (index) {
                            int calculateDiscountPercentage(String price, String discountPrice) {
                              final double originalPrice = double.tryParse(price) ?? 0;
                              final double discountedPrice = double.tryParse(discountPrice) ?? 0;
                              if (discountedPrice <= 0 || discountedPrice >= originalPrice) return 0;
                              return ((1 - discountedPrice / originalPrice) * 100).round();
                            }

                            String formatNumberWithCommas(String number) {
                              try {
                                final parsedNumber = double.parse(number.replaceAll(',', ''));
                                return parsedNumber.toStringAsFixed(0).replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (Match m) => '${m[1]},',
                                );
                              } catch (e) {
                                return number;
                              }
                            }
                            return InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                context.pushNamed(
                                  PageUrl.product_details,
                                  queryParameters: {
                                    PathParam.id: subcatResponse[index].id.toString(),
                                  },
                                );
                              },
                              child: Container(
                                width: 190,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Pallets.grey95),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            context.pushNamed(
                                              PageUrl.product_details,
                                              queryParameters: {
                                                PathParam.id: subcatResponse[index].id.toString(),
                                              },
                                            );
                                          },
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: IgnorePointer(
                                                child: ImageWidget(
                                                  imageUrl: subcatResponse[index].coverImage.toString(),
                                                  size: 150,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextView(
                                                text: subcatResponse[index].name ?? '',
                                                fontSize: 13,
                                                maxLines: 2,
                                                textOverflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                   "₦${formatNumberWithCommas(subcatResponse[index].discountPrice??'')}",
                                                    style: TextStyle(fontWeight: FontWeight.w700,
                                                      fontSize: 13,),
                                                  ),
                                                  Text(

                                                    "₦${formatNumberWithCommas(subcatResponse[index].price??'')}",
                                                    style: TextStyle(
                                                      decoration: TextDecoration.lineThrough,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TextView(
                                                    text: "${subcatResponse[index].stockQuantity} units left",
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                          RatingBarIndicator(

                                            rating: double.tryParse(
                                              subcatResponse[index].ratingsAverage.toString(),
                                            ) ??
                                                0.0,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemSize: 16,
                                            unratedColor: Pallets.grey90,
                                            itemBuilder: (context, _) => const Icon(
                                              Icons.star_border_outlined,
                                              color: Colors.amber,
                                            ),
                                          ),

                                                ],
                                              ),
                                              6.verticalSpace,
                                              StockIndicator(stockQuantity: subcatResponse[index].stockQuantity),
                                              5.verticalSpace,
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Container(
                                        height: 30,
                                        width: 55,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          color: const Color(0xff3567a6),
                                        ),
                                        child: Center(
                                          child: TextView(
                                            text: "${calculateDiscountPercentage(
                                              subcatResponse[index].price.toString(),
                                              subcatResponse[index].discountPrice.toString(),
                                            )}% OFF",
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                  ),
                ),
                20.verticalSpace,
              ],
            ),
          );
        }
    return SizedBox();
  },
);
  }
}
