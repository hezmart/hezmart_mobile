import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/features/homescreen/presentations/bloc/products_bloc.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/services/network/network_service.dart';
import '../../../../core/theme/pallets.dart';
import '../../../categories/data/data/category_repo_impl/category_repo.dart';
import '../../../categories/presentations/category_bloc/category_bloc.dart';
import 'homescreen.dart';
class SeeAll extends StatefulWidget {
  final String catId;
  final String name;
  const SeeAll({super.key, required this.catId, required this.name});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  final subcat = CategoryBloc(CategoryRepositoryImpl(NetworkService()));
  @override
  void initState() {
    super.initState();
    subcat.add(GetSimilarProductEvent(widget.catId,));
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(tittle: TextView(text: widget.name,fontSize: 18,),),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        bloc: subcat,
        listener:_listenToAllCatState,
        builder: (context, state) {
          if(state is CategoryloadinggState){
          return Center(
            child: CustomDialogs.getLoading(size: 30),
          );
          }
          if(state is CategoryfailiureState){
            return Center(
              child: AppPromptWidget(

              ),
            );
          }
          if(state is SimilarproductSuccess){
            final subcatResponse = state.response.data!.products;
            if(subcatResponse.isEmpty){
              return Center(child:  TextView(text: "No product found",fontSize: 15,fontWeight: FontWeight.w500,),);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: .7,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children:  List.generate(subcatResponse.length, (index) {
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
                                        color: const Color(0xffFF4545),
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
                        }
                        ),
                      ),
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }



  void _listenToAllCatState(BuildContext context, CategoryState state) {
    // if(state is ProductsFailiureState){
    //   context.pop();
    // }
    // if(state is ProductsloadingState){
    //   CustomDialogs.showLoading(context);
    // }
    // if(state is SimilarproductSuccess){
    //   context.pop();
    // }
  }
}
