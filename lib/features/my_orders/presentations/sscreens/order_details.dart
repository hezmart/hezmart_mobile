import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/core/di/injector.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/features/my_orders/data/data/order_repo_impl/ordeer_repository_impl.dart';
import 'package:hezmart/features/my_orders/presentations/order_bloc/order_bloc.dart';
import 'package:hezmart/features/my_orders/presentations/sscreens/track_myoder.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/custom_appbar.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/outlined_form_field.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/theme/pallets.dart';
import '../../data/models/review.dart';

class OrderDetails extends StatefulWidget {
  final String id;
  const OrderDetails({super.key, required this.id});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final bloc = OrderBloc(OrderRepositoryImpl(NetworkService()));

  @override
  void initState() {
    // TODO: implement initState
    bloc.add(SingleOrdersEvent(widget.id));
    super.initState();
  }

  String formattedDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "N/A";
    try {
      final DateTime parsedDate = DateTime.parse(dateString);
      return DateFormat("dd MMM, yyyy  hh:mm a").format(parsedDate);
    } catch (e) {
      return "Invalid date";
    }
  }

  String formatNumberWithCommas(String number) {
    try {
      final parsedNumber = double.parse(number.replaceAll(',', ''));
      return parsedNumber
          .toStringAsFixed(0)
          .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          );
    } catch (e) {
      return number;
    }
  }

  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(
          text: "Order Details",
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          child: BlocConsumer<OrderBloc, OrderState>(
            bloc: bloc,
            listener: _listenToSinglState,
            builder: (context, state) {
              if (state is OrderFailiureState) {
                return Center(
                  child: AppPromptWidget(
                    onTap: () {
                      bloc.add(SingleOrdersEvent(widget.id));
                    },
                  ),
                );
              }
              if (state is SingleOrderSuccesState) {
                final singleresponse = state.reponse.data?.order;
                final singler = state.reponse.data;
                final createdAt =
                    state.reponse.data?.order?.items.first.createdAt;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            TextView(text: "Order Id : ", fontSize: 12),
                            TextView(
                              text: singleresponse?.orderNumber ?? '',
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        // singleresponse?.status=="pending"||singleresponse?.status=="processing"?
                        // TextView(
                        //   text: "Track Item",
                        //   onTap: () {
                        //     context.pushNamed(PageUrl.track_order,   queryParameters: {PathParam.email: singleresponse?.status});
                        //     // CustomDialogs.showBottomSheet(context, TrackingMyOrder(status: '',
                        //     //   shippingAddress: singleresponse?.deliveryOption == "pickup"
                        //     //       ? null
                        //     //       : singler?.order?.deliveryAddress,
                        //     //   pickupStationDetails: singleresponse?.deliveryOption == "door"
                        //     //       ? singler?.order?.pickupStationDetails
                        //     //       : null,
                        //     // )
                        //     // );
                        //   },
                        // ):SizedBox(),
                      ],
                    ),
                    5.verticalSpace,

                    Row(
                      children: [
                        TextView(text: "Ordered on :  ", fontSize: 12),
                        TextView(
                          text:
                              "${createdAt is DateTime ? DateFormat('d MMMM y hh:mm a').format(createdAt) : 'Unknown date'}",
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        TextView(text: "Total Amount"),
                        10.horizontalSpace,
                        Text(
                          "₦${formatNumberWithCommas(state.reponse.data?.order?.total ?? '' )}",
                        ),
                      ],
                    ),

                    20.verticalSpace,
                    Container(
                      width: 1.sw,
                      padding: EdgeInsets.all(10),
                      color: Pallets.grey95,
                      child: TextView(text: "Items In Your Order"),
                    ),
                    20.verticalSpace,
                    ...List.generate(
                      singleresponse!.items.length,
                      (itemIndex) => Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              10.verticalSpace,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height:
                                        singleresponse
                                                .items[itemIndex]
                                                .product!
                                                .reviews
                                                .isNotEmpty
                                            ? 150
                                            : 100,
                                    width: 120,
                                    child: ImageWidget(

                                      onTap: () {
                                        context.pushNamed(
                                          PageUrl.product_details,
                                          queryParameters: {
                                            PathParam.id:
                                            singleresponse
                                                ?.items[itemIndex]
                                                .product?.id.toString()
                                          },
                                        );
                                      },
                                      imageUrl:
                                          singleresponse
                                              ?.items[itemIndex]
                                              .product
                                              ?.coverImage ??
                                          '',
                                      width:200,
                                      height: 100,
                                      fit: BoxFit.scaleDown,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  5.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text:
                                              singleresponse
                                                  ?.items[itemIndex]
                                                  .product
                                                  ?.name ??
                                              '',
                                          maxLines: 2,
                                        ),
                                        4.verticalSpace,

                                        TextView(
                                          text:
                                              "QTY: ${singleresponse?.items[itemIndex].quantity ?? ''}",
                                        ),
                                        4.verticalSpace,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color:
                                                    singleresponse
                                                                    .items[itemIndex]
                                                                    .fulfillmentStatus ==
                                                                "delivered" ||
                                                            singleresponse
                                                                    .items[itemIndex]
                                                                    .fulfillmentStatus ==
                                                                "completed" ||
                                                            singleresponse
                                                                    .items[itemIndex]
                                                                    .fulfillmentStatus ==
                                                                "received"
                                                        ? Pallets.successGreen
                                                        : Pallets.grey,
                                              ),
                                              child: TextView(
                                                text:
                                                    singleresponse
                                                        .items[itemIndex]
                                                        .fulfillmentStatus!
                                                        .toUpperCase()
                                                        .toString(),
                                                color: Pallets.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            singleresponse
                                                            .items[itemIndex]
                                                            .fulfillmentStatus ==
                                                        "completed" ||
                                                    singleresponse
                                                                .items[itemIndex]
                                                                .fulfillmentStatus ==
                                                            "received" &&
                                                        singleresponse
                                                            .items[itemIndex]
                                                            .product!
                                                            .reviews
                                                            .isEmpty
                                                ? TextView(
                                                  text: "Rate Item",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffE67002),
                                                  onTap: () {
                                                    CustomDialogs.showBottomSheet(
                                                      context,
                                                      ReviewBottomSheet(
                                                        userId:
                                                            singleresponse
                                                                .userId
                                                                .toString(),
                                                        productid:
                                                            singleresponse
                                                                .items[itemIndex]
                                                                .product!
                                                                .id
                                                                .toString(),
                                                      ),
                                                    );
                                                  },
                                                )
                                                : SizedBox(),
                                          ],
                                        ),

                                        if ((singleresponse
                                                        .items[itemIndex]
                                                        .fulfillmentStatus ==
                                                    "delivered" ||
                                                singleresponse
                                                        .items[itemIndex]
                                                        .fulfillmentStatus ==
                                                    "completed" ||
                                                singleresponse
                                                        .items[itemIndex]
                                                        .fulfillmentStatus ==
                                                    "received") &&
                                            singleresponse
                                                .items[itemIndex]
                                                .product!
                                                .reviews
                                                .isNotEmpty)
                                          ExpansionTile(
                                            childrenPadding: EdgeInsets.all(0),
                                            tilePadding:
                                                const EdgeInsets.symmetric(
                                                  vertical: 0,
                                                  horizontal: 0,
                                                ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            expandedAlignment:
                                                Alignment.centerLeft,
                                            title: TextView(
                                              text: "View review",
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.onBackground,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            trailing: Icon(
                                              clicked
                                                  ? Icons.arrow_drop_up
                                                  : Icons.arrow_right,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.onBackground,
                                            ),
                                            expandedCrossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextView(
                                                text:
                                                    singleresponse
                                                        .items[itemIndex]
                                                        .product!
                                                        .reviews
                                                        .first
                                                        .review ??
                                                    '',
                                              ),
                                              3.verticalSpace,
                                              Row(
                                                children: List.generate(
                                                  singleresponse
                                                          .items[itemIndex]
                                                          .product!
                                                          .reviews
                                                          .first
                                                          .rating
                                                          ?.toInt() ??
                                                      0,
                                                  (index) => const Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            onExpansionChanged: (
                                              bool isChanged,
                                            ) {
                                              setState(() {
                                                clicked = isChanged;
                                              });
                                            },
                                          ),

                                        // singleresponse
                                        //     ?.items[itemIndex]
                                        //     .fulfillmentStatus =="cancelled"|| singleresponse
                                        //     ?.items[itemIndex]
                                        //     .fulfillmentStatus =="returned" ?SizedBox():GestureDetector(
                                        //   onTap: () {
                                        //     CustomDialogs.showBottomSheet(
                                        //       context,
                                        //       TrackingMyOrder(
                                        //         status:
                                        //             singleresponse
                                        //                 ?.items[itemIndex]
                                        //                 .fulfillmentStatus ??
                                        //             '',
                                        //         shippingAddress: singler
                                        //                     ?.order
                                        //                     ?.deliveryAddress,
                                        //         pickupStationDetails: singler
                                        //                     ?.order
                                        //                     ?.pickupStationDetails,
                                        //         method: singleresponse?.deliveryOption??'',
                                        //         name: singler
                                        //             ?.order
                                        //             ?.pickupStationDetails?.name??'' ,
                                        //       ),
                                        //     );
                                        //   },
                                        //   child: Row(
                                        //     children: [
                                        //       TextView(
                                        //         text: "Track Item",
                                        //         fontSize: 13,
                                        //       ),
                                        //       5.horizontalSpace,
                                        //       Icon(Icons.my_location, size: 17),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Container(
                      width: 1.sw,
                      padding: EdgeInsets.all(10),
                      color: Pallets.grey95,
                      child: TextView(text: "Payment Information"),
                    ),
                    10.verticalSpace,
                    TextView(
                      text: "Payment Method",
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                    5.verticalSpace,
                    TextView(
                      text: singleresponse?.paymentMethod?.toUpperCase() ?? '',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    Row(
                      children: [
                        TextView(text: "Status : ", fontSize: 12),
                        TextView(
                          text:
                              singleresponse?.paymentStatus?.toUpperCase() ??
                              '',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    TextView(
                      text: "Payment Details",
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                    Row(
                      children: [
                        TextView(text: "Item(s) total : "),
                        Text(
                          "₦${formatNumberWithCommas(state.reponse.data?.order?.subtotal ?? '' )}",
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        TextView(text: "Delivery fee : "),
                        Text(
                          "₦${formatNumberWithCommas(state.reponse.data?.order?.deliveryFee ?? '')}",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextView(text: "Discount fee : "),
                        Text(
                          "₦${formatNumberWithCommas(state.reponse.data?.order?.discount ?? '')}",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextView(text: "Total : "),
                        Text(
                          "₦${formatNumberWithCommas(state.reponse.data?.order?.total ?? '')}",
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Container(
                      width: 1.sw,
                      padding: EdgeInsets.all(10),
                      color: Pallets.grey95,
                      child: TextView(text: "Delivery Information"),
                    ),
                    10.verticalSpace,
                    TextView(
                      text: "Delivery Method",
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                    Row(
                      children: [
                        TextView(
                          text: "Delivery Method : ",
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                        TextView(
                          text:
                              singleresponse?.deliveryOption?.toUpperCase() ??
                              '',
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    singleresponse?.deliveryOption == "pickup"
                        ? TextView(
                          text: "Pick Up Station",
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        )
                        : TextView(text: "User Pickup Address"),
                    singleresponse?.deliveryOption == "pickup"
                        ? Column(
                          children: [
                            Row(
                              children: [
                                TextView(text: "State:"),
                                4.horizontalSpace,
                                TextView(
                                  text:
                                      singler
                                          ?.order
                                          ?.pickupStationDetails
                                          ?.state ??
                                      '',
                                ),
                              ],
                            ),
                            5.verticalSpace,
                            Row(
                              children: [
                                TextView(text: "Station:"),
                                4.horizontalSpace,
                                TextView(
                                  text:
                                      singler
                                          ?.order
                                          ?.pickupStationDetails
                                          ?.name ??
                                      '',
                                ),
                              ],
                            ),
                            5.verticalSpace,
                            Row(
                              children: [
                                TextView(text: "Address:"),
                                4.horizontalSpace,
                                Expanded(
                                  child: TextView(
                                    text:
                                        singler
                                            ?.order
                                            ?.pickupStationDetails
                                            ?.address ??
                                        '',
                                  ),
                                ),
                              ],
                            ),

                            5.verticalSpace,
                            Row(
                              children: [
                                TextView(text: "Contact:"),
                                4.horizontalSpace,
                                TextView(
                                  text:
                                      singler
                                          ?.order
                                          ?.pickupStationDetails
                                          ?.contactPhone ??
                                      '',
                                ),
                              ],
                            ),
                            5.verticalSpace,
                            Row(
                              children: [
                                TextView(text: "Pick up fee:"),
                                4.horizontalSpace,
                                Text(
                                  "₦${formatNumberWithCommas(singler?.order?.pickupStationDetails?.fee.toString() ?? '')}",
                                ),
                              ],
                            ),
                          ],
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // TextView(
                                //   text: "State : ",
                                //   fontWeight: FontWeight.w400,
                                //   fontSize: 13,
                                // ),
                                TextView(
                                  text:
                                      singleresponse?.deliveryAddress?.state ??
                                      '',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // TextView(
                                //   text: "Name : ",
                                //   fontWeight: FontWeight.w400,
                                //   fontSize: 13,
                                // ),
                                TextView(
                                  text:
                                      "${singleresponse?.deliveryAddress?.firstName ?? ''} ${singleresponse?.deliveryAddress?.lastName ?? ''}",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // TextView(
                                //   text: "Email : ",
                                //   fontWeight: FontWeight.w400,
                                //   fontSize: 13,
                                // ),
                                TextView(
                                  text:
                                      singleresponse?.deliveryAddress?.email ??
                                      '',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // TextView(
                                //   text: "Phone Number : ",
                                //   fontWeight: FontWeight.w400,
                                //   fontSize: 13,
                                // ),
                                TextView(
                                  text:
                                      singleresponse
                                          ?.deliveryAddress
                                          ?.primaryPhone ??
                                      '',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // TextView(
                                //   text: "Address : ",
                                //   fontWeight: FontWeight.w400,
                                //   fontSize: 13,
                                // ),
                                Expanded(
                                  child: TextView(
                                    text:
                                        singleresponse
                                            ?.deliveryAddress
                                            ?.primaryAddress ??
                                        '',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    15.verticalSpace,
                    // TextView(
                    //   text: "Shipping Details",
                    //   fontWeight: FontWeight.w500,
                    //   fontSize: 17,
                    // ),
                    // 5.verticalSpace,
                    // TextView(text: "Pickup station.Fulfilled by Cent Store"),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  void _listenToSinglState(BuildContext context, OrderState state) {
    if (state is OrderLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is OrderFailiureState) {
      context.pop();
    }
    if (state is SingleOrderSuccesState) {
      context.pop();
    }
  }
}

class ReviewBottomSheet extends StatefulWidget {
  final String productid;
  final String userId;

  const ReviewBottomSheet({
    super.key,
    required this.productid,
    required this.userId,
  });

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  final commentController = TextEditingController();
  final _key = GlobalKey<FormState>();
  double _rating = 0.0;
  final bloc = OrderBloc(OrderRepositoryImpl(NetworkService()));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Pallets.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextView(
                  text: "Leave a Review",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.cancel_rounded),
                ),
              ],
            ),
            16.verticalSpace,
            const Divider(color: Pallets.grey75),
            16.verticalSpace,
            const TextView(
              text: "Rate the product and delivery ?",
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            const TextView(
              text: "Please give your rating and also your review.",
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            20.verticalSpace,
            Center(
              child: RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                itemSize: 25,
                allowHalfRating: false,
                itemCount: 5,
                unratedColor: Pallets.grey90,
                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                itemBuilder:
                    (context, _) => const Icon(
                      Icons.star_border_outlined,
                      color: Colors.amber,
                      size: 18,
                    ),
                onRatingUpdate: (rating) {
                  print(rating);
                  setState(() {
                    setState(() {
                      _rating = rating;
                    });
                  });
                },
              ),
            ),
            20.verticalSpace,
            const TextView(text: "Leave a review"),
            OutlinedFormField(
              hint: "Enter your message",
              controller: commentController,
              maxLine: 4,
            ),
            20.verticalSpace,

            BlocConsumer<OrderBloc, OrderState>(
              listener: _listenToReviewState,
              bloc: bloc,
              builder: (context, state) {
                return CustomButton(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: const TextView(
                    text: "Submit",
                    color: Pallets.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () {
                    reviewNow();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void reviewNow() {
    if (_rating == 0.0) {
      CustomDialogs.error("Please rate before submitting.");
      return;
    }
    if (commentController.text.isEmpty) {
      CustomDialogs.error("Please comment before submitting.");
      return;
    }

    bloc.add(
      ReviewOrdersEvent(
        ReviewPayload(
          rating: _rating,
          review: commentController.text.trim(),
          productId: widget.productid.toString(),
          userId: widget.userId.toString(),
        ),
      ),
    );
  }

  void _listenToReviewState(BuildContext context, OrderState state) {
    if (state is OrderLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is OrderFailiureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is RateOrderSuccesState) {
      context.pop();
      CustomDialogs.success("Thanks for your review");
      context.pop();
    }
  }
}

// CustomDialogs.showBottomSheet(context, TrackingMyOrder(status:  singleresponse?.items[itemIndex].fulfillmentStatus??'',
// shippingAddress: singleresponse?.deliveryOption == "pickup"
// ? null
//     : singler?.order?.deliveryAddress,
// pickupStationDetails: singleresponse?.deliveryOption == "door"
// ? singler?.order?.pickupStationDetails
// : null,
// ));
