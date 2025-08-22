import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/image_widget.dart';
import 'package:hezmart/common/widgets/text_view.dart';
class WeeklyOffer extends StatefulWidget {
  const WeeklyOffer({super.key});

  @override
  State<WeeklyOffer> createState() => _WeeklyOfferState();
}

class _WeeklyOfferState extends State<WeeklyOffer> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.only(top: 10,left: 10),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(text: "Weekly offer",color: Colors.white,fontSize: 12,),
                TextView(text: "Snacks at discount\nprices",color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17,),
              20.verticalSpace,
                TextView(text: "Shop from us....",fontSize: 11,color: Colors.white,),
             5.verticalSpace,
             Container(
               width: 100,
               padding: EdgeInsets.all(4),
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextView(text: "shop now",fontSize: 11,),
                 Icon(Icons.arrow_forward,size: 12,)
               ],
             ),),
                10.verticalSpace,
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 0,top: 10),
              child: ImageWidget(imageUrl: "assets/images/pngs/snacks.png",size: 130,borderRadius: BorderRadius.only(bottomRight:Radius.circular(10)),),
            )
          ],
        ),
      ),
    );
  }
}
