import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/features/homescreen/data/data/product_repo_impl/product_repo_impl.dart';
import 'package:hezmart/features/homescreen/presentations/bloc/products_bloc.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../../common/widgets/image_widget.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/navigation/route_url.dart';
import '../../../../core/theme/pallets.dart';
import '../../../wishlist/data/data/repossitory_impl/repossitory_impl.dart';
import '../../../wishlist/presentations/fav_bloc/favourite_bloc.dart';
import 'homescreen.dart';
class ShopVendorProducts extends StatefulWidget {
  final String id ;
  final String name ;
  const ShopVendorProducts({super.key, required this.id, required this.name});

  @override
  State<ShopVendorProducts> createState() => _ShopVendorProductsState();
}

class _ShopVendorProductsState extends State<ShopVendorProducts> {
  final vendorproduct=ProductsBloc(ProductRepositoryImpl(NetworkService()));
  final likeproduct = FavouriteBloc(
    MyfavouritesRepositoryImpl(NetworkService()),
  );
  final Set<String> likedProductIds = {};
  @override
  void initState() {
    // TODO: implement initState
    vendorproduct.add(VendorProductsEvent(widget.id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        tittle: Row(
          children: [
            SizedBox(
                width:170,
                child: TextView(text: "${widget.name} ",fontSize: 18,maxLines: 1,textOverflow: TextOverflow.ellipsis,)),
            6.horizontalSpace,

          ],
        ),
      ),
      body:
      BlocConsumer<ProductsBloc, ProductsState>(
        bloc: vendorproduct,
  listener:_listenToVendorproductstate,
  builder: (context, state) {
    if(state is ProductsFailiureState){
      return Center(child: AppPromptWidget(
        onTap: (){
          vendorproduct.add(VendorProductsEvent(widget.id));

        },
      ),);

    }
    if(state is GetVendorsProductSuccessState){
      final products=state.response.data?.products;


      int calculateDiscountPercentage(
          String price,
          String discountPrice,
          ) {
        final double originalPrice =
            double.tryParse(price) ?? 0;
        final double discountedPrice =
            double.tryParse(discountPrice) ?? 0;

        if (discountedPrice <= 0 ||
            discountedPrice >= originalPrice)
          return 0;

        return ((1 - discountedPrice / originalPrice) * 100)
            .round();
      }
      if(products!.isEmpty){
        return Center(
          child: TextView(text: "No Available products"),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: products?.length,
          itemBuilder: (context, index) {

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Pallets.grey95),
              ),
              child: Stack(
                  children:[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: (){
                            context.pushNamed(PageUrl.product_details,
                              queryParameters: {
                                PathParam.id:
                                products?[index].id.toString(),
                              },);
                          },
                          child: IgnorePointer(
                            child: ImageWidget(
                              imageUrl: products?[index].coverImage??'',
                              // size: 150,
                              height: 150,
                              width: 1.sw,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: (){
                                  context.pushNamed(PageUrl.product_details);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(text: products?[index].name??'',fontSize: 13,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text( "₦${products?[index].discountPrice??''}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 13,),),
                                        Text( "₦${products?[index].price??''}",style: TextStyle(fontSize: 10,decoration: TextDecoration.lineThrough),),
                                      ],
                                    ),
                                    StockIndicator(
                                      stockQuantity:
                                      products?[index].stockQuantity,
                                    ),
                                  ],
                                ),
                              ),
                              6.verticalSpace,

                            ],
                          ),
                        ),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          BlocConsumer<FavouriteBloc, FavouriteState>(
                            bloc: likeproduct,
                            listener: (context, state) {
                              if (state is FavouriteloadingState) {
                                CustomDialogs.showLoading(context, barrierColor: Colors.transparent);
                              }
                              if (state is FavouritefailiureState) {
                                context.pop();
                              }
                              if (state is FavouritelikeSuccessState) {

                                context.pop();
                                likedProductIds.add(state.productId);
                                setState(() {});
                                CustomDialogs.showToast("Added to favourite");
                              }
                            },
                            builder: (context, state) {
                              final productId = products?[index].id.toString();
                              final isLiked = likedProductIds.contains(productId);
                              return CircleAvatar(
                                radius: 15,
                                backgroundColor: Pallets.white,
                                child: GestureDetector(
                                  onTap: () {
                                    likeproduct.add(LikeItemEvent(productId.toString()
                                    ));
                                  },
                                  child: Icon(
                                    isLiked ? Icons.favorite : Icons.favorite_border,
                                    color: isLiked ? Colors.red : Colors.black,
                                    size: 18,
                                  ),
                                ),
                              );
                            },
                          ),

                          // BlocConsumer<
                          //   FavouriteBloc,
                          //   FavouriteState>(
                          //   bloc: likeproduct,
                          //   listener: (context, state) {
                          //    if(state is FavouriteloadingState){
                          //      CustomDialogs.showLoading(context,
                          //          barrierColor: Colors.transparent);
                          //    }
                          //    if(state is FavouritefailiureState){
                          //      context.pop();
                          //    }
                          //    if(state is FavouritelikeSuccessState){
                          //      context.pop();
                          //      CustomDialogs.showToast("Added to favourite");
                          //    }
                          //   },
                          //   builder: (context, state) {
                          //     return CircleAvatar(
                          //       radius: 15,
                          //       backgroundColor: Pallets.white,
                          //       child: GestureDetector(
                          //         onTap: () {
                          //           likeproduct.add(LikeItemEvent( product[index].id.toString()));
                          //         },
                          //         child: Icon(
                          //           Icons.favorite_border,
                          //           size: 18,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),


                          Container(
                            height: 30,
                            width: 55,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Color(0xff3567a6),
                            ),
                            child: Center(
                              child: TextView(
                                text:
                                "${calculateDiscountPercentage(products?[index].price??'', products?[index].discountPrice??'')}% OFF",
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
            );
          },
        ),
      );
    }
    return SizedBox();
  },
),
    );
  }

  void _listenToVendorproductstate(BuildContext context, ProductsState state
      ) {
    if(state is ProductsloadingState){
      CustomDialogs.showLoading(context);
    }
    if(state is ProductsFailiureState){
      context.pop();

    }
    if(state is GetVendorsProductSuccessState){
      context.pop();
    }
  }
}
