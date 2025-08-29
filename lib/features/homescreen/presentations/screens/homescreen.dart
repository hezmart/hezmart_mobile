import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/error_widget.dart';
import 'package:hezmart/common/widgets/image_widget.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/di/injector.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/utils/theme/app_colors.dart';
import 'package:hezmart/features/homescreen/data/data/product_repo_impl/product_repo_impl.dart';
import 'package:hezmart/features/homescreen/presentations/bloc/products_bloc.dart';
import 'package:hezmart/features/homescreen/presentations/widgets/flash_sales.dart';
import 'package:hezmart/features/homescreen/presentations/widgets/weekly_offer.dart';
import 'package:hezmart/features/wishlist/data/data/repossitory_impl/repossitory_impl.dart';
import 'package:hezmart/features/wishlist/presentations/fav_bloc/favourite_bloc.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:upgrader/upgrader.dart';

import '../../../../common/widgets/custom_dialogs.dart';
import '../../../../common/widgets/shimmer_box_widget.dart';
import '../../../../core/navigation/path_params.dart';
import '../../../../core/theme/pallets.dart';
import '../../../authentication/presentations/user_bloc/user_bloc.dart';
import '../../../cart/data/data/cart_repo_impl.dart';
import '../../../cart/data/models/cart_payload.dart';
import '../../../cart/presentations/cartbloc/cart_bloc.dart';
import '../../../categories/presentations/screens/getsubcatss.dart';
import '../../data/models/getall_products.dart';
import '../widgets/brandnew.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List images = [
    "assets/images/pngs/shop.jpg",
    "assets/images/pngs/shop4.jpg",
    "assets/images/pngs/shop5.jpg",
  ];
  int _currentIndex = 0;
  final products = ProductsBloc(ProductRepositoryImpl(NetworkService()));
  final likeproduct = FavouriteBloc(
    MyfavouritesRepositoryImpl(NetworkService()),
  );
  final unlikeproduct = FavouriteBloc(
    MyfavouritesRepositoryImpl(NetworkService()),
  );
  final likedproduct = FavouriteBloc(
    MyfavouritesRepositoryImpl(NetworkService()),
  );
  @override
  void initState() {
    // TODO: implement initState
    likedproduct.add(GetfavouriteEvent());
    products.add(GetAllProductsEvent());

    super.initState();
  }

  final cart = CartBloc(CartRepositoryImpl(NetworkService()));
  GetAllProductsResponse? allResponse;
  final Set<String> likedProductIds = {};

  Future<void> _refreshHome() async {
    products.add(GetAllProductsEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        dialogStyle: Platform.isIOS
        ? UpgradeDialogStyle.cupertino
        : UpgradeDialogStyle.material,
        shouldPopScope: ()=>true,
    upgrader: Upgrader(

    durationUntilAlertAgain: Duration(
    days: 2,

    ),

    ),
        child: SingleChildScrollView(
          child: BlocConsumer<ProductsBloc, ProductsState>(
            bloc: products,
            listener: _listenToProductState,
            builder: (context, state) {
              if (state is ProductsFailiureState) {
                return SizedBox(
                  height: 1.sh,

                  child: Center(
                    child: AppPromptWidget(
                      onTap: () {
                        products.add(GetAllProductsEvent());
                      },
                    ),
                  ),
                );
              }
              if (state is ProductsSuccessState) {
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

                allResponse = state.response;
                logger.w(state.response.data?.products.first.name ?? '');
                final product = state.response.data?.products;
                // final uniqueCategories = product!
                //     .map((item) => item.category?.name)
                //     .where((name) => name != null)
                //     .toSet()
                //     .toList();
                final Map<String, List<Product>> productsByCategory = {};

                for (var item in product!) {
                  final categoryName = item.category?.name ?? 'Others';
                  if (!productsByCategory.containsKey(categoryName)) {
                    productsByCategory[categoryName] = [];
                  }
                  productsByCategory[categoryName]!.add(item);
                }

                return RefreshIndicator(

                  onRefresh:_refreshHome,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
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
                        Stack(
                          children: [
                            CarouselSlider(
                              items:
                                  images.map((image) {
                                    return ImageWidget(
                                      imageUrl: image,
                                      width: 1.sw,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    );
                                  }).toList(),
                              options: CarouselOptions(
                                height: 200,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration: Duration(
                                  milliseconds: 800,
                                ),
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              ),
                            ),
                            Column(
                              children: [
                                10.verticalSpace,
                                TextView(
                                  text: "Get Quality products at affordable prices",
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  align: TextAlign.center,
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    context.pushNamed(PageUrl.shopsscreen);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 200,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffE67002)
                                    ),
                                    child: TextView(
                                      text: "Shop Now",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 200,
                                //   height: 60,
                                //   child: CustomButton(
                                //     isExpanded: true,
                                //     // padding: EdgeInsets.symmetric(horizontal: 20),
                                //     onPressed: () {
                                //       context.pushNamed(PageUrl.shopsscreen);
                                //     },
                                //     // bgColor: Color(0xffE67002),
                                //     child: TextView(
                                //       text: "Shop Now",
                                //       fontWeight: FontWeight.w600,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    images.asMap().entries.map((entry) {
                                      return Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              _currentIndex == entry.key
                                                  ? Colors.white
                                                  : Colors.white.withOpacity(0.4),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ],
                        ),

                        20.verticalSpace,

                        Column(
                          children:
                              productsByCategory.entries.map((entry) {
                                final categoryName = entry.key;
                                final categoryProducts = entry.value;
                                final categoryId =
                                    categoryProducts.first.category?.id
                                        .toString() ??
                                    '';
                                return Column(
                                  children: [
                                    10.verticalSpace,
                                    Container(
                                      height: 60,
                                      width: 1.sw,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                      ),
                                      color: Color(0xffE67002).withOpacity(0.8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextView(
                                            text: categoryName,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          TextView(
                                            onTap: () {
                                              context.pushNamed(
                                                PageUrl.see_all,
                                                queryParameters: {
                                                  PathParam.id: categoryId,
                                                  PathParam.userName: categoryName,
                                                },
                                              );
                                            },
                                            text: 'See All',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.verticalSpace,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: GridView(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: .7,
                                            ),
                                        padding: EdgeInsets.only(bottom: 10),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: List.generate(categoryProducts.take(10).length, (
                                          index,
                                        ) {
                                          final prod = categoryProducts[index];
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
                                            return ((1 -
                                                        discountedPrice /
                                                            originalPrice) *
                                                    100)
                                                .round();
                                          }

                                          final productId = prod.id.toString();
                                          final isLiked = likedProductIds.contains(
                                            productId,
                                          );

                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                              border: Border.all(
                                                color: Pallets.grey95,
                                              ),
                                            ),
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        onTap: () {
                                                          context.pushNamed(
                                                            PageUrl.product_details,
                                                            queryParameters: {
                                                              PathParam.id:
                                                                  prod.id
                                                                      .toString(),
                                                            },
                                                          );
                                                        },
                                                        child: Center(
                                                          child: IgnorePointer(
                                                            child: ImageWidget(
                                                              imageUrl:
                                                                  prod.coverImage
                                                                      .toString(),
                                                              size: 150,
                                                              fit: BoxFit.scaleDown,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    4.verticalSpace,
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                          ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          InkWell(
                                                            splashColor:
                                                                Colors.transparent,
                                                            onTap: () {
                                                              context.pushNamed(
                                                                PageUrl
                                                                    .product_details,
                                                                queryParameters: {
                                                                  PathParam.id:
                                                                      prod.id
                                                                          .toString(),
                                                                },
                                                              );
                                                            },
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                TextView(
                                                                  text:
                                                                      prod.name ??
                                                                      '',
                                                                  maxLines: 2,
                                                                  fontSize: 13,
                                                                ),
                                                                6.verticalSpace,
                                                                StockIndicator(
                                                                  stockQuantity:
                                                                      prod.stockQuantity,
                                                                ),
                                                                6.verticalSpace,
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    RatingBar.builder(
                                                                      ignoreGestures:
                                                                          true,
                                                                      initialRating:
                                                                          double.tryParse(
                                                                            prod.ratingsAverage
                                                                                .toString(),
                                                                          ) ??
                                                                          0,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      itemSize: 16,
                                                                      allowHalfRating:
                                                                          false,
                                                                      itemCount: 5,
                                                                      unratedColor:
                                                                          Pallets
                                                                              .grey90,
                                                                      itemPadding:
                                                                          EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                0.0,
                                                                          ),
                                                                      itemBuilder:
                                                                          (
                                                                            context,
                                                                            _,
                                                                          ) => const Icon(
                                                                            Icons
                                                                                .star_border_outlined,
                                                                            color:
                                                                                Colors.amber,
                                                                            size:
                                                                                14,
                                                                          ),
                                                                      onRatingUpdate:
                                                                          (
                                                                            double
                                                                            value,
                                                                          ) {},
                                                                    ),
                                                                    5.horizontalSpace,
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "₦${formatNumberWithCommas(prod.discountPrice.toString())}",
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "₦${formatNumberWithCommas(prod.price.toString())}",
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            decoration:
                                                                                TextDecoration.lineThrough,
                                                                            fontSize:
                                                                                10,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    BlocConsumer<CartBloc, CartState>(
                                                                      bloc: cart,
                                                                      listener:(BuildContext context, CartState state) {
                                                                        if (state is AddCartloadingState) {
                                                                          CustomDialogs.showLoading(context,barrierColor: Colors.transparent);
                                                                        }
                                                                        if (state is CartfailiureState) {
                                                                          context.pop();
                                                                          CustomDialogs.error(state.error);
                                                                        }
                                                                        if (state is AddCartSuccessState) {
                                                                          context.pop();
                                                                          CustomDialogs.success("Item added to cart");
                                                                        }
                                                                      },

                                                                      builder: (context, state,) {
                                                                        return InkWell(
                                                                          splashColor: Colors.transparent,
                                                                          onTap: injector.get<UserBloc>().appUser != null?() {
                                                                            addToCart(
                                                                              productId,
                                                                            );
                                                                          }:(){
                                                                            CustomDialogs.showToast("Login to add to cart");
                                                                          },
                                                                          child: CircleAvatar(
                                                                            backgroundColor:
                                                                                Color(
                                                                                  0xffE67002,
                                                                                ),
                                                                            radius:
                                                                                14,
                                                                            child: Icon(
                                                                              Icons
                                                                                  .add_shopping_cart,
                                                                              size:
                                                                                  16,
                                                                              color:
                                                                                  Colors.white,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
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
                                                  padding: const EdgeInsets.only(
                                                    left: 5,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                          if (state is FavouriteUnlikeSuccessState) {
                                                            context.pop();
                                                            likedProductIds.remove(state.productId);
                                                            setState(() {});
                                                            CustomDialogs.showToast("Removed from favourite");
                                                          }
                                                        },
                                                        builder: (context, state) {
                                                          final currentProductId = prod.id.toString(); // ✅ Get from loop item

                                                          return CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor: Pallets.white,
                                                            child: GestureDetector(
                                                              onTap: injector.get<UserBloc>().appUser != null?() {
                                                                if (likedProductIds.contains(currentProductId)) {
                                                                  likeproduct.add(UnlikeItemEvent(currentProductId)); // ✅ send correct id
                                                                } else {
                                                                  likeproduct.add(LikeItemEvent(currentProductId));
                                                                }
                                                              }:(){
                                                                CustomDialogs.showToast("Login to add favorite");
                                                              },
                                                              child: Icon(
                                                                likedProductIds.contains(currentProductId)
                                                                    ? Icons.favorite
                                                                    : Icons.favorite_border,
                                                                color: likedProductIds.contains(currentProductId)
                                                                    ? Colors.red
                                                                    : Colors.black,
                                                                size: 18,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),



                                                      Container(
                                                        height: 30,
                                                        width: 55,
                                                        padding: EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                topRight:
                                                                    Radius.circular(
                                                                      10,
                                                                    ),
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                      10,
                                                                    ),
                                                              ),
                                                          color: Color(0xff3567a6),
                                                        ),
                                                        child: Center(
                                                          child: TextView(
                                                            text:
                                                                "${calculateDiscountPercentage(prod.price.toString(), prod.discountPrice.toString())}% OFF",
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    10.verticalSpace,
                                  ],
                                );
                              }).toList(),
                        ),

                        // 10.verticalSpace,
                        70.verticalSpace,
                      ],
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  void _listenToAddCatState(BuildContext context, CartState state) {
    if (state is CartloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is CartfailiureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is AddCartSuccessState) {
      context.pop();
      CustomDialogs.success("Item added to cart");
    }
  }

  void addToCart(String productId) {
    cart.add(
      AddItemToCart(
        AddToCartpayload(
          productId: productId,
          quantity: "1",
          options: Options(size: "", color: ""),
        ),
      ),
    );
  }

  //
  // void addToCart() {
  //   cart.add(
  //   AddItemToCart(
  //     AddToCartpayload(
  //       productId: allResponse?.data?.products.first.id,
  //       quantity: "1",
  //       options: Options(size: "", color: ""),
  //     ),
  //   ),
  //   );
  // }

  void _listenToProductState(BuildContext context, ProductsState state) {
    if (state is ProductsloadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is ProductsFailiureState) {
      context.pop();
    }
    if (state is ProductsSuccessState) {
      context.pop();
    }
  }
}

class StockIndicator extends StatelessWidget {
  final int stockQuantity;

  const StockIndicator({super.key, required this.stockQuantity});

  @override
  Widget build(BuildContext context) {
    final double stockPercentage = (stockQuantity / 20 * 100).clamp(0, 100);
    final String stockMessage = _getStockMessage(stockQuantity);
    final Color stockLevelColor = _getStockLevelColor(stockQuantity);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stock text info
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stockMessage,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
              Text(
                '${stockQuantity} avail.',
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),

        // Progress bar
        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth * (stockPercentage / 100),
                    decoration: BoxDecoration(
                      color: stockLevelColor,
                      borderRadius: BorderRadius.circular(4),
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

  String _getStockMessage(int quantity) {
    if (quantity >= 15) return 'In Stock';
    if (quantity >= 5) return 'Low Stock';
    if (quantity >= 1) return 'Very Low Stock';
    return 'Out of Stock';
  }

  Color _getStockLevelColor(int quantity) {
    if (quantity >= 15) return Colors.green;
    if (quantity >= 5) return Colors.orange;
    if (quantity >= 1) return Colors.red;
    return Colors.grey;
  }
}
// TextView(
//   text: "Featured Products",
//   fontSize: 25,
//   fontWeight: FontWeight.w600,
// ),
// TextView(
//   text: "Discover Our Latest Collection",
//   fontSize: 12,
// ),
// 20.verticalSpace,
// Column(
//   children: uniqueCategories.map((categoryName) => Column(
//     children: [
//       Container(
//         width: 1.sw,
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         color: Colors.grey.withOpacity(0.4),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             TextView(
//               text: categoryName ?? '',
//               fontWeight: FontWeight.w600,
//             ),
//             TextView(
//               text: 'See All',
//               fontWeight: FontWeight.w500,
//               fontSize: 12,
//             ),
//           ],
//         ),
//       ),
//       10.verticalSpace,
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: GridView(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 10,
//             childAspectRatio: .7,
//           ),
//           physics: NeverScrollableScrollPhysics(),
//
//           shrinkWrap: true,
//           children: List.generate(product!.length, (index) {
//             int calculateDiscountPercentage(
//                 String price,
//                 String discountPrice,
//                 ) {
//               final double originalPrice =
//                   double.tryParse(price) ?? 0;
//               final double discountedPrice =
//                   double.tryParse(discountPrice) ?? 0;
//
//               if (discountedPrice <= 0 ||
//                   discountedPrice >= originalPrice)
//                 return 0;
//
//               return ((1 - discountedPrice / originalPrice) * 100)
//                   .round();
//             }
//
//             // int discountPercentage= calculateDiscountPercentage('1000', '750');
//             return Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Pallets.grey95),
//               ),
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           splashColor: Colors.transparent,
//                           onTap: () {
//                             context.pushNamed(
//                               PageUrl.product_details,
//                               queryParameters: {
//                                 PathParam.id:
//                                 product![index].id.toString(),
//                               },
//                             );
//                           },
//                           child: Center(
//                             child: IgnorePointer(
//                               child: ImageWidget(
//                                 imageUrl:
//                                 product![index].coverImage
//                                     .toString(),
//
//                                 size: 150,
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       4.verticalSpace,
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 5,
//                         ),
//                         child: Column(
//                           crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                           children: [
//                             InkWell(
//                               splashColor: Colors.transparent,
//                               onTap: () {
//                                 context.pushNamed(
//                                   PageUrl.product_details,
//                                   queryParameters: {
//                                     PathParam.id:
//                                     product[index].id
//                                         .toString(),
//                                   },
//                                 );
//                               },
//                               child: Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 children: [
//                                   TextView(
//                                     text:
//                                     product?[index].name ??
//                                         '',
//                                     maxLines: 3,
//                                     fontSize: 13,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment
//                                         .spaceBetween,
//                                     children: [
//
//                                       Text(
//
//                                         "₦${formatNumberWithCommas(product![index].discountPrice.toString())}",
//                                         style: TextStyle(fontWeight:
//                                         FontWeight.w700,),
//                                       ),Text(
//
//                                         "₦${formatNumberWithCommas(product![index].price.toString())}",
//                                         style: TextStyle(fontWeight:
//                                         FontWeight.w700,
//                                           decoration:
//                                           TextDecoration
//                                               .lineThrough,
//                                           fontSize: 10,
//                                         ),
//                                       ),
//
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment
//                                         .spaceBetween,
//                                     children: [
//
//                                       RatingBar.builder(
//                                         ignoreGestures: true,
//                                         initialRating:
//                                         double.tryParse(
//                                           product[index]
//                                               .ratingsAverage
//                                               .toString(),
//                                         )!.toDouble(),
//                                         direction:
//                                         Axis.horizontal,
//                                         itemSize: 16,
//                                         allowHalfRating: false,
//                                         itemCount: 5,
//                                         unratedColor:
//                                         Pallets.grey90,
//                                         itemPadding:
//                                         EdgeInsets.symmetric(
//                                           horizontal: 0.0,
//                                         ),
//                                         itemBuilder:
//                                             (
//                                             context,
//                                             _,
//                                             ) => const Icon(
//                                           Icons
//                                               .star_border_outlined,
//                                           color: Colors.amber,
//                                           size: 14,
//                                         ),
//                                         onRatingUpdate:
//                                             (double value) {},
//                                         // onRatingUpdate: (rating) {
//                                         //   print(rating);
//                                         //   setState(() {
//                                         //     setState(() {
//                                         //       // _rating = rating;
//                                         //     });
//                                         //   });
//                                         // },
//                                       ),
//                                       5.horizontalSpace,
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             6.verticalSpace,
//                             StockIndicator(
//                               stockQuantity:
//                               product[index].stockQuantity,
//                             ),
//                             6.verticalSpace,
//                             5.verticalSpace,
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 5),
//                     child: Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                       children: [
//                         BlocConsumer<FavouriteBloc, FavouriteState>(
//                           bloc: likeproduct,
//                           listener: (context, state) {
//                             if (state is FavouriteloadingState) {
//                               CustomDialogs.showLoading(context, barrierColor: Colors.transparent);
//                             }
//                             if (state is FavouritefailiureState) {
//                               context.pop();
//                             }
//                             if (state is FavouritelikeSuccessState) {
//
//                               context.pop();
//                               likedProductIds.add(state.productId);
//                               setState(() {});
//                               CustomDialogs.showToast("Added to favourite");
//                             }
//                           },
//                           builder: (context, state) {
//                             final productId = product[index].id.toString();
//                             final isLiked = likedProductIds.contains(productId);
//                             return CircleAvatar(
//                               radius: 15,
//                               backgroundColor: Pallets.white,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   likeproduct.add(LikeItemEvent(productId));
//                                 },
//                                 child: Icon(
//                                   isLiked ? Icons.favorite : Icons.favorite_border,
//                                   color: isLiked ? Colors.red : Colors.black,
//                                   size: 18,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         Container(
//                           height: 30,
//                           width: 55,
//                           padding: EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(10),
//                               bottomLeft: Radius.circular(10),
//                             ),
//                             color: Color(0xffFF4545),
//                           ),
//                           child: Center(
//                             child: TextView(
//                               text:
//                               "${calculateDiscountPercentage(product[index].price.toString(), product[index].discountPrice.toString())}% OFF",
//                               color: Colors.white,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//         ),
//       ),
//     ],
//   )).toList(),
// ),