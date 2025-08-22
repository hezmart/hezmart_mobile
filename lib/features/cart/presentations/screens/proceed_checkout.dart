import 'package:clipboard/clipboard.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/image_widget.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/di/injector.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/features/authentication/presentations/user_bloc/user_bloc.dart';
import 'package:hezmart/features/cart/data/data/cart_repo_impl.dart';
import 'package:hezmart/features/cart/data/models/cartitems_response.dart';
import 'package:hezmart/features/cart/data/models/couponpayload.dart';
import 'package:hezmart/features/cart/data/models/pickup_delivery_payload.dart';
import 'package:hezmart/features/cart/presentations/cartbloc/cart_bloc.dart';
import 'package:hezmart/features/cart/presentations/screens/cash_success_order.dart';
import 'package:hezmart/features/payment_order/data/data/order_payment_repo_impl.dart';
import 'package:hezmart/features/payment_order/domain/order_payment_repo.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/error_widget.dart';
import '../../../../common/widgets/filled_textfield.dart';
import '../../../../core/theme/pallets.dart';
import '../../../../core/utils/helper_utils.dart';
import '../../../payment_order/boc/order_payment_bloc.dart';
import '../../data/models/crytpo_response.dart';
import '../../data/models/statebiling.dart';
import '../../data/models/station_states.dart';

class ProceedParams {
  String total;
  String subtotal;
  String discount;

  ProceedParams(this.total, this.subtotal, this.discount);
}

class ProceedCheckout extends StatefulWidget {
  final String total;
  final String subtotal;
  final String discount;
  const ProceedCheckout({
    super.key,
    required this.total,
    required this.subtotal,
    required this.discount,
  });

  @override
  State<ProceedCheckout> createState() => _ProceedCheckoutState();
}

class _ProceedCheckoutState extends State<ProceedCheckout> {
  final bloc = CartBloc(CartRepositoryImpl(NetworkService()));
  final coupon = CartBloc(CartRepositoryImpl(NetworkService()));
  final cryptobloc = CartBloc(CartRepositoryImpl(NetworkService()));

  final checkoutblocT = OrderPaymentBloc(
    OrderpaymentReposiotryImpl(NetworkService()),
  );
  final checkoutblocC = OrderPaymentBloc(
    OrderpaymentReposiotryImpl(NetworkService()),
  );

  String selectedPaymentMethod = '';
  bool showCryptoOptions = false;
  final userbloc = injector.get<UserBloc>();
  final cartbloc = injector.get<CartBloc>();
  double? selectedDeliveryFee = 0;
  String? selectedDeliveryMethod;
  String? selectedDeliverystateId;
  String? selectedDeliveryStaionId;


  String? minShippingEnable;
  String? shippingMinAmount;

  bool get isReadyToUpload {
    final isLocationSelected =
        selectedDeliverystateId != null || selectedDeliveryStaionId != null;
    final isPaymentSelected = selectedPaymentMethod != null;
    final isCryptoValid =
        selectedPaymentMethod == "crypto"
            ? selectedWalletAddressId != null
            : true;
    return isLocationSelected && isPaymentSelected && isCryptoValid;
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<CartBloc>().add(GetCartEvent());
    bloc.add(CryptoPayEvent());
    cartbloc.add(GetCartEvent());
    super.initState();
  }

  final controller = TextEditingController();

  int? selectedCryptoIndex;

  String? selectedWalletAddress;
  String? selectedWalletAddressId;
  String? selectedWalletname;
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

