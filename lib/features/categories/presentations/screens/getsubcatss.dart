import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/empty_state.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/services/network/network_service.dart';
import '../../../../core/theme/pallets.dart';
import '../../../homescreen/presentations/screens/homescreen.dart';
import '../../data/data/category_repo_impl/category_repo.dart';
import '../category_bloc/category_bloc.dart';

class SubCatParams {
  String catId;
  String subcatId;
  String name;

  SubCatParams(this.catId, this.subcatId,this.name);
}

class Getsubcatss extends StatefulWidget {
  final String catId;
  final String subcatId;
  final String name;
  const Getsubcatss({super.key, required this.catId, required this.subcatId, required this.name});

  @override
  State<Getsubcatss> createState() => _GetsubcatssState();
}

class _GetsubcatssState extends State<Getsubcatss> {
  final subcat = CategoryBloc(CategoryRepositoryImpl(NetworkService()));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subcat.add(SubCategoryEvent(widget.catId, widget.subcatId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(tittle: TextView(text: widget.name,fontSize: 17,fontWeight: FontWeight.w600,),),
      body: SingleChildScrollView(

        child: BlocConsumer<CategoryBloc, CategoryState>(
          bloc: subcat,
          listener: _listenToSubcatState,
          builder: (context, state) {
            if(state is CategoryfailiureState){
              return Center(child: AppPromptWidget(
                onTap: (){
                  subcat.add(SubCategoryEvent(widget.catId, widget.subcatId));
                },
              ));
            }
            if(state is SubCategorySuccessState){
              final subcatResponse=state.response.data!.products;
              if(subcatResponse.isEmpty){
                return EmptyState(imageUrl: "",title: "No products available",);
                  // Center(child:  TextView(text: "No product available",fontSize: 15,fontWeight: FontWeight.w500,),);

              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 60, left: 10, right: 10),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: .7,
                  ),
                  physics: NeverScrollableScrollPhysics(),

                  shrinkWrap: true,
                  children: List.generate(subcatResponse.length, (index) {
                    int calculateDiscountPercentage(
                        String price,
                        String discountPrice,
                        ) {
                      final double originalPrice = double.tryParse(price) ?? 0;
                      final double discountedPrice =
                          double.tryParse(discountPrice) ?? 0;

                      if (discountedPrice <= 0 ||
                          discountedPrice >= originalPrice)
                        return 0;

                      return ((1 - discountedPrice / originalPrice) * 100)
                          .round();
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
                                        queryParameters: {PathParam.id:subcatResponse![index].id.toString()
                                          }
                                    //
                                        );
                                  },
                                  child: Center(
                                    child: IgnorePointer(
                                      child: ImageWidget(


                                        imageUrl: subcatResponse![index].coverImage
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        context.pushNamed(
                                            PageUrl.product_details,
                                            queryParameters: {PathParam.id:subcatResponse[index].id.toString() }
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                            maxLines: 2,
                                            textOverflow: TextOverflow.ellipsis,
                                            text: subcatResponse?[index].name ?? '',
                                            fontSize: 13,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "₦${formatNumberWithCommas(subcatResponse[index].discountPrice??'')}",
                                               style: TextStyle( fontWeight: FontWeight.w700,),
                                              ),
                                              Text(
                                                "₦${formatNumberWithCommas(subcatResponse[index].price??'')}",
                                                style: TextStyle(  decoration:
                                                TextDecoration.lineThrough,
                                                  fontSize: 12,),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              RatingBar.builder(
                                                ignoreGestures: true,
                                                initialRating:
                                                double.tryParse( subcatResponse[index].ratingsAverage.toString())!.toDouble(),
                                                direction: Axis.horizontal,
                                                itemSize: 16,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                unratedColor: Pallets.grey90,
                                                itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 0.0,
                                                ),
                                                itemBuilder:
                                                    (context, _) => const Icon(
                                                  Icons.star_border_outlined,
                                                  color: Colors.amber,
                                                  size: 14,
                                                ),
                                                onRatingUpdate: (double value) {},
                                                // onRatingUpdate: (rating) {
                                                //   print(rating);
                                                //   setState(() {
                                                //     setState(() {
                                                //       // _rating = rating;
                                                //     });
                                                //   });
                                                // },
                                              ),
                                              5.horizontalSpace,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    6.verticalSpace,

                                    StockIndicator(stockQuantity: subcatResponse[index].stockQuantity,),

                                    5.verticalSpace,
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                4.horizontalSpace,
                                // CircleAvatar(
                                //   backgroundColor: Pallets.white,
                                //   radius: 16,
                                //     child: Icon(Icons.favorite_border, size: 18)),
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
                                      text:
                                      "${calculateDiscountPercentage(subcatResponse[index].price.toString(),subcatResponse[index].discountPrice.toString())}% OFF",
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
              );
            }
         return SizedBox();
          },
        ),
      ),
    );
  }

  void _listenToSubcatState(BuildContext context, CategoryState state) {
    if(state is CategoryloadinggState){
      CustomDialogs.showLoading(context);
    }
    if(state is CategoryfailiureState){
      context.pop();
    }
    if(state is SubCategorySuccessState){
      context.pop();
    }
  }
}
