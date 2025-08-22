import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/common/widgets/filled_textfield.dart';
import 'package:hezmart/common/widgets/image_widget.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/di/injector.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:hezmart/features/cart/data/data/cart_repo_impl.dart';
import 'package:hezmart/features/cart/data/models/update_payload.dart';
import 'package:hezmart/features/cart/presentations/cartbloc/cart_bloc.dart';
import 'package:hezmart/features/cart/presentations/screens/proceed_checkout.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/navigation/path_params.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  int number = 1;
  final controller = TextEditingController();
  final cart = CartBloc(CartRepositoryImpl(NetworkService()));
  final deletecart = CartBloc(CartRepositoryImpl(NetworkService()));
  final mycart = injector.get<CartBloc>();
  @override
  void initState() {
    // TODO: implement initState
    // cart.add(GetCartEvent());
    context.read<CartBloc>().add(GetCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocConsumer<CartBloc, CartState>(
          // bloc: cart,
          listener: _listenToCartState,
          builder: (context, state) {
            if (state is CartloadingState) {
              return Center(
                child: SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: Center(child: CustomDialogs.getLoading(size: 30)),
                ),
              );
            }
            if (state is CartfailiureState) {
              return SizedBox(
                height: 1.sh,
                child: Center(
                  child: AppPromptWidget(
                    onTap: () {
                      context.read<CartBloc>().add(GetCartEvent());
                    },
                  ),
                ),
              );
            }

            if (state is GetCartSuccessState) {

              String formatNumberWithCommas(String number) {
                try {
                  final parsedNumber = double.parse(number.replaceAll(',', ''));
                  return parsedNumber.toStringAsFixed(0).replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},',
                  );
                } catch (e) {
                  return number;
                }
              }
              final cartitems = state.response.data?.items;
              if (cartitems!.isEmpty) {
                return SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_cart_outlined,size: 50,color: Pallets.grey75,),
                        TextView(
                          text: "Your cart is empty",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        5.verticalSpace,
                        TextView(
                          text: "Start adding some products to your cart",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Pallets.grey60,
                        ),
20.verticalSpace,
                        SizedBox(
                          width: 200,
                          height: 60,
                          child: CustomButton(
                            isExpanded: true,
                            // padding: EdgeInsets.symmetric(horizontal: 20),
                            onPressed: () {
                              context.goNamed(PageUrl.home);
                            },
                            bgColor: Color(0xffE67002),
                            child: TextView(
                              text: "Browse products",
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        200.verticalSpace,
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart Items Section
                    20.verticalSpace,
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Pallets.grey95),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: "Cart",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          Column(
                            children: List.generate(cartitems!.length, (index) {
                              final selectedColor =
                                  cartitems[index].selectedOptions?.color;
                              return Container(
                                width: double.infinity,
                                constraints: BoxConstraints(maxWidth: 1.sw),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Container(
                                            child: ImageWidget(
                                              onTap: () {
                                                context.pushNamed(
                                                  PageUrl.product_details,
                                                  queryParameters: {
                                                    PathParam.id:
                                                    cartitems[index].productId.toString()
                                                  },
                                                );
                                              },
                                              width: 80,
                                              height: 100,
                                              imageUrl:
                                                  cartitems[index]
                                                      .product!
                                                      .coverImage
                                                      .toString(),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          10.horizontalSpace,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextView(
                                                  text:
                                                      cartitems[index]
                                                          .product!
                                                          .name
                                                          .toString(),
                                                  fontWeight: FontWeight.w500,
                                                  maxLines: 2,
                                                ),
                                                cartitems[index]
                                                                .selectedOptions!
                                                                .color ==
                                                            null ||
                                                        cartitems[index]
                                                            .selectedOptions!
                                                            .color
                                                            .toString()
                                                            .isEmpty
                                                    ? SizedBox()
                                                    : Row(
                                                      children: [
                                                        TextView(
                                                          text: "Color:",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                        ),
                                                        4.horizontalSpace,
                                                        TextView(
                                                          text:
                                                              cartitems[index]
                                                                  .selectedOptions!
                                                                  .color
                                                                  .toString(),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 10,
                                                        ),
                                                      ],
                                                    ),
                                                cartitems[index]
                                                                .selectedOptions!
                                                                .size ==
                                                            null ||
                                                        cartitems[index]
                                                            .selectedOptions!
                                                            .size
                                                            .toString()
                                                            .isEmpty
                                                    ? SizedBox()
                                                    : 5.verticalSpace,
                                                cartitems[index]
                                                                .selectedOptions!
                                                                .size ==
                                                            null ||
                                                        cartitems[index]
                                                            .selectedOptions!
                                                            .size
                                                            .toString()
                                                            .isEmpty
                                                    ? SizedBox()
                                                    : Row(
                                                      children: [
                                                        TextView(
                                                          text: "Size:",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                        ),
                                                        4.horizontalSpace,
                                                        TextView(
                                                          text:
                                                              cartitems[index]
                                                                  .selectedOptions!
                                                                  .size
                                                                  .toString(),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 10,
                                                        ),
                                                      ],
                                                    ),
                                                5.verticalSpace,
                                                Text(
                                                      "₦${formatNumberWithCommas(cartitems[index].product!.discountPrice.toString())}",
                                                  style: TextStyle(fontWeight: FontWeight.w600,),
                                                ),
                                                5.verticalSpace,
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Pallets.grey95,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      BlocConsumer<
                                                        CartBloc,
                                                        CartState
                                                      >(
                                                        bloc: cart,
                                                        listener: (
                                                          context,
                                                          state,
                                                        ) {
                                                          // TODO: implement listener
                                                        },

                                                        builder: (
                                                          context,
                                                          state,
                                                        ) {
                                                          return InkWell(
                                                            onTap: () {
                                                              cart.add(
                                                                UpdateCartEvent(
                                                                  cartitems[index]
                                                                      .productId
                                                                      .toString(),
                                                                  UpdateCartPayload(
                                                                    quantity:
                                                                        cartitems[index]
                                                                            .quantity -
                                                                        1,
                                                                  ),
                                                                ),
                                                              );
                                                            },

                                                            child: Icon(
                                                              Iconsax.minus,
                                                              size: 18,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      15.horizontalSpace,
                                                      TextView(
                                                        text:
                                                            cartitems[index]
                                                                .quantity
                                                                .toString(),
                                                      ),
                                                      15.horizontalSpace,
                                                      BlocConsumer<
                                                        CartBloc,
                                                        CartState
                                                      >(
                                                        bloc: cart,
                                                        listener: (
                                                          context,
                                                          state,
                                                        ) {
                                                          // TODO: implement listener
                                                        },

                                                        builder: (
                                                          context,
                                                          state,
                                                        ) {
                                                          return InkWell(
                                                            onTap: () {
                                                              cart.add(
                                                                UpdateCartEvent(
                                                                  cartitems[index]
                                                                      .productId
                                                                      .toString(),
                                                                  UpdateCartPayload(
                                                                    quantity:
                                                                        cartitems[index]
                                                                            .quantity +
                                                                        1,
                                                                  ),
                                                                ),
                                                              );
                                                            },

                                                            child: Icon(
                                                              Iconsax.add,
                                                              size: 18,
                                                            ),
                                                          );
                                                        },
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
                                    SizedBox(width: 8),
                                    BlocConsumer<CartBloc, CartState>(
                                      bloc: deletecart,
                                      listener: (context, state) {
                                        // TODO: implement listener
                                      },
                                      builder: (context, state) {
                                        return IconButton(
                                          icon: ImageWidget(
                                            onTap: () {
                                              deletecart.add(
                                                DeleteItemCartEvent(
                                                  cartitems[index].productId
                                                      .toString(),
                                                ),
                                              );
                                            },
                                            size: 20,
                                            imageUrl:
                                                "assets/images/pngs/delete.png",
                                          ),
                                          onPressed: () {
                                            deletecart.add(
                                              DeleteItemCartEvent(
                                                cartitems[index].productId
                                                    .toString(),
                                              ),
                                            );
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),

                    20.verticalSpace,
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallets.grey95),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: "Order Summary",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          10.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextView(text: "Sub Total", fontSize: 14),
                              Text(

                                "₦${formatNumberWithCommas(state.response.data!.summary!.total.toString())}",
                               style: TextStyle( fontSize: 16,
                                 fontWeight: FontWeight.w600,),
                              ),
                            ],
                          ),
                          5.verticalSpace,
                          TextView(
                            text: "Your delivery fees are not included yet.",
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                          Divider(color: Pallets.grey95),

                          15.verticalSpace,
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              child: TextView(
                                text: "Proceed To Checkout",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              onPressed: () {
                                context.pushNamed(PageUrl.proceed_checkout,
                                extra: ProceedParams(state.response.data!.summary!.total.toString(), state.response.data!.summary!.subtotal.toString(), state.response.data!.summary!.totalDiscount.toString()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    60.verticalSpace,
                  ],
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  void _listenToCartState(BuildContext context, CartState state) {
    if (state is CartloadingState) {
      // CustomDialogs.showLoading(context);
    }
    if (state is CartfailiureState) {
      // context.pop();
    }
    if (state is GetCartSuccessState) {
      // context.pop();
    }
  }
}