  CartItemsResponse? responsenumber;
  String? totalnumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(
          text: "Place Your Order",
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                20.verticalSpace,
                Container(
                  width: 1.sw,
                  padding: EdgeInsets.all(5),
                  height: 50,
                  color: Pallets.grey95,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Payment Method",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,

                10.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      // Pre-pay Option
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = 'prepay';
                            showCryptoOptions = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  selectedPaymentMethod == 'prepay'
                                      ? Pallets.successGreen
                                      : Pallets.grey95,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color:
                                selectedPaymentMethod == 'prepay'
                                    ? Pallets.successGreen.withOpacity(0.1)
                                    : Pallets.normalwhite,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectedPaymentMethod == 'prepay'
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color:
                                    selectedPaymentMethod == 'prepay'
                                        ? Pallets.successGreen
                                        : Pallets.black,
                                size: 18,
                              ),
                              6.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      text: "Pre-pay Now",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    TextView(
                                      text:
                                          "Pay with Cards, Bank Transfer or USSD",
                                      fontSize: 16,
                                    ),
                                    TextView(
                                      text:
                                          "You will be redirected to our service checkout",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      10.verticalSpace,

                      // Crypto Payment Option
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = 'crypto';
                            showCryptoOptions = !showCryptoOptions;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  selectedPaymentMethod == 'crypto'
                                      ? Pallets.successGreen
                                      : Pallets.grey95,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color:
                                selectedPaymentMethod == 'crypto'
                                    ? Pallets.successGreen.withOpacity(0.1)
                                    : Pallets.normalwhite,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectedPaymentMethod == 'crypto'
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color:
                                    selectedPaymentMethod == 'crypto'
                                        ? Pallets.successGreen
                                        : Pallets.black,
                                size: 18,
                              ),
                              6.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      text: "Crypto Payment",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    TextView(
                                      text:
                                          "Make payment using your preferred crypto network",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (showCryptoOptions) ...[
                        10.verticalSpace,
                        BlocConsumer<CartBloc, CartState>(
                          bloc: bloc,
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            if (state is CartloadingState) {
                              Center(child: CustomDialogs.getLoading(size: 30));
                            }
                            if (state is CartfailiureState) {
                              return Center(
                                child: AppPromptWidget(
                                  onTap: () {
                                    bloc.add(CryptoPayEvent());
                                  },
                                ),
                              );
                            }
                            if (state is CryptoPaySuccessState) {
                              final response =
                                  state.response.data?.paymentOptions;
                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Pallets.grey95),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    response!.length,
                                    (cryptoIndex) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (selectedCryptoIndex ==
                                                cryptoIndex) {
                                              selectedCryptoIndex = null;
                                              selectedWalletAddress = null;
                                              selectedWalletAddressId = null;
                                              selectedWalletname = null;
                                            } else {
                                              selectedCryptoIndex = cryptoIndex;
                                              selectedWalletAddress =
                                                  response[cryptoIndex]
                                                      .walletAddress;
                                              selectedWalletAddressId =
                                                  response[cryptoIndex].id
                                                      .toString();
                                              selectedWalletname =
                                                  response[cryptoIndex]
                                                      .networkName;
                                            }
                                          });

                                          if (response[cryptoIndex]
                                                  .networkName !=
                                              null) {
                                            final name =
                                                response[cryptoIndex]
                                                            .networkName ==
                                                        "USDT"
                                                    ? "tether"
                                                    : response[cryptoIndex]
                                                        .networkName!
                                                        .toLowerCase();
                                            cryptobloc.add(
                                              GetCryptoPriceEvent(
                                                name.toString(),
                                              ),
                                            );
                                          }
                                        },

                                        child: Container(
                                          width: 1.sw,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Pallets.grey95,
                                            ),
                                            color: Pallets.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextView(
                                                text:
                                                    response[cryptoIndex]
                                                        .networkName ??
                                                    '',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),

                                              if (selectedCryptoIndex ==
                                                  cryptoIndex) ...[
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 250,
                                                      child: TextView(
                                                        text:
                                                            response[cryptoIndex]
                                                                .walletAddress ??
                                                            '',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        FlutterClipboard.copy(
                                                          response[cryptoIndex]
                                                                  .walletAddress ??
                                                              '',
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.copy,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                5.verticalSpace,
                                                TextView(
                                                  text: "Scan Barcode",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Pallets.grey60,
                                                ),
                                                5.verticalSpace,
                                                ImageWidget(
                                                  imageUrl:
                                                      response[cryptoIndex]
                                                          .barcode ??
                                                      '',
                                                  size: 100,
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SizedBox();
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                20.verticalSpace,
                DeliveryOptions(
                  onOptionSelected: (
                    fee,
                    deliveryOption,
                    deliveryStateID,
                    deliveryStationId,

                  ) {
                    print('Fee: $fee');
                    print('Option: $deliveryOption');
                    print('State ID: $deliveryStateID');
                    print('Pickup Station ID: $deliveryStationId');
                    setState(() {
                      selectedDeliveryFee = fee;
                      selectedDeliveryMethod = deliveryOption;
                      selectedDeliverystateId = deliveryStateID;
                      selectedDeliveryStaionId = deliveryStationId;
                    });
                  },
                ),

                20.verticalSpace,
                Container(
                  width: 1.sw,
                  padding: EdgeInsets.all(5),
                  height: 50,
                  color: Pallets.grey95,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Delivery Address",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        TextView(
                          text: "Change",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.green,
                          onTap: () {
                            context.pushNamed(PageUrl.my_profile);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.car_crash, color: Colors.green, size: 18),
                          6.horizontalSpace,
                          TextView(text: "Customer Address"),
                        ],
                      ),
                      5.verticalSpace,
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Pallets.successGreen),
                          borderRadius: BorderRadius.circular(10),
                          color: Pallets.successGreen.withOpacity(0.1),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Pallets.successGreen,
                              size: 18,
                            ),
                            6.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      TextView(
                                        text: userbloc.appUser?.firstName ?? '',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      5.horizontalSpace,
                                      TextView(
                                        text: userbloc.appUser?.lastName ?? '',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  TextView(
                                    text:
                                        userbloc.appUser?.primaryAddress ?? '',
                                    fontSize: 15,
                                  ),
                                  TextView(
                                    text: userbloc.appUser?.state ?? '',
                                    fontSize: 15,
                                  ),
                                  TextView(
                                    text: userbloc.appUser?.primaryPhone ?? '',
                                    fontSize: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                10.verticalSpace,
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: FilledTextField(
                      hint: "Coupon Code",
                      controller: controller,
                      fillColor: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    // Constrain button
                    flex: 1,
                    child: BlocConsumer<CartBloc, CartState>(
                      bloc: coupon,
  listener: _listenToCouponsState,
  builder: (context, state) {
    return CustomButton(
                      child: TextView(
                        text: "Apply",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: (){
                        applyCoupon();
                      },
                    );
  },
),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: BlocConsumer<CartBloc, CartState>(
                listener:_listenToCatSTate,
                builder: (context, state) {
                  if(state is CartfailiureState){
                    return Center(
                      child: Column(
                        children: [

                          AppPromptWidget(

                           message: "Oops! an error occured..",
                            onTap: (){
                              context.read<CartBloc>().add(GetCartEvent());
                            },
                          ),
                        ],
                      ),
                    );

                  }
                  if (state is GetCartSuccessState) {
                    responsenumber = state.response;
                    final deliveryFee = selectedDeliveryFee ?? 0;
                    final resp = state.response.data;
                    final total =
                        double.parse(
                          state.response.data!.summary!.total.toString(),
                        ) +
                        double.parse(deliveryFee.toString());
                    totalnumber = resp?.items.toString();
                    return Column(
                      children: [
                        15.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextView(text: "Total Items(s)"),
                              TextView(
                                text: resp!.items.length.toString(),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(text: "Sub Total", fontSize: 14),
                            Text(
                              "₦${formatNumberWithCommas(widget.total.toString())}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        selectedDeliveryFee == null
                            ? SizedBox()
                            : 10.verticalSpace,
                        selectedDeliveryFee == null
                            ? SizedBox()
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextView(text: "Delivery fee", fontSize: 14),
                                Text(
                                  "₦${formatNumberWithCommas(selectedDeliveryFee.toString())}",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(text: "Discount", fontSize: 14),
                            Text(
                              "₦${formatNumberWithCommas(resp!.summary!.totalDiscount.toString())}",

                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        5.verticalSpace,
                        Divider(color: Pallets.grey95),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(text: "Total", fontSize: 16),
                            Text(
                              "₦${formatNumberWithCommas(total.toString())}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
            10.verticalSpace,
            selectedWalletAddress == null
                ? SizedBox()
                : Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      BlocConsumer<CartBloc, CartState>(
                        bloc: cryptobloc,
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is CartloadingState) {
                            return Center(
                              child: TextView(text: "Loading wallet amount"),
                            );
                          }
                          if (state is CartfailiureState) {
                            return Center(
                              child: TextView(
                                text: "failed to get amount",
                                onTap: () {
                                  final name =
                                      selectedWalletname == "USDT"
                                          ? "tether"
                                          : selectedWalletname
                                              .toString()
                                              .toLowerCase();
                                  cryptobloc.add(
                                    GetCryptoPriceEvent(name.toString()),
                                  );
                                },
                              ),
                            );
                          }
                          if (state is CryptoSuccessState) {
                            final res = state.response;

                            if (res.isEmpty) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [TextView(text: "")],
                              );
                            }
                            final total =
                                double.parse(widget.total.toString()) +
                                double.parse(
                                  selectedDeliveryFee.toString() ?? '0',
                                );

                            final price =
                                double.parse(total.toString()) /
                                double.parse(res.first.currentPrice.toString());

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextView(
                                  text:
                                      "≈${price} ${res.first.name.toString()}",
                                ),
                              ],
                            );
                          }

                          return SizedBox();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextView(text: "send to: ", fontSize: 10),
                          SizedBox(
                            width: 100,
                            child: TextView(
                              text: selectedWalletAddress ?? '',
                              fontSize: 11,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              FlutterClipboard.copy(selectedWalletAddress!);
                            },
                            child: Icon(Icons.copy, size: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            20.verticalSpace,
            isReadyToUpload
                ? BlocConsumer<OrderPaymentBloc, OrderPaymentState>(
                  bloc: checkoutblocT,
                  listener: _listenTopaymentState,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: CustomButton(
                        child: TextView(
                          text: "Confirm Order",
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        onPressed:
                            isReadyToUpload
                                ? () {
                                  payforItem();
                                }
                                : null,
                      ),
                    );
                  },
                )
                : SizedBox(),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  void _listenTopaymentState(BuildContext context, OrderPaymentState state) {
    if (state is OrderPaymentloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is OrderPaymentfailiureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is OrderPaymentTransferSuccessState) {
      context.pop();
      Helpers.launchRawUrl(state.response.data?.checkoutUrl ?? '');
      context.pushNamed(
        PageUrl.cash_success_order,
        extra: CashSuccessOrderParams(
          state.response.data?.reference ?? '',
          state.response.data?.checkoutUrl ?? '',
        ),
      );
    }
    if (state is OrderPaymentCryptoSuccessState) {
      context.pop();
      context.pushNamed(PageUrl.success_order);
    }
  }

  void payforItem() {
    final payload = ConfirmOrderPickupDeliverypayload(
      deliveryAddress: DeliveryAddress(
        firstName: userbloc.appUser?.firstName ?? '',
        lastName: userbloc.appUser?.lastName ?? '',
        primaryPhone: userbloc.appUser?.primaryPhone ?? '',
        state: userbloc.appUser?.state ?? '',
        primaryAddress: userbloc.appUser?.primaryAddress ?? '',
        email: userbloc.appUser?.email ?? '',
      ),
      deliveryOption: selectedDeliveryMethod,
      paymentMethod: selectedPaymentMethod,
      pickupStationId: selectedDeliveryStaionId,
      cryptoWalletId: selectedWalletAddressId,
      selectedStateId: selectedDeliverystateId,
    );

    if (selectedPaymentMethod == "crypto") {
      checkoutblocT.add(OrderPayCryptoEvent(payload));
    } else {
      checkoutblocT.add(OrderPayTransferEvent(payload));
    }
  }



  void _listenToCouponsState(BuildContext context, CartState state
      ) {
    if(state is CartloadingState){
      CustomDialogs.showLoading(context);
    }
    if(state is CartfailiureState){
      context.pop();
      CustomDialogs.error(state.error);
      controller.clear();

    }
    if(state is ApplyCouponSuccesssState){
      context.pop();
      CustomDialogs.success(state.response.status??'');
      controller.clear();

    }
  }

  void applyCoupon() {
    coupon.add(CouponEvent(CouponPayload(code:controller.text.trim())));
  }

  void _listenToCatSTate(BuildContext context, CartState state) {
    if(state is CartloadingState){
      // CustomDialogs.showLoading(context);
    }
    if(state is CartfailiureState){
      // context.pop();
      // CustomDialogs.error(state.error);
      // controller.clear();

    }
    if(state is GetCartSuccessState){
      // context.pop();
    }
  }
}

class DeliveryOptions extends StatefulWidget {
  final Function(
    double fee,
    String? deliveryOption,
    String? deliveryStationId,
    String? deliveryStateID,
  )
  onOptionSelected;

  const DeliveryOptions({super.key, required this.onOptionSelected});

  @override
  State<DeliveryOptions> createState() => _DeliveryOptionsState();
}

class _DeliveryOptionsState extends State<DeliveryOptions> {
  final bloc = CartBloc(CartRepositoryImpl(NetworkService()));
  final statebloc = CartBloc(CartRepositoryImpl(NetworkService()));
  final Pickupbloc = CartBloc(CartRepositoryImpl(NetworkService()));
  String? selectedstate;
  String? selectedStateName;
  String? selectedStateprice;
  String? selectedstatePickup;
  String? selectedStateNamePickup;
  String? selectedStatepricePickup;

  ///
  String? selectedStateAddressPickup;
  String? selectedStateContactPickup;
  String? selectedPickupName;

  String? statebilling;
  String? Pickupbilling;

  int selectedShippingIndex = 0;
  int? selectedPickupIndex;
  List<PickupLocation>? pickupLocations;

  @override
  void initState() {
    super.initState();
    Pickupbloc.add(GetStationbillingEvent());
    bloc.add(GetShippingInfoEvent());
    statebloc.add(GetStatebillingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          padding: EdgeInsets.all(5),
          height: 50,
          color: Pallets.grey95,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Delivery Option",
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ],
            ),
          ),
        ),
        10.verticalSpace,
        BlocConsumer<CartBloc, CartState>(
          bloc: bloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CartloadingState) {
              return Center(child: CustomDialogs.getLoading(size: 30));
            }

            if (state is CartfailiureState) {
              return Center(
                child: TextView(
                  text: "Retry",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              );
            }

            if (state is ShipingInfoSuccessState) {
              final response = state.response.data?.settings;
              // pickupLocations=state.response.data.settings.pickupEnabled;
              final bool doorDeliveryEnabled =
                  response?.doorDeliveryEnabled ?? false;
              final bool pickupEnabled = response?.pickupEnabled ?? false;

              final List<String> enabledOptions = [];
              if (doorDeliveryEnabled) enabledOptions.add('Door Delivery');
              if (pickupEnabled) enabledOptions.add('Pickup Station');

              if (enabledOptions.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Pallets.white,
                    ),
                    child: Center(
                      child: TextView(text: 'No shipping options available'),
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Pallets.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          enabledOptions.length,
                          (index) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedShippingIndex = index;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color:
                                        selectedShippingIndex == index
                                            ? Pallets.primary
                                            : Pallets.grey95,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      selectedShippingIndex == index
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_off,
                                      size: 16,
                                      color:
                                          selectedShippingIndex == index
                                              ? Pallets.primary
                                              : Pallets.grey35,
                                    ),
                                    10.horizontalSpace,
                                    Flexible(
                                      child: TextView(
                                        text: enabledOptions[index],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (enabledOptions[selectedShippingIndex] == 'Door Delivery')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Pallets.grey95),
                          borderRadius: BorderRadius.circular(10),
                          color: Pallets.grey95.withOpacity(0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: "State",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            10.verticalSpace,
                            Container(
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Pallets.grey75),
                              ),
                              child: BlocConsumer<CartBloc, CartState>(
                                bloc: statebloc,
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is CartloadingState) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 8,
                                        bottom: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextView(
                                            text: "Getting States",
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.onBackground,
                                          ),
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  if (state is StateBillingSuccessState) {
                                    List<StateFee> stateList = List.from(
                                      state.response.data!.stateFees,
                                    )..sort(
                                      (a, b) => (a.state ?? '').compareTo(
                                        b.state ?? '',
                                      ),
                                    );

                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: const TextView(
                                          text: "Select State",
                                          fontSize: 16,
                                        ),
                                        value: selectedstate,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedstate = value;
                                            // Find and store the selected state name
                                            final selectedState = stateList
                                                .firstWhere(
                                                  (state) =>
                                                      state.id.toString() ==
                                                      value,
                                                  orElse:
                                                      () => StateFee(
                                                        id: null,
                                                        state: null,
                                                        fee: null,
                                                        createdAt: null,
                                                        updatedAt: null,
                                                      ),
                                                );

                                            selectedStateName =
                                                selectedState.state ?? '';
                                            selectedStateprice =
                                                selectedState.fee?.toString() ??
                                                '0';
                                            String stateId =
                                                selectedState.id.toString() ??
                                                '';

                                            double fee =
                                                double.tryParse(
                                                  selectedStateprice ?? '0',
                                                ) ??
                                                0;
                                            widget.onOptionSelected(
                                              fee,
                                              'door',
                                              stateId,
                                              '',
                                            );
                                          });
                                        },
                                        items:
                                            stateList.map((stateFee) {
                                              return DropdownMenuItem<String>(
                                                value: stateFee.id?.toString(),
                                                child: TextView(
                                                  text:
                                                      stateFee.state ??
                                                      'Unknown State',
                                                  color:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onBackground,
                                                  fontSize: 14,
                                                ),
                                              );
                                            }).toList(),
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 250.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Iconsax.arrow_down_1,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  if (state is CartfailiureState) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: TextView(
                                        text: "Failed to load states",
                                        color: Colors.red,
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ),
                            5.verticalSpace,
                            selectedStateName == null
                                ? SizedBox()
                                : TextView(
                                  text:
                                      "Delivery fee: ${selectedStateprice ?? ''}",
                                  fontWeight: FontWeight.w500,
                                ),
                          ],
                        ),
                      ),
                    ),

                  if (enabledOptions.isNotEmpty &&
                      selectedShippingIndex < enabledOptions.length &&
                      enabledOptions[selectedShippingIndex] == 'Pickup Station')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Pallets.grey95),
                          borderRadius: BorderRadius.circular(10),
                          color: Pallets.grey95.withOpacity(0.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextView(
                              text: "Pickup State",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            10.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Pallets.grey75),
                              ),
                              child: BlocConsumer<CartBloc, CartState>(
                                bloc: Pickupbloc,
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is CartloadingState) {
                                    return const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextView(text: "Getting States"),
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  if (state is StationBillingSuccessState) {
                                    List<PickupLocation> pickupList = List.from(
                                      state.response.data!.pickupLocations,
                                    )..sort(
                                      (a, b) => (a.state ?? '').compareTo(
                                        b.state ?? '',
                                      ),
                                    );

                                    // Group pickup locations by state
                                    Map<String, List<PickupLocation>>
                                    pickupLocationsByState = {};
                                    for (var location in pickupList) {
                                      if (location.state != null) {
                                        if (!pickupLocationsByState.containsKey(
                                          location.state,
                                        )) {
                                          pickupLocationsByState[location
                                                  .state!] =
                                              [];
                                        }
                                        pickupLocationsByState[location.state!]!
                                            .add(location);
                                      }
                                    }

                                    return Column(
                                      children: [
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton2<String>(
                                            isExpanded: true,
                                            hint: const TextView(
                                              text: "Pickup State",
                                              fontSize: 16,
                                            ),
                                            value: selectedstatePickup,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedstatePickup = value;
                                                selectedPickupIndex = null;
                                                final selectedPickup =
                                                    pickupList.firstWhere(
                                                      (pickup) =>
                                                          pickup.id
                                                              .toString() ==
                                                          value,
                                                      orElse:
                                                          () => PickupLocation(
                                                            id: null,
                                                            state: null,
                                                            name: null,
                                                            address: null,
                                                            contactPhone: null,
                                                            fee: null,
                                                            createdAt: null,
                                                            updatedAt: null,
                                                          ),
                                                    );

                                                selectedStateNamePickup =
                                                    selectedPickup.state ?? '';
                                                selectedStatepricePickup =
                                                    selectedPickup.fee
                                                        ?.toString() ??
                                                    '0';
                                                String stationId =
                                                    selectedPickup.id
                                                        .toString() ??
                                                    '';
                                                double fee =
                                                    double.tryParse(
                                                      selectedStateprice ?? '0',
                                                    ) ??
                                                    0;
                                                widget.onOptionSelected(
                                                  fee,
                                                  "pickup",
                                                  "",
                                                  stationId,
                                                );
                                              });
                                            },
                                            items:
                                                pickupLocationsByState.keys.map((
                                                  stateName,
                                                ) {
                                                  var firstLocation =
                                                      pickupLocationsByState[stateName]!
                                                          .first;
                                                  return DropdownMenuItem<
                                                    String
                                                  >(
                                                    value:
                                                        firstLocation.id
                                                            ?.toString(),
                                                    child: TextView(
                                                      text: stateName,
                                                      color:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .onBackground,
                                                      fontSize: 14,
                                                    ),
                                                  );
                                                }).toList(),
                                            buttonStyleData:
                                                const ButtonStyleData(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                ),
                                            dropdownStyleData:
                                                DropdownStyleData(
                                                  maxHeight: 250.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                            iconStyleData: const IconStyleData(
                                              icon: Icon(
                                                Iconsax.arrow_down_1,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        10.verticalSpace,
                                        if (selectedstatePickup != null &&
                                            selectedStateNamePickup != null &&
                                            pickupLocationsByState.containsKey(
                                              selectedStateNamePickup,
                                            ))
                                          Column(
                                            children: [
                                              TextView(
                                                text:
                                                    "Available Pickup Locations:",
                                                fontWeight: FontWeight.w600,
                                              ),
                                              10.verticalSpace,
                                              ...pickupLocationsByState[selectedStateNamePickup]!
                                                  .map(
                                                    (
                                                      pickupLocation,
                                                    ) => GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedPickupIndex =
                                                              pickupLocation.id;
                                                          selectedPickupName =
                                                              pickupLocation
                                                                  .name;
                                                          selectedStateAddressPickup =
                                                              pickupLocation
                                                                  .address;
                                                          selectedStateContactPickup =
                                                              pickupLocation
                                                                  .contactPhone;
                                                          selectedStatepricePickup =
                                                              pickupLocation.fee
                                                                  ?.toString() ??
                                                              '0';
                                                          String stationId =
                                                              pickupLocation.id
                                                                  .toString();

                                                          double fee =
                                                              double.tryParse(
                                                                selectedStatepricePickup ??
                                                                    '0',
                                                              ) ??
                                                              0;
                                                          widget
                                                              .onOptionSelected(
                                                                fee,
                                                                'pickup',
                                                                "",
                                                                stationId,
                                                              );
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              4.0,
                                                            ),
                                                        child: Container(
                                                          width: 1.sw,
                                                          margin:
                                                              EdgeInsets.symmetric(
                                                                vertical: 5,
                                                              ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                10,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10,
                                                                ),
                                                            color:
                                                                selectedPickupIndex ==
                                                                        pickupLocation
                                                                            .id
                                                                    ? Pallets
                                                                        .white
                                                                    : Pallets
                                                                        .grey95
                                                                        .withOpacity(
                                                                          0.4,
                                                                        ),
                                                            border: Border.all(
                                                              color:
                                                                  selectedPickupIndex ==
                                                                          pickupLocation
                                                                              .id
                                                                      ? Pallets
                                                                          .successGreen
                                                                      : Pallets
                                                                          .grey95
                                                                          .withOpacity(
                                                                            0.4,
                                                                          ),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              TextView(
                                                                text:
                                                                    pickupLocation
                                                                        .name ??
                                                                    'N/A',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              TextView(
                                                                text:
                                                                    pickupLocation
                                                                        .address ??
                                                                    '',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              TextView(
                                                                text:
                                                                    pickupLocation
                                                                        .contactPhone ??
                                                                    '',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              Text(

                                                                    "Fee: ₦${pickupLocation.fee ?? '0'}",
                                                              style: TextStyle(  fontWeight:
                                                              FontWeight
                                                                  .w500,),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ],
                                          ),
                                      ],
                                    );
                                  }

                                  if (state is CartfailiureState) {
                                    return const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: TextView(
                                        text: "Failed to load states",
                                        color: Colors.red,
                                      ),
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
