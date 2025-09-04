import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/common/widgets/filled_textfield.dart';
import 'package:hezmart/common/widgets/image_widget.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:hezmart/features/homescreen/data/data/product_repo_impl/product_repo_impl.dart';
import 'package:hezmart/features/homescreen/presentations/bloc/products_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/text_view.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../cart/presentations/cartbloc/cart_bloc.dart';
import '../widgets/flash_sales.dart';
import '../widgets/shop_widget.dart';
class Shopsscreen extends StatefulWidget {
  const Shopsscreen({super.key});

  @override
  State<Shopsscreen> createState() => _ShopsscreenState();
}

class _ShopsscreenState extends State<Shopsscreen> {

  final bloc=ProductsBloc(ProductRepositoryImpl(NetworkService()));
  final mycart = injector.get<CartBloc>();

  @override
  void initState() {
    // TODO: implement initState
    bloc.add(GetAllVendorsEvent());
    mycart.add(GetCartEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(text: "Vendors",fontSize: 18,),
        actions: [
          InkWell(
              splashColor: Colors.transparent,
              onTap: (){
                context.pushNamed(PageUrl.search_screen);
              },
              child: Icon(Iconsax.search_normal,size: 18,)),
          15.horizontalSpace,
          InkWell(
            onTap: (){
              context.goNamed(PageUrl.mycart);
            },
            child: BlocConsumer<CartBloc, CartState>(
              bloc: mycart,
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is GetCartSuccessState) {
                  final cartitems = state.response.data?.items;
                  if(cartitems!.isEmpty){
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(Icons.shopping_cart_outlined),
                      ],
                    );
                  }

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(Icons.shopping_cart_outlined),
                      Positioned(
                        right: -3,
                        top: -5,
                        child: CircleAvatar(
                          backgroundColor: Color(0xffE67002),
                          radius: 8,
                          child: TextView(
                            text: cartitems!.length.toString(),
                            color: Pallets.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Icon(Icons.shopping_cart_outlined);
              },
            ),
          ),
          15.horizontalSpace
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<ProductsBloc, ProductsState>(
          bloc: bloc,
          listener: _listenToVendorState,
          builder: (context, state) {
            if(state is ProductsFailiureState){
              return Center(
                child: AppPromptWidget(
                  onTap: (){
                    bloc.add(GetAllVendorsEvent());
                  },
                ),
              );
            }
            if(state is GetVendorsSuccessState){
              final vendors=state.response.data;

              // Filter vendors to only show approved ones
              final approvedVendors = vendors?.users?.where((vendor) =>
              vendor.status?.toLowerCase() == 'active'
              ).toList() ?? [];

              // Show message if no approved vendors
              if (approvedVendors.isEmpty) {
                return SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.store_mall_directory_outlined, size: 64, color: Colors.grey),
                        16.verticalSpace,
                        TextView(
                          text: "No approved vendors available",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        8.verticalSpace,
                        TextView(
                          text: "Check back later for new vendors",
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Color(0xffE67002),
                    child: Center(
                      child: TextView(
                        text: "Call To Order: 09160002490",
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(10),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: approvedVendors.length,
                          itemBuilder: (context, index) {
                            final vendor = approvedVendors[index];
                            return Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Pallets.grey95.withOpacity(0.5)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      logger.w(vendor.businessName);
                                      context.pushNamed(
                                        PageUrl.shop_vendor_products,
                                        queryParameters: {
                                          PathParam.id: vendor.id.toString(),
                                          PathParam.userName: vendor.businessName.toString()
                                        },
                                      );
                                    },
                                    child: IgnorePointer(
                                      child: ImageWidget(
                                        borderRadius: BorderRadius.circular(75),
                                        imageUrl: vendor.businessLogo ?? '',
                                        size: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  10.verticalSpace,
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      context.pushNamed(
                                        PageUrl.shop_vendor_products,
                                        queryParameters: {
                                          PathParam.id: vendor.id.toString()
                                        },
                                      );
                                    },
                                    child: Center(
                                      child: TextView(
                                        text: vendor.businessName ?? '',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        maxLines: 2,
                                        textOverflow: TextOverflow.ellipsis,
                                        align: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  // Optional: Add status badge if needed

                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  void _listenToVendorState(BuildContext context, ProductsState state) {
    if(state is ProductsloadingState){
      CustomDialogs.showLoading(context);
    }
    if(state is ProductsFailiureState){
      context.pop();
    }
    if(state is GetVendorsSuccessState){
      context.pop();
    }
  }
}

