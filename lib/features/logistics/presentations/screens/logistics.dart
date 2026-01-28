import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/theme/pallets.dart';

import '../../../../common/widgets/custom_appbar.dart';
import '../../../../common/widgets/text_view.dart';

class LogisticsAndDelivery extends StatefulWidget {
  const LogisticsAndDelivery({super.key});

  @override
  State<LogisticsAndDelivery> createState() => _LogisticsAndDeliveryState();
}

class _LogisticsAndDeliveryState extends State<LogisticsAndDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(
          text: "Delivery And Logistics",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                width: 1.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffE67002),
                ),
                child: Column(
                  children: [
                    TextView(
                      text: "Fast & Reliable Delivery\n Riders",
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      align: TextAlign.center,
                    ),
                    20.verticalSpace,
                    TextView(
                      text:
                          'Connect with our to rated professional riders for your instant delivery.',
                      color: Colors.white,
                      align: TextAlign.center,
                      fontSize: 15,
                    ),
                    5.verticalSpace,
                    TextView(
                      text: 'Safety and speed guaranteed for every package.',
                      color: Colors.white,
                      align: TextAlign.center,
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              TextView(
                text: "Available Riders Nearby",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              Column(
                children: List.generate(
                  4,
                  (ctx) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
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

                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
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
                              ],
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
                          10.verticalSpace,
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
                              context.pushNamed(PageUrl.rider_details);
                            },
                            bgColor: Color(0xffE67002),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
