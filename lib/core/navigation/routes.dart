import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/core/navigation/path_params.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/features/account/presentations/screens/edit_profile.dart';
import 'package:hezmart/features/account/presentations/screens/help_tab.dart';
import 'package:hezmart/features/account/presentations/screens/my_profile.dart';
import 'package:hezmart/features/account/presentations/screens/privacy.dart';
import 'package:hezmart/features/authentication/presentations/screens/complete_account.dart';
import 'package:hezmart/features/authentication/presentations/screens/create_new_password.dart';
import 'package:hezmart/features/authentication/presentations/screens/otp_screen.dart';
import 'package:hezmart/features/authentication/presentations/screens/signin_screen.dart';
import 'package:hezmart/features/authentication/presentations/screens/signup_screen.dart';
import 'package:hezmart/features/cart/presentations/cartbloc/cart_bloc.dart';
import 'package:hezmart/features/cart/presentations/screens/cash_success_order.dart';
import 'package:hezmart/features/cart/presentations/screens/proceed_checkout.dart';
import 'package:hezmart/features/cart/presentations/screens/success_order.dart';
import 'package:hezmart/features/cart/presentations/screens/track_item.dart';
import 'package:hezmart/features/categories/presentations/screens/all_products.dart';
import 'package:hezmart/features/categories/presentations/screens/category_details.dart';
import 'package:hezmart/features/homescreen/presentations/screens/product_details.dart';
import 'package:hezmart/features/homescreen/presentations/screens/see_all.dart';
import 'package:hezmart/features/homescreen/presentations/screens/shop_vendor_products.dart';
import 'package:hezmart/features/homescreen/presentations/screens/shopsscreen.dart';
import 'package:hezmart/features/homescreen/presentations/widgets/description_details.dart';
import 'package:hezmart/features/my_orders/presentations/sscreens/my_orders.dart';
import 'package:hezmart/features/my_orders/presentations/sscreens/order_details.dart';
import 'package:hezmart/features/my_orders/presentations/sscreens/track_order.dart';
import 'package:hezmart/features/notificationss/presentationss/screens/notification_screen.dart';
import 'package:hezmart/features/search/presentations/screens/search_screen.dart';
import 'package:hezmart/features/wishlist/presentations/fav_bloc/favourite_bloc.dart';
import '../../features/account/presentations/screens/Profile.dart';
import '../../features/account/presentations/screens/customer_ssupport.dart';
import '../../features/authentication/presentations/screens/forgot_password.dart';
import '../../features/authentication/presentations/screens/signup_otp.dart';
import '../../features/cart/presentations/screens/my_cart.dart';
import '../../features/categories/presentations/screens/categories.dart';
import '../../features/categories/presentations/screens/getsubcatss.dart';
import '../../features/dashboard/base_pagge.dart';
import '../../features/homescreen/presentations/screens/homescreen.dart';
import '../../features/onboading/splash_screen.dart';
import '../../features/wishlist/presentations/screens/wishlist.dart';
import '../di/injector.dart';
// import 'package:workandshop/core/navigation/route_url.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');
final _shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'shellE');

final vendorshellNavigatorAKey = GlobalKey<NavigatorState>(
  debugLabel: 'vendorshellA',
);
final vendorshellNavigatorBKey = GlobalKey<NavigatorState>(
  debugLabel: 'vendorshellB',
);
final vendorrshellNavigatorCKey = GlobalKey<NavigatorState>(
  debugLabel: 'vendorshellC',
);
final vendorshellNavigatorDKey = GlobalKey<NavigatorState>(
  debugLabel: 'vendorshellD',
);
final vendorshellNavigatorEKey = GlobalKey<NavigatorState>(
  debugLabel: 'vendorshellE',
);

