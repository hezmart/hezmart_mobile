import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/outlined_form_field.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/filled_textfield.dart';
import '../../../../core/theme/pallets.dart';

class RiderDetails extends StatefulWidget {
  const RiderDetails({super.key});

  @override
  State<RiderDetails> createState() => _RiderDetailsState();
}

class _RiderDetailsState extends State<RiderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(
          text: "Book Rider",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 1.sw,
                      height: 350,
                      decoration: BoxDecoration(
                        color: Pallets.grey90,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "John Rider",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            TextView(text: "4.5"),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green,
                        ),
                        child: TextView(
                          text: "Available",
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Icon(Icons.settings_suggest_outlined),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(text: "Experience", fontSize: 15),
                            TextView(
                              text: "6 years",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      children: [
                        Icon(Icons.settings_suggest_outlined),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(text: "Working Hours", fontSize: 15),
                            TextView(
                              text: "8:00 AM - 6:00 PM",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),

                    20.verticalSpace,
                    CustomButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextView(
                        text: "Book Rider",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      foregroundColor: Color(0xffE67002),
                      onPressed: () {
                        CustomDialogs.showCustomDialog(
                          BookRiderBottomSheeet(),
                          context,
                        );
                      },
                      bgColor: Color(0xffE67002),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    20.verticalSpace,
                    TextView(
                      text: "Customers Review",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),

                    ...List.generate(
                      4,
                      (ctx) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Iconsax.user, size: 15),
                                10.horizontalSpace,
                                TextView(
                                  text: "John Rider",
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            5.verticalSpace,
                            Row(
                              children: List.generate(
                                4,
                                (ICIndex) => Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                              ),
                            ),
                            5.verticalSpace,
                            TextView(
                              text: "Always delivers on time",
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookRiderBottomSheeet extends StatefulWidget {
  const BookRiderBottomSheeet({super.key});

  @override
  State<BookRiderBottomSheeet> createState() => _BookRiderBottomSheeetState();
}

class _BookRiderBottomSheeetState extends State<BookRiderBottomSheeet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView(
            text: "Book John Rider",
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          20.verticalSpace,
          Row(
            children: [
              Icon(Icons.radio_button_checked_outlined,),
              10.horizontalSpace,
              TextView(text: "Pick Up Location"),
            ],
          ),
          5.verticalSpace,
          FilledTextField(hint: "Pick Up Location"),
          15.verticalSpace,
          Row(
            children: [
              Icon(Icons.location_on_outlined,),
              10.horizontalSpace,
              TextView(text: "Delivery Destination"),
            ],
          ),
          5.verticalSpace,
          FilledTextField(hint: "Delivery Destination"),


          15.verticalSpace,
          TextView(text: "Receivers Name"),
          5.verticalSpace,
          FilledTextField(hint: "Receivers Name"),

          15.verticalSpace,
          TextView(text: "Receivers Number"),
          5.verticalSpace,
          FilledTextField(hint: "Receivers Number"),
          15.verticalSpace,
          TextView(text: "Note For Rider"),
          5.verticalSpace,
          FilledTextField(hint: "type......"),

          20.verticalSpace,


          CustomButton(child: TextView(text: "Continue To Payment",color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600,), onPressed: (){
            context.pop();
            CustomDialogs.showCustomDialog(PaymentBottomSheet(), context);
          },
            bgColor: Color(0xffE67002),
            borderRadius: BorderRadius.circular(30),

          ),

        ],
      ),
    );
  }
}




class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({super.key});

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(text: "Booking Summary",fontWeight: FontWeight.w500,fontSize: 16,),
              InkWell(
                onTap: (){
                  context.pop(context);
                },
                  child: Icon(Icons.cancel_rounded,color: Pallets.grey35,))
            ],
          ),

          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(text: "Total Distance"),
                  TextView(text: "22.4km",fontSize: 17,fontWeight: FontWeight.w600,),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(text: "Estimated Price"),
                  TextView(text: "5,0000",fontSize: 17,fontWeight: FontWeight.w600,),
                ],
              ),
              

            ],
          ),
          20.verticalSpace,
          Row(
            children: [
              Icon(Icons.radio_button_checked_outlined,size: 15,),
              5.horizontalSpace,
              TextView(text: "Pickup location",),
            ],
          ),
          TextView(text: "I6 texas street,Enugu",fontSize: 17,fontWeight: FontWeight.w500,),
         20.verticalSpace,
          Row(
            children: [
              Icon(Icons.location_on_outlined,size: 15,),
              5.horizontalSpace,
              TextView(text: "Destination location",),
            ],
          ),
          TextView(text: "Hezmart I6 texas street,Enugu",fontSize: 17,fontWeight: FontWeight.w500,),



          30.verticalSpace,
          CustomButton(child: TextView(text: "Pay With PayStack",color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600,), onPressed: (){
            context.pop();

          },
            bgColor: Color(0xffE67002),
            borderRadius: BorderRadius.circular(30),

          ),

          20.verticalSpace,
          CustomButton(child: TextView(text: "Cash On Delivery",fontSize: 15,fontWeight: FontWeight.w600,), onPressed: (){
            context.pop();

          },
            bgColor: Color(0xffececec),
            borderRadius: BorderRadius.circular(30),

          ),

        ],
      ),
    );
  }
}
