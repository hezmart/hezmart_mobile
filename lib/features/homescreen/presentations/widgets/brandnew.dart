import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/theme/pallets.dart';
class Brandnew extends StatefulWidget {
  const Brandnew({super.key});

  @override
  State<Brandnew> createState() => _BrandnewState();
}

class _BrandnewState extends State<Brandnew> {
  double _rating = 4.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          color: Pallets.successGreen,
          child:Center(
            child: TextView(
              text: "Brand New",
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        5.verticalSpace,
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.86,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Pallets.grey95),
                ),
                child: Stack(
                    children:[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.favorite_border,size: 18,),
                          Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                                bottomLeft:  Radius.circular(10)),
                              color:Pallets.successGreen, ),
                            child:
                            Center(child: TextView(text: "new",color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12,)),)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              context.pushNamed(PageUrl.product_details);
                            },
                            child: IgnorePointer(
                              child: ImageWidget(
                                onTap: (){
                                  context.pushNamed(PageUrl.product_details);
                                },
                                imageUrl: "assets/images/pngs/phone.png",
                              size: 100,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    context.pushNamed(PageUrl.product_details);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextView(text: "Samsung Galaxy A06",fontSize: 13,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextView(text: "₦150,000",fontWeight: FontWeight.w700,),
                                          TextView(text: "₦40,000"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextView(text: "10 units left",fontWeight: FontWeight.w300,fontSize: 10,),
                                          RatingBar.builder(
                                            initialRating: 4,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            itemSize: 16,
                                            allowHalfRating: false,
                                            itemCount: 5,
                                            unratedColor: Pallets.grey90,
                                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                            itemBuilder: (context, _) => const Icon(
                                              Icons.star_border_outlined,
                                              color: Colors.amber,
                                              size: 14,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                              setState(() {
                                                setState(() {
                                                  _rating = rating;
                                                });
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                6.verticalSpace,

                                LinearProgressBar(
                                  maxSteps: 6,
                                  progressType: LinearProgressBar.progressTypeLinear, // Use Linear progress
                                  currentStep: 1,
                                  progressColor: Pallets.successGreen,
                                  backgroundColor: Pallets.grey95,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                6.verticalSpace,
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(colors: [
                                        Color(0xffE67002),
                                        Color(0xff992002),
                                      ])
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextView(text: "Add to cart",fontSize: 10,color: Colors.white,fontWeight: FontWeight.w600,),Icon(Icons.add_shopping_cart,size: 14,color: Colors.white,)
                                    ],
                                  ),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ]
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
