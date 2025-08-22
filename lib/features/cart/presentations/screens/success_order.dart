import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/image_widget.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/navigation/route_url.dart';
class SuccessOrder extends StatefulWidget {
  const SuccessOrder({super.key});

  @override
  State<SuccessOrder> createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 40.verticalSpace,
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: (){
            //         context.goNamed(PageUrl.home);
            //       },
            //         child: Icon(Iconsax.arrow_left,size: 18,))
            //   ],
            // ),
            // 80.verticalSpace,
            Center(child: IgnorePointer(child: ImageWidget(imageUrl: "assets/images/pngs/success.png",size: 200,))),
            10.verticalSpace,
            TextView(text: "Order placed successful",fontSize: 16,),
            TextView(text: "Your order have been placed successful ",fontSize: 12,align: TextAlign.center,),
            5.verticalSpace,
            TextView(text: "See Order",fontSize: 14,fontWeight:FontWeight.w600,align: TextAlign.center,color: Color(0xff0ffE67002),onTap: (){
              context.goNamed(PageUrl.profile);
            },),
            30.verticalSpace,
            CustomButton(child: TextView(text: "Continue Shopping",fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,), onPressed: (){
              context.goNamed(PageUrl.home);

            })


          ],
        ),
      ),
    );
  }
}
