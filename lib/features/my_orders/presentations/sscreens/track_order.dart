import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/error_widget.dart';
import '../../../../core/services/network/network_service.dart';
import '../../data/data/order_repo_impl/ordeer_repository_impl.dart';
import '../../data/models/single_order.dart';

import '../order_bloc/order_bloc.dart';

class TrackOrder extends StatefulWidget {
  final String status;
  final DeliveryAddress? shippingAddress;
  final PickupStationDetails? pickupStationDetails;

  TrackOrder({super.key, required this.status, this.shippingAddress, this.pickupStationDetails});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  final bloc = OrderBloc(OrderRepositoryImpl(NetworkService()));

  final stepTitles = [
    "Order Placed",
    "Pending Payment Confirmation",
    "Processing",
    "Shipped",
    "Delivered",
  ];

  @override
  Widget build(BuildContext context) {
    int getCurrentStatusIndex(String status) {
      final lowerStatus = status.toLowerCase();
      if (lowerStatus == 'pending') return 1;
      if (lowerStatus == 'processing') return 2;
      if (lowerStatus == 'shipped') return 3;
      if (lowerStatus == 'delivered' || lowerStatus == 'received' || lowerStatus == 'completed') return 4;
      return 0; // Default to "Order Placed"
    }

    final currentIndex = getCurrentStatusIndex(widget.status);

    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(
          text: "Order Status",
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: stepTitles.length,
                itemBuilder: (context, index) {
                  final isCompleted = index <= currentIndex;
                  final isCurrentStep = index == currentIndex;

                  return TimelineTile(
                    alignment: TimelineAlign.start,
                    isFirst: index == 0,
                    isLast: index == stepTitles.length - 1,
                    beforeLineStyle: LineStyle(
                      color: isCompleted ? Pallets.successGreen : Colors.grey,
                      thickness: 3,
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 30,
                      color: isCompleted ? Pallets.successGreen : Colors.grey,
                      iconStyle: IconStyle(
                        iconData: isCompleted ? Icons.check : Icons.radio_button_unchecked,
                        color: Colors.white,
                      ),
                    ),
                    endChild: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stepTitles[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isCompleted ? Colors.black : Colors.grey,
                            ),
                          ),
                          if (isCurrentStep)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                _getStatusDescription(widget.status),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    "Current Status: ${widget.status.capitalize()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  12.verticalSpace,
                  Text(
                    _getStatusMessage(widget.status),
                    textAlign: TextAlign.center,
                  ),
                  16.verticalSpace,
                  const Divider(),
                  8.verticalSpace,
                  TextButton(
                    onPressed: () {
                      context.pushNamed(PageUrl.track_item);
                    },
                    child: const Text(
                      "Track Your Package Here",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusDescription(String status) {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus == 'pending') return 'Waiting for payment confirmation';
    if (lowerStatus == 'processing') return 'Preparing your order for shipment';
    if (lowerStatus == 'shipped') return 'On its way to you';
    if (lowerStatus == 'delivered' || lowerStatus == 'received' || lowerStatus == 'completed') {
      return 'Order successfully delivered';
    }
    return 'Order has been placed';
  }

  String _getStatusMessage(String status) {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus == 'pending') {
      return 'We are waiting for your payment confirmation. '
          'Your order will be processed once payment is verified.';
    }
    if (lowerStatus == 'processing') {
      return 'Your order is being prepared for shipment. '
          'We will notify you when it\'s on its way.';
    }
    if (lowerStatus == 'shipped') {
      return 'Your package is on the way! '
          'Expected delivery date will be updated soon.';
    }
    if (lowerStatus == 'delivered' || lowerStatus == 'received' || lowerStatus == 'completed') {
      return 'Thank you for your order! We hope you enjoy your purchase.';
    }
    return 'Your order has been received and will be processed shortly.';
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}


class StatusItem {
  final String title;
  final bool isActive;

  StatusItem(this.title,  this.isActive);
}