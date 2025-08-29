import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/services/network/network_service.dart';
import '../../../../core/theme/pallets.dart';
import '../../../authentication/presentations/user_bloc/user_bloc.dart';
import '../../../cart/data/data/cart_repo_impl.dart';
import '../../../cart/data/models/cart_payload.dart';
import '../../../cart/presentations/cartbloc/cart_bloc.dart';
import '../../../homescreen/data/data/product_repo_impl/product_repo_impl.dart';
import '../../../homescreen/data/models/getall_products.dart';
import '../../../homescreen/presentations/bloc/products_bloc.dart';
import '../../../homescreen/presentations/screens/homescreen.dart';
import '../../../wishlist/data/data/repossitory_impl/repossitory_impl.dart';
import '../../../wishlist/presentations/fav_bloc/favourite_bloc.dart';
class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final products = ProductsBloc(ProductRepositoryImpl(NetworkService()));
  final cart = CartBloc(CartRepositoryImpl(NetworkService()));
  final likeproduct = FavouriteBloc(
    MyfavouritesRepositoryImpl(NetworkService()),
  );
  final unlikeproduct = FavouriteBloc(
    MyfavouritesRepositoryImpl(NetworkService()),
  );
  final likedproduct = FavouriteBloc(
    MyfavouritesRepositoryImpl(NetworkService()),
  );
  @override
  void initState() {
    // TODO: implement initState

    likedproduct.add(GetfavouriteEvent());
    products.add(GetAllProductsEvent());
    super.initState();
  }
  bool liked=false;
  GetAllProductsResponse? allResponse;
  final Set<String> likedProductIds = {};

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(text: "All Products",fontSize: 18,fontWeight: FontWeight.w500,),
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
  listener:_listenToProductState,
        bloc: products,
  builder: (context, state) {
    if(state is ProductsFailiureState){
      return Center(child: AppPromptWidget(
        onTap: (){
          products.add(GetAllProductsEvent());

        },
      ),);
    }
    if(state is ProductsSuccessState){
      allResponse = state.response;
      logger.w(state.response.data?.products.first.name ?? '');
      final product = state.response.data?.products;
      // final uniqueCategories = product!
      //     .map((item) => item.category?.name)
      //     .where((name) => name != null)
      //     .toSet()
      //     .toList();
      final Map<String, List<Product>> productsByCategory = {};

      for (var item in product!) {
        final categoryName = item.category?.name ?? 'Others';
        if (!productsByCategory.containsKey(categoryName)) {
          productsByCategory[categoryName] = [];
        }
        productsByCategory[categoryName]!.add(item);
      }

      // final product = state.response.data?.products;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60,left: 0,right: 0),
          child:  Column(
            children:
            productsByCategory.entries.map((entry) {
              String formatNumberWithCommas(String number) {
                try {
                  final parsedNumber = double.parse(number.replaceAll(',', ''));
                  return parsedNumber
                      .toStringAsFixed(0)
                      .replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},',
                  );
                } catch (e) {
                  return number;
                }
              }

              final categoryName = entry.key;
              final categoryProducts = entry.value;
              final categoryId =
                  categoryProducts.first.category?.id
                      .toString() ??
                      '';
              return Column(
                children: [
                  10.verticalSpace,
                  Container(
                    height: 60,
                    width: 1.sw,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    color: Color(0xffE67002).withOpacity(0.8),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: categoryName,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        TextView(
                          onTap: () {
                            context.pushNamed(
                              PageUrl.see_all,
                              queryParameters: {
                                PathParam.id: categoryId,
                                PathParam.userName: categoryName,
                              },
                            );
                          },
                          text: 'See All',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child:  GridView(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: .7,
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(categoryProducts.take(10).length, (
                          index,
                          ) {
                        final prod = categoryProducts[index];
                        int calculateDiscountPercentage(
                            String price,
                            String discountPrice,
                            ) {
                          final double originalPrice =
                              double.tryParse(price) ?? 0;
                          final double discountedPrice =
                              double.tryParse(discountPrice) ?? 0;
                          if (discountedPrice <= 0 ||
                              discountedPrice >= originalPrice)
                            return 0;
                          return ((1 -
                              discountedPrice /
                                  originalPrice) *
                              100)
                              .round();
                        }

                        final productId = prod.id.toString();
                        final isLiked = likedProductIds.contains(
                          productId,
                        );

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            border: Border.all(
                              color: Pallets.grey95,
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      splashColor:
                                      Colors.transparent,
                                      onTap: () {
                                        context.pushNamed(
                                          PageUrl.product_details,
                                          queryParameters: {
                                            PathParam.id:
                                            prod.id
                                                .toString(),
                                          },
                                        );
                                      },
                                      child: Center(
                                        child: IgnorePointer(
                                          child: ImageWidget(
                                            imageUrl:
                                            prod.coverImage
                                                .toString(),
                                            size: 150,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  4.verticalSpace,
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        InkWell(
                                          splashColor:
                                          Colors.transparent,
                                          onTap: () {
                                            context.pushNamed(
                                              PageUrl
                                                  .product_details,
                                              queryParameters: {
                                                PathParam.id:
                                                prod.id
                                                    .toString(),
                                              },
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              TextView(
                                                text:
                                                prod.name ??
                                                    '',
                                                maxLines: 2,
                                                fontSize: 13,
                                              ),
                                              6.verticalSpace,
                                              StockIndicator(
                                                stockQuantity:
                                                prod.stockQuantity,
                                              ),
                                              6.verticalSpace,
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  RatingBar.builder(
                                                    ignoreGestures:
                                                    true,
                                                    initialRating:
                                                    double.tryParse(
                                                      prod.ratingsAverage
                                                          .toString(),
                                                    ) ??
                                                        0,
                                                    direction:
                                                    Axis.horizontal,
                                                    itemSize: 16,
                                                    allowHalfRating:
                                                    false,
                                                    itemCount: 5,
                                                    unratedColor:
                                                    Pallets
                                                        .grey90,
                                                    itemPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal:
                                                      0.0,
                                                    ),
                                                    itemBuilder:
                                                        (
                                                        context,
                                                        _,
                                                        ) => const Icon(
                                                      Icons
                                                          .star_border_outlined,
                                                      color:
                                                      Colors.amber,
                                                      size:
                                                      14,
                                                    ),
                                                    onRatingUpdate:
                                                        (
                                                        double
                                                        value,
                                                        ) {},
                                                  ),
                                                  5.horizontalSpace,
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        "₦${formatNumberWithCommas(prod.discountPrice.toString())}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w700,
                                                        ),
                                                      ),
                                                      Text(
                                                        "₦${formatNumberWithCommas(prod.price.toString())}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          decoration:
                                                          TextDecoration.lineThrough,
                                                          fontSize:
                                                          10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  BlocConsumer<CartBloc, CartState>(
                                                    bloc: cart,
                                                    listener:(BuildContext context, CartState state) {
                                                      if (state is AddCartloadingState) {
                                                        CustomDialogs.showLoading(context,barrierColor: Colors.transparent);
                                                      }
                                                      if (state is CartfailiureState) {
                                                        context.pop();
                                                        CustomDialogs.error(state.error);
                                                      }
                                                      if (state is AddCartSuccessState) {
                                                        context.pop();
                                                        CustomDialogs.success("Item added to cart");
                                                      }
                                                    },

                                                    builder: (context, state,) {
                                                      return InkWell(
                                                        splashColor: Colors.transparent,
                                                        onTap: injector.get<UserBloc>().appUser != null?() {
                                                          addToCart(
                                                            productId,
                                                          );
                                                        }:(){
                                                          CustomDialogs.showToast("Login to add to cart");
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                          Color(
                                                            0xffE67002,
                                                          ),
                                                          radius:
                                                          14,
                                                          child: Icon(
                                                            Icons
                                                                .add_shopping_cart,
                                                            size:
                                                            16,
                                                            color:
                                                            Colors.white,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        6.verticalSpace,
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    BlocConsumer<FavouriteBloc, FavouriteState>(
                                      bloc: likeproduct,
                                      listener: (context, state) {
                                        if (state is FavouriteloadingState) {
                                          CustomDialogs.showLoading(context, barrierColor: Colors.transparent);
                                        }
                                        if (state is FavouritefailiureState) {
                                          context.pop();
                                        }
                                        if (state is FavouritelikeSuccessState) {
                                          context.pop();
                                          likedProductIds.add(state.productId);
                                          setState(() {});
                                          CustomDialogs.showToast("Added to favourite");
                                        }
                                        if (state is FavouriteUnlikeSuccessState) {
                                          context.pop();
                                          likedProductIds.remove(state.productId);
                                          setState(() {});
                                          CustomDialogs.showToast("Removed from favourite");
                                        }
                                      },
                                      builder: (context, state) {
                                        final currentProductId = prod.id.toString(); // ✅ Get from loop item

                                        return CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Pallets.white,
                                          child: GestureDetector(
                                            onTap: injector.get<UserBloc>().appUser != null?() {
                                              if (likedProductIds.contains(currentProductId)) {
                                                likeproduct.add(UnlikeItemEvent(currentProductId)); // ✅ send correct id
                                              } else {
                                                likeproduct.add(LikeItemEvent(currentProductId));
                                              }
                                            }:(){
                                              CustomDialogs.showToast("Login to add favorite");
                                            },
                                            child: Icon(
                                              likedProductIds.contains(currentProductId)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: likedProductIds.contains(currentProductId)
                                                  ? Colors.red
                                                  : Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                        );
                                      },
                                    ),



                                    Container(
                                      height: 30,
                                      width: 55,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.only(
                                          topRight:
                                          Radius.circular(
                                            10,
                                          ),
                                          bottomLeft:
                                          Radius.circular(
                                            10,
                                          ),
                                        ),
                                        color: Color(0xff3567a6),
                                      ),
                                      child: Center(
                                        child: TextView(
                                          text:
                                          "${calculateDiscountPercentage(prod.price.toString(), prod.discountPrice.toString())}% OFF",
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  10.verticalSpace,
                ],
              );
            }).toList(),
          ),
        ),
      );
    }
    return SizedBox();
  },
),
    );
  }
  void addToCart(String productId) {
    cart.add(
      AddItemToCart(
        AddToCartpayload(
          productId: productId,
          quantity: "1",
          options: Options(size: "", color: ""),
        ),
      ),
    );
  }

  void _listenToProductState(BuildContext context, ProductsState state) {
    if(state is ProductsloadingState){
      CustomDialogs.showLoading(context);
    }
    if(state is ProductsFailiureState){
      context.pop();
    }
    if(state is ProductsSuccessState){
      context.pop();
    }

  }
}
