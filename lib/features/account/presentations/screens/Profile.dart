import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/custom_button.dart';
import 'package:hezmart/common/widgets/custom_dialogs.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/di/injector.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/features/authentication/data/data/repo_impl/authrepositoryimpl.dart';
import 'package:hezmart/features/authentication/presentations/authbloc/auth_bloc.dart';
import 'package:hezmart/features/authentication/presentations/user_bloc/user_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/info_dialog.dart';
import '../../../../core/services/data/session_manager.dart';
import '../../../../core/utils/helper_utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = injector.get<UserBloc>();
  final authbloc = AuthBloc(AuthRepositoryImpl(NetworkService()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   // leading: Icon(Iconsax.user),
      //   leading: SizedBox(),
      //   height: 100,
      //   tittle: TextView(
      //     text: "Account",
      //     fontSize: 18,
      //     fontWeight: FontWeight.w500,
      //
      //   ),
      //
      //   actions: [InkWell(
      //     onTap: (){
      //       context.pushNamed(PageUrl.notification_screen);
      //     },
      //       child: Icon(Iconsax.notification,)),20.horizontalSpace],
      // ),
      // appBar: PreferredSize(
      //   preferredSize: Size(1.sw, 140),
      //   child: Container(
      //     padding: EdgeInsets.only(left: 25, top: 20),
      //     // color: Color(0xffE67002),
      //     color:
      //     Colors.black,
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         20.verticalSpace,
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             TextView(
      //               text: "Account",
      //               fontSize: 20,
      //               color: Colors.white,
      //               fontWeight: FontWeight.w600,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(right: 20),
      //               child: InkWell(
      //                 splashColor: Colors.transparent,
      //                 onTap: () {
      //                   context.pushNamed(PageUrl.search_screen);
      //                 },
      //
      //                 child: Icon(
      //                   Iconsax.search_normal,
      //                   // color: Color(0xffE67002),
      //
      //                   color: Colors.white,
      //                   size: 18,
      //                 ),
      //               ),
      //             ),
      //
      //
      //           ],
      //         ),
      //
      //         30.verticalSpace,
      //         TextView(
      //           text: "Welcome ${user.appUser?.firstName ?? ''}!",
      //           color: Color(0xffE67002),
      //           fontSize: 18,
      //           fontWeight: FontWeight.w600,
      //
      //         ),
      //         TextView(
      //           text: user.appUser?.email ?? '',
      //           color: Colors.white,
      //           fontSize: 12,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      appBar: PreferredSize(
        preferredSize: Size(1.sw, 120),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10), // Reduced padding
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Better spacing
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextView(
                      text: "Account",
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      // overflow: TextOverflow.ellipsis, // Handle long text
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      context.pushNamed(PageUrl.search_screen);
                    },
                    child: Icon(
                      Iconsax.search_normal,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "Welcome ${user.appUser?.firstName ?? ''}!",
                    color: Color(0xffE67002),
                    fontSize: 16, // Slightly smaller font
                    fontWeight: FontWeight.w600,
                    // overflow: TextOverflow.ellipsis,
                  ),

                  TextView(
                    text: user.appUser?.email ?? '',
                    color: Colors.white,
                    fontSize: 11, // Slightly smaller font
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

        20.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(text: "Need Assistance",fontSize: 12,),
                  5.verticalSpace,
                  InkWell(
                    onTap: (){
                      Helpers.launchRawUrl('https://hezmart.com/#max-widget');

                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      color:Color(0xffE67002) ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(Icons.support_agent_rounded,color: Colors.white,),10.horizontalSpace,
                          TextView(text: "Contact live support",color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextView(text: "Wallet",fontSize: 17,fontWeight: FontWeight.w500,),
                  // 20.verticalSpace,
                  // ProfileItem(widget: Icon(Iconsax.wallet,size: 17,), text: 'Wallet',),
                  20.verticalSpace,

                  TextView(
                    text: "Account Information",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  Divider(),
                  20.verticalSpace,
                  ProfileItem(
                    widget: Icon(Iconsax.user, size: 17),
                    text: 'My Profile',
                    ontap: () {
                      context.pushNamed(PageUrl.my_profile);
                    },
                  ),
                  ProfileItem(
                    widget: Icon(Icons.sell_outlined, size: 17),
                    text: 'Sell On Hezmart',
                    ontap: () {
                      Helpers.launchRawUrl('https://hezmart.com/sell-on-hezmart');
                      // context.pushNamed(PageUrl.my_orders);
                    },
                  ),
                  // 20.verticalSpace,
                  TextView(
                    text: "My Activities",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  Divider(),
                  20.verticalSpace,
                  ProfileItem(
                    widget: Icon(Icons.favorite_border, size: 17),
                    text: 'Saved Items',
                    ontap: () {
                      context.pushNamed(PageUrl.wishlist);
                    },
                  ),

                  ProfileItem(
                    widget: Icon(Iconsax.shopping_bag, size: 17),
                    text: 'My Orders',
                    ontap: () {
                      context.pushNamed(PageUrl.my_orders);
                    },
                  ),
                  ProfileItem(
                    widget: Icon(Iconsax.people, size: 17),
                    text: 'View Sellers',
                    ontap: () {
                      context.pushNamed(PageUrl.shopsscreen);
                    },
                  ),

                  // 20.verticalSpace,
                  TextView(
                    text: "Account Settings",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  Divider(),

                  20.verticalSpace,
                  ProfileItem(
                    widget: Icon(Icons.support_agent_rounded, size: 17),
                    text: 'Contact Us',
                    ontap: () {
                      context.pushNamed(PageUrl.help);
                    },
                  ),
                  // ProfileItem(
                  //   widget: Icon(Icons.support_agent_rounded, size: 17),
                  //   text: 'Contact Support',
                  //   ontap: () {
                  //     context.pushNamed(PageUrl.mypro);
                  //   },
                  // ),
                  0.verticalSpace,
                  ProfileItem(widget: Icon(Icons.logout, size: 17, color: Colors.red,),
                                    text: 'Logout',
                                    ontap: () {
                                      _logout(context);
                                      // context.pushNamed(PageUrl.mypro);
                                    },
                                  ),
                  // BlocConsumer<AuthBloc, AuthState>(
                  //   bloc: authbloc,
                  //   listener: _listenToSinoutState,
                  //   builder: (context, state) {
                  //
                  //     return ProfileItem(
                  //       widget: Icon(Icons.logout, size: 17, color: Colors.red,),
                  //       text: 'Logout',
                  //       ontap: () {
                  //         _signout();
                  //         // context.pushNamed(PageUrl.mypro);
                  //       },
                  //     );
                  //   },
                  // ),

                  20.verticalSpace,
                  // ProfileItem(widget: Icon(Iconsax.user), text: 'My Profile',)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signout() {
    authbloc.add(SignOutEvent());
  }

  void _listenToSinoutState(BuildContext context, AuthState state) {
    if(state is AuthloadingState){
      CustomDialogs.showLogout(context);

    }
    if(state is AuthfailiureState){
      context.pop();
      CustomDialogs.showToast("failed to logout");
    }
    if(state is SignOutSuccessState){
      context.pop();
      context.goNamed(PageUrl.signin_screen);
    }
  }

  void _logout(BuildContext context) async {
    //to  logout
    SessionManager().logOut();
    CustomDialogs.showCustomDialog(
        barrierDismissible: false,
        InfoDialog(
          footer: Padding(
            padding: const EdgeInsets.all(16.0),
            child: 0.horizontalSpace,
          ),
          tittle: "Signing Out",
          subtittle:
          "You will be redirected to the login page in a few seconds",
        ),
        context);
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
          () {
        context.goNamed(PageUrl.signin_screen);
      },
    );
  }
}

class ProfileItem extends StatefulWidget {
  final Widget widget;
  final String text;
  final VoidCallback ontap;

  const ProfileItem({
    super.key,
    required this.widget,
    required this.text,
    required this.ontap,
  });

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: widget.ontap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget.widget,
                10.horizontalSpace,
                TextView(
                  text: widget.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16,color: Colors.grey,),
          ],
        ),
      ),
    );
  }
}
