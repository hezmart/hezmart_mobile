import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/image_widget.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/error_widget.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/services/network/network_service.dart';
import '../../data/data/product_repo_impl/product_repo_impl.dart';
import '../bloc/products_bloc.dart';
import '../screens/homescreen.dart';

class FlashSales extends StatefulWidget {
  const FlashSales({super.key});

  @override
  State<FlashSales> createState() => _FlashSalesState();
}

class _FlashSalesState extends State<FlashSales> {
  final products = ProductsBloc(ProductRepositoryImpl(NetworkService()));

  @override
  void initState() {
    products.add(GetAllProductsEvent());
    super.initState();
  }

  double _rating = 4.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: BlocConsumer<ProductsBloc, ProductsState>(
          listener: _listenToProductState,
          bloc: products,
          builder: (context, state) {
            if (state is ProductsFailiureState) {
              return SizedBox(
                height: 1.sh,
                child: Center(
                  child: AppPromptWidget(
                    onTap: () {
                      products.add(GetAllProductsEvent());
                    },
                  ),
                ),
              );
            }

            if(state is ProductsloadingState){
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      2,
                          (index) => Container(
                        width: 140,
                        height: 70,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Pallets.grey95,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      2,
                          (index) => Container(
                        width: 140,
                        height: 70,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Pallets.grey95,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is ProductsSuccessState) {
              int calculateDiscountPercentage(String price, String discountPrice) {
                final double originalPrice = double.tryParse(price) ?? 0;
                final double discountedPrice = double.tryParse(discountPrice) ?? 0;
                if (discountedPrice <= 0 || discountedPrice >= originalPrice) {
                  return 0;
                }
                return ((1 - discountedPrice / originalPrice) * 100).round();
              }

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

              final flashProducts = state.response.data?.products?.where((product) {
                final discountPercent = calculateDiscountPercentage(
                  product.price.toString(),
                  product.discountPrice.toString(),
                );
                return discountPercent >= 40;
              }).toList();

              if (flashProducts == null || flashProducts.isEmpty) {
                return SizedBox();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    padding: EdgeInsets.all(10),
                    color: Color(0xffd80d0d),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.flash_on_sharp, color: Colors.white),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: "Flash Sales",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                                TextView(
                                  text: "Buy at an affordable price",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          ],
                        ),
                        TextView(
                          text: "See All",
                          color: Colors.white,
                          onTap: (){
                            context.pushNamed(PageUrl.weekly_offer);
                          },
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount: flashProducts.take(6).length,
                      itemBuilder: (context, index) {
                        final product = flashProducts[index];
                        final discountPercent = calculateDiscountPercentage(
                          product.price.toString(),
                          product.discountPrice.toString(),
                        );

                        return Container(
                          width: 160,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Pallets.grey95.withOpacity(0.3)),
                            color: Colors.white,
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Image
                                  Container(
                                    height: 120,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        context.pushNamed(
                                          PageUrl.product_details,
                                          queryParameters: {
                                            PathParam.id: product.id.toString(),
                                          },
                                        );
                                      },
                                      child: Center(
                                        child: IgnorePointer(
                                          child: ImageWidget(
                                            imageUrl: product.coverImage ?? '',
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Product Details
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            context.pushNamed(
                                              PageUrl.product_details,
                                              queryParameters: {
                                                PathParam.id: product.id.toString(),
                                              },
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextView(
                                                text: product.name ?? '',
                                                maxLines: 1,
                                                fontSize: 10,
                                                textOverflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "₦${formatNumberWithCommas(product.discountPrice.toString())}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(height: 2),
                                              StockIndicator(
                                                stockQuantity: product.stockQuantity,
                                              ),



                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Discount Badge
                              Positioned(
                                top: -5,
                                right: -5,
                                child: Container(
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
                                      text: "$discountPercent% OFF",
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  void _listenToProductState(BuildContext context, ProductsState state) {
    // if (state is ProductsloadingState) {
    //   CustomDialogs.showLoading(context);
    // }
    // if (state is ProductsFailiureState) {
    //   context.pop();
    // }
    // if (state is ProductsSuccessState) {
    //   context.pop();
    // }
  }



}