import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/image_widget.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class FlashSales extends StatefulWidget {
  const FlashSales({super.key});

  @override
  State<FlashSales> createState() => _FlashSalesState();
}

class _FlashSalesState extends State<FlashSales> {
  double _rating = 4.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Color(0xffFF4545),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextView(
                  text: "Weekly Sales",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
                40.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "Time Left:",
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    TextView(
                      text: "87H : 60M : 15S",
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ],
                ),
                30.horizontalSpace,
              ],
            ),
          ),
          // GridView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   padding: EdgeInsets.all(10),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     childAspectRatio: 0.7,
          //     mainAxisSpacing: 10,
          //     crossAxisSpacing: 10,
          //   ),
          //   itemCount: 6,
          //   itemBuilder: (context, index) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         border: Border.all(color: Pallets.grey95),
          //       ),
          //       child: Stack(
          //         children:[
          //           Padding(
          //             padding: const EdgeInsets.only(left: 5),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Icon(Icons.favorite_border,size: 18,),
          //                 Container(
          //                   height: 40,
          //                   width: 40,
          //                   padding: EdgeInsets.all(5),
          //                   decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10),
          //                   bottomLeft:  Radius.circular(10)),
          //                 color:Color(0xffFF4545), ),
          //                 child:
          //                   Center(child: TextView(text: "-50",color: Colors.white,fontWeight: FontWeight.w600,)),)
          //               ],
          //             ),
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               InkWell(
          //                 splashColor: Colors.transparent,
          //                 onTap: (){
          //                   context.pushNamed(PageUrl.product_details);
          //                 },
          //                 child: IgnorePointer(
          //                   child: ImageWidget(
          //                     imageUrl: "assets/images/pngs/pizza.png",
          //                     size: 150,
          //                     fit: BoxFit.cover,
          //                   ),
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 5),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     InkWell(
          //                       splashColor: Colors.transparent,
          //                       onTap: (){
          //                         context.pushNamed(PageUrl.product_details);
          //                       },
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           TextView(text: "Pizza Pack, Family size",fontSize: 13,),
          //                           Row(
          //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               TextView(text: "₦5,000",fontWeight: FontWeight.w700,),
          //                               TextView(text: "₦7,000"),
          //                             ],
          //                           ),
          //                           Row(
          //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               TextView(text: "10 units left",fontWeight: FontWeight.w300,fontSize: 10,),
          //                               RatingBar.builder(
          //                                 initialRating: 4,
          //                                 minRating: 1,
          //                                 direction: Axis.horizontal,
          //                                 itemSize: 16,
          //                                 allowHalfRating: false,
          //                                 itemCount: 5,
          //                                 unratedColor: Pallets.grey90,
          //                                 itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
          //                                 itemBuilder: (context, _) => const Icon(
          //                                   Icons.star_border_outlined,
          //                                   color: Colors.amber,
          //                                   size: 14,
          //                                 ),
          //                                 onRatingUpdate: (rating) {
          //                                   print(rating);
          //                                   setState(() {
          //                                     setState(() {
          //                                       _rating = rating;
          //                                     });
          //                                   });
          //                                 },
          //                               )
          //                             ],
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                     6.verticalSpace,
          //
          //                     LinearProgressBar(
          //                       maxSteps: 6,
          //                       progressType: LinearProgressBar.progressTypeLinear, // Use Linear progress
          //                       currentStep: 1,
          //                       progressColor: Pallets.successGreen,
          //                       backgroundColor: Pallets.grey95,
          //                       borderRadius: BorderRadius.circular(10),
          //                     ),
          //                     6.verticalSpace,
          //                     Container(
          //                       padding: EdgeInsets.all(5),
          //                       decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(20),
          //                           gradient: LinearGradient(colors: [
          //                             Color(0xffE67002),
          //                             Color(0xff992002),
          //                           ])
          //                       ),
          //                       child: Row(
          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           TextView(text: "Add to cart",fontSize: 10,color: Colors.white,fontWeight: FontWeight.w600,),Icon(Icons.add_shopping_cart,size: 14,color: Colors.white,)
          //                         ],
          //                       ),),
          //                   ],
          //                 ),
          //               )
          //             ],
          //           ),
          //         ]
          //       ),
          //     );
          //   },
          // ),

          GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [],
          )
        ],
      ),
    );
  }
}