final bloc = injector.get<CartBloc>();
final faavbloc = injector.get<FavouriteBloc>();
final cartcheckout = injector.get<CartBloc>();
final success = injector.get<CartBloc>();
class CustomRoutes {
  static final goRouter = GoRouter(
    initialLocation: '/splash_screen',
    // initialLocation: '/profile/setupProfileIntroPage/setupProfilePage',
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash_screen',
        name: PageUrl.splash_screen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/signup_screen',
        name: PageUrl.signup_screen,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/signin_screen',
        name: PageUrl.signin_screen,
        builder: (context, state) => const SigninScreen(),
      ),  GoRoute(
        path: '/success_order',
        name: PageUrl.success_order,
        builder: (context, state) => const SuccessOrder(),
      ),
      GoRoute(
        path: '/forgot_password',
        name: PageUrl.forgot_password,
        builder: (context, state) => const ForgotPassword(),
      ),
      GoRoute(
        path: '/otp_screen',
        name: PageUrl.otp_screen,
        builder:
            (context, state) => OtpScreen(
              email: state.uri.queryParameters[PathParam.email] ?? '',
            ),
      ),
      GoRoute(
        path: '/signup_otp',
        name: PageUrl.signup_otp,
        builder:
            (context, state) => SignupOtp(
              email: state.uri.queryParameters[PathParam.email] ?? '',
            ),
      ),
      GoRoute(
        path: '/create_new_password',
        name: PageUrl.create_new_password,
        builder: (context, state) => const CreateNewPassword(),
      ),
      // GoRoute(
      //   path: '/mypro',
      //   name: PageUrl.mypro,
      //   builder: (context, state) => const SizedBox(),
      // ),
      GoRoute(
        path: '/complete_account',
        name: PageUrl.complete_account,
        builder: (context, state) => const CompleteAccount(),
      ),
      GoRoute(
        path: '/product_details',
        name: PageUrl.product_details,
        builder:
            (context, state) => ProductDetails(
              id: state.uri.queryParameters[PathParam.id] ?? '',
            ),
      ),
      GoRoute(
        path: '/proceed_checkout',
        name: PageUrl.proceed_checkout,
        builder:
            (context, state) => BlocProvider.value(
              value: cartcheckout,
              child: ProceedCheckout(
                total: (state.extra as ProceedParams).total,
                subtotal: (state.extra as ProceedParams).subtotal,
                discount: (state.extra as ProceedParams).discount,
                // id: state.uri.queryParameters[PathParam.id] ?? '',
              ),
            ),
      ),
      GoRoute(
        path: '/category_details',
        name: PageUrl.category_details,
        builder: (context, state) => const CategoryDetails(),
      ),
      GoRoute(
        path: '/all_products',
        name: PageUrl.all_products,
        builder: (context, state) => const AllProducts(),
      ),
      GoRoute(
        path: '/wishlist',
        name: PageUrl.wishlist,
        builder:
            (context, state) =>
                BlocProvider.value(value: faavbloc, child: Wishlist()),
      ),
      GoRoute(
        path: '/my_orders',
        name: PageUrl.my_orders,
        builder: (context, state) => const MyOrders(),
      ),
      GoRoute(
        path: '/track_item',
        name: PageUrl.track_item,
        builder: (context, state) => const TrackItem(),
      ),
      GoRoute(
        path: '/shopsscreen',
        name: PageUrl.shopsscreen,
        builder: (context, state) => const Shopsscreen(),
      ),
      GoRoute(
        path: '/see_all',
        name: PageUrl.see_all,
        builder: (context, state) =>  SeeAll(catId: state.uri.queryParameters[PathParam.id] ?? '', name:  state.uri.queryParameters[PathParam.userName] ?? '',),
      ),      GoRoute(
        path: '/cash_success_order',
        name: PageUrl.cash_success_order,
        builder: (context, state) =>  BlocProvider.value(value: success,
        child: CashSuccessOrder(ref: (state.extra as CashSuccessOrderParams).ref, url: (state.extra as CashSuccessOrderParams).url)),
      ),   GoRoute(
        path: '/description_details',
        name: PageUrl.description_details,
        builder: (context, state) =>  DescriptionDetails(
          description: (state.extra as DesParams).description,
          category: (state.extra as DesParams).category,
          subCategory: (state.extra as DesParams).subCategory,
          weight: (state.extra as DesParams).weight,
          taxable:(state.extra as DesParams).taxable,
          isDigital: (state.extra as DesParams).isDigital,),
      ),
      GoRoute(
        path: '/shop_vendor_products',
        name: PageUrl.shop_vendor_products,
        builder:
            (context, state) => ShopVendorProducts(
              id: state.uri.queryParameters[PathParam.id] ?? '',
              name: state.uri.queryParameters[PathParam.userName] ?? '',
            ),
      ),
      GoRoute(
        path: '/search_screen',
        name: PageUrl.search_screen,
        builder: (context, state) => const SearchScreen(),
      ),  GoRoute(
        path: '/help',
        name: PageUrl.help,
        builder: (context, state) => const HelpTab(),
      ),

      GoRoute(
        path: '/privacy',
        name: PageUrl.privacy,
        builder: (context, state) => const PrivacyPolicy(),
      ),
      GoRoute(
        path: '/order_details',
        name: PageUrl.order_details,
        builder:
            (context, state) =>
                OrderDetails(id: state.uri.queryParameters[PathParam.id] ?? ''),
      ),
      GoRoute(
        path: '/track_order',
        name: PageUrl.track_order,
        builder: (context, state) =>  TrackOrder(status: state.uri.queryParameters[PathParam.userName] ?? '',),
      ),
      GoRoute(
        path: '/getsubcatss',
        name: PageUrl.getsubcatss,
        builder:
            (context, state) => Getsubcatss(
              catId: (state.extra as SubCatParams).catId,
              subcatId: (state.extra as SubCatParams).subcatId,
              name: (state.extra as SubCatParams).name,
            ),
      ),
      GoRoute(
        path: '/my_profile',
        name: PageUrl.my_profile,
        builder: (context, state) => const MyProfile(),
      ),
      GoRoute(
        path: '/notification_screen',
        name: PageUrl.notification_screen,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/edit_profile',
        name: PageUrl.edit_profile,
        builder: (context, state) => const EditProfile(),
      ),
      GoRoute(
        path: '/customer_ssupport',
        name: PageUrl.customer_ssupport,
        builder: (context, state) => const CustomerSsupport(),
      ),

      StatefulShellRoute.indexedStack(
        // parentNavigatorKey: rootNavigatorKey,
        builder: (context, state, navigationShell) {
          return BasePage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: '/home',
                name: PageUrl.home,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: HomeScreen()),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                path: '/categories',
                name: PageUrl.categories,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: Categories()),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCKey,
            routes: [
              GoRoute(
                path: '/mycart',
                name: PageUrl.mycart,
                pageBuilder:
                    (context, state) => NoTransitionPage(
                      child: BlocProvider.value(value: bloc, child: MyCart()),
                    ),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: PageUrl.profile,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: Profile()),
                routes: [],
              ),
            ],
          ),
        ],
      ),

      /// <================Vendor Shell Route===================>
    ],
  );
}
