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
import '../../../../core/navigation/path_params.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/services/network/network_service.dart';
import '../../../../core/theme/pallets.dart';
import '../../../homescreen/data/data/product_repo_impl/product_repo_impl.dart';
import '../../../homescreen/presentations/bloc/products_bloc.dart';
import '../../../homescreen/presentations/screens/homescreen.dart';
class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final products = ProductsBloc(ProductRepositoryImpl(NetworkService()));
  @override
  void initState() {
    // TODO: implement initState
    products.add(GetAllProductsEvent());
    super.initState();
  }
  bool liked=false;
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
      final product = state.response.data?.products;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60,left: 10,right: 10),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: .7,
            ),
            physics: NeverScrollableScrollPhysics(),

            shrinkWrap: true,
            children: List.generate(product!.length, (index) {

              int calculateDiscountPercentage(String price, String discountPrice) {
                final double originalPrice = double.tryParse(price) ?? 0;
                final double discountedPrice = double.tryParse(discountPrice) ?? 0;

                if (discountedPrice <= 0 || discountedPrice >= originalPrice) return 0;

                return ((1 - discountedPrice / originalPrice) * 100).round();
              }
              // int discountPercentage= calculateDiscountPercentage('1000', '750');
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
              return Container(
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
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              context.pushNamed(
                                  PageUrl.product_details,
                                  queryParameters: {PathParam.id:product![index].id.toString() }
                              );
                            },
                            child: Center(
                              child: IgnorePointer(
                                child: ImageWidget(
                                  imageUrl:
                                  product![index].coverImage
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  context.pushNamed(
                                      PageUrl.product_details,
                                      queryParameters: {PathParam.id:product[index].id.toString() }
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      maxLines: 2,
                                      textOverflow: TextOverflow.ellipsis,
                                      text:
                                      product?[index].name ??
                                          '',
                                      fontSize: 13,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(

                                          "₦${formatNumberWithCommas(product?[index].discountPrice??'')}",
                                         style: TextStyle( fontWeight:
                                         FontWeight.w700,),
                                        ),
                                        Text(

                                          "₦${formatNumberWithCommas(product?[index].price??'')}",
                                          style: TextStyle( decoration: TextDecoration.lineThrough,
                                            fontSize: 12,),
                                        ),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        TextView(
                                          text:
                                          "${product[index].stockQuantity.toString()} units left",
                                          fontWeight:
                                          FontWeight.w300,
                                          fontSize: 10,
                                        ),
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating: double.tryParse( product[index].ratingsAverage.toString())!.toDouble(),
                                          direction:
                                          Axis.horizontal,
                                          itemSize: 16,
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
                                              context, _,) => const Icon(
                                            Icons
                                                .star_border_outlined,
                                            color: Colors.amber,
                                            size: 14,
                                          ), onRatingUpdate: (double value) {  },
                                          // onRatingUpdate: (rating) {
                                          //   print(rating);
                                          //   setState(() {
                                          //     setState(() {
                                          //       // _rating = rating;
                                          //     });
                                          //   });
                                          // },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              6.verticalSpace,

                              StockIndicator(stockQuantity: product[index].stockQuantity,),
                              5.verticalSpace,
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.favorite_border, size: 18),
                          Container(
                            height: 30,
                            width: 55,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Color(0xff3567a6),
                            ),
                            child: Center(
                              child: TextView(
                                text: "${calculateDiscountPercentage(product[index].price.toString(),product[index].discountPrice.toString())}% OFF",
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
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
      );
    }
    return SizedBox();
  },
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
