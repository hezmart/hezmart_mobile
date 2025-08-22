import 'package:flutter/material.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/theme/pallets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(text: "Notifications", fontSize: 18),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffFCF4ED),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: "Limited Time Offer Just for You",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          TextView(
                            text: "20-11-24",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Pallets.grey35,
                          ),
                        ],
                      ),
                      TextView(
                        text:
                            "Don't miss out! Get 20% off all electronics when you shop today. Use code SAVE20 at checkout. Hurry, this offer ends at midnight!",
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
