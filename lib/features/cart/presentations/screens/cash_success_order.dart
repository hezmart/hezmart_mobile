import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/error_widget.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/services/network/network_service.dart';
import '../../../../core/theme/pallets.dart';
import '../../../../core/utils/helper_utils.dart';
import '../../data/data/cart_repo_impl.dart';
import '../cartbloc/cart_bloc.dart';


class CashSuccessOrderParams{
  String ref;
  String url;

  CashSuccessOrderParams(this.ref, this.url);
}

class CashSuccessOrder extends StatefulWidget {
  final String ref;
  final String url;
  const CashSuccessOrder({super.key, required this.ref, required this.url});

  @override
  State<CashSuccessOrder> createState() => _CashSuccessOrderState();
}

class _CashSuccessOrderState extends State<CashSuccessOrder> with WidgetsBindingObserver {
  final bloc = CartBloc(CartRepositoryImpl(NetworkService()));
  final cart = CartBloc(CartRepositoryImpl(NetworkService()));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<CartBloc>().add(GetCartEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<CartBloc>().add(GetCartEvent());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<CartBloc, CartState>(
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
              if(state is CartfailiureState){
                return Center(child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: IgnorePointer(child: ImageWidget(imageUrl: "assets/images/pngs/failed.png",size: 100,))),
                      20.verticalSpace,
                      TextView(text: "Payment Unsuccessful",fontSize: 16,color: Colors.red,fontWeight: FontWeight.w500,),
                      TextView(text: "Your order was not placed successful",fontSize: 12,align: TextAlign.center,),

                      30.verticalSpace,
                      CustomButton(child: TextView(text: "Continue Shopping",fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,), onPressed: (){
                        context.goNamed(PageUrl.home);

                      }),
                      20.verticalSpace,
                      TextView(text: "Go back",fontSize: 14,fontWeight:FontWeight.w600,align: TextAlign.center,color: Color(0xff0ffE67002),onTap: (){
                   context.pop();

                      },),
                    ],
                  ),
                ),);
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
                final cartitems = state.response.data?.items ?? [];
                if (cartitems.isEmpty) {
                 return Column(
                    children: [
                      Center(child: IgnorePointer(child: ImageWidget(imageUrl: "assets/images/pngs/success.png",size: 200,))),
                      10.verticalSpace,
                      TextView(text: "Order placed successful",fontSize: 16,),
                      TextView(text: "Your order have been placed successful ",fontSize: 12,align: TextAlign.center,),
                      5.verticalSpace,
                      TextView(text: "See Order",fontSize: 14,fontWeight:FontWeight.w600,align: TextAlign.center,color: Color(0xff0ffE67002),onTap: (){
                        context.goNamed(PageUrl.profile);
                      },),
                    ],
                  );
                }
                return  Center(child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: IgnorePointer(child: ImageWidget(imageUrl: "assets/images/pngs/failed.png",size: 100,))),
                      20.verticalSpace,
                      TextView(text: "Payment Unsuccessful",fontSize: 16,color: Colors.red,fontWeight: FontWeight.w500,),
                      TextView(text: "Your order was not placed successful",fontSize: 12,align: TextAlign.center,),

                      30.verticalSpace,
                      CustomButton(child: TextView(text: "Continue Shopping",fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,), onPressed: (){
                        context.goNamed(PageUrl.home);

                      }),
                      20.verticalSpace,
                      TextView(text: "Go back",fontSize: 14,fontWeight:FontWeight.w600,align: TextAlign.center,color: Color(0xff0ffE67002),onTap: (){
                        context.pop();

                      },),
                    ],
                  ),
                ),);
              }
              return SizedBox();
            },
          ),
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
