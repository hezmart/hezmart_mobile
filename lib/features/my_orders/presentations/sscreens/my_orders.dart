import 'package:flutter/material.dart';
import 'package:hezmart/features/my_orders/presentations/sscreens/ongoing.dart';
import 'package:hezmart/features/my_orders/presentations/sscreens/returned.dart';

import '../../../../common/widgets/custom_appbar.dart';
import '../../../../common/widgets/text_view.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          // bgColor: Colors.black,
            tittle: TextView(text: "My Orders", fontSize: 16)),
        body: Column(
          children: [
            TabBar(
              padding: EdgeInsets.only(top: 0),
              tabAlignment: TabAlignment.fill,
              indicatorSize:TabBarIndicatorSize.tab ,
              labelPadding: EdgeInsets.only(bottom: 5),
              indicatorColor: Color(0xff700704),
              dividerColor: Colors.transparent,
              labelColor: Color(0xff700704),
              unselectedLabelColor: Colors.black,
              tabs: [
                TextView(text: "Ongoing/Delivered"),
                // TextView(text: "Delivered"),
                TextView(text: "Cancelled/Returned"),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Ongoing(),
                  // DeliveredOrder(),
                  Returned(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
