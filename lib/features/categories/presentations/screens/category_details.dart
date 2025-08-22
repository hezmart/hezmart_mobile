import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/text_view.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/theme/pallets.dart';
class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(text: "Phones And Tech",fontSize: 18,fontWeight: FontWeight.w500,),
      ),
      body:  SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
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
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                              bottomLeft:  Radius.circular(10)),
                            color:Color(0xff3567A6), ),
                          child:
                          Center(child: TextView(text: "50% Off",color: Colors.white,fontWeight: FontWeight.w400,align: TextAlign.center,fontSize: 10,)),)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: (){
                            context.pushNamed(PageUrl.product_details);
                          },
                          child: IgnorePointer(
                            child: ImageWidget(
                              imageUrl: "assets/images/pngs/pizza.png",
                              size: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: (){
                                  context.pushNamed(PageUrl.product_details);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(text: "Pizza Pack, Family size",fontSize: 13,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextView(text: "₦5,000",fontWeight: FontWeight.w700,),
                                        TextView(text: "₦7,000"),
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
                                                // _rating = rating;
                                              });
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              3.verticalSpace,
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
    );
  }
}
