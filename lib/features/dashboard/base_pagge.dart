import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/navigation/route_url.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/widgets/custom_appbar.dart';
import '../../common/widgets/image_widget.dart';
import '../../core/constants/package_exports.dart';
import '../../core/di/injector.dart';
import '../../core/theme/pallets.dart';
import '../../gen/assets.gen.dart';
import '../cart/presentations/cartbloc/cart_bloc.dart';

final GlobalKey<ScaffoldState> baseScaffoldKey = GlobalKey<ScaffoldState>();

class BasePage extends StatefulWidget {
  const BasePage({
    super.key,
    this.passedIndex = 0,
    required this.navigationShell,
  });

  final int passedIndex;

  final StatefulNavigationShell navigationShell;

  @override
  State createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with WidgetsBindingObserver {
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    mycart.add(GetCartEvent());
    // context.read<CartBloc>().add(GetCartEvent());
  }

  final mycart = injector.get<CartBloc>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    logger.i("APP STATE: $state");

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached)
      return;
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          widget.navigationShell.currentIndex == 3
              ? null
              : AppBar(
                centerTitle: false,
                title: SizedBox(
                  width: 130,
                  child: ImageWidget(imageUrl: "assets/images/pngs/logo.png"),
                ),
                actions: [
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      context.pushNamed(PageUrl.search_screen);
                    },

                    child: Icon(
                      Iconsax.search_normal,
                      color: Color(0xffE67002),
                    ),
                  ),
                  20.horizontalSpace,
                ],
              ),
      key: baseScaffoldKey,
      extendBody: true,
      body: widget.navigationShell,

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.navigationShell.currentIndex,
        onTap: _goBranch,
        elevation: 3,

        unselectedItemColor: Pallets.grey35,
        selectedItemColor: Color(0xffE67002),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        // backgroundColor
        // : Pallets.whitecolor,
        selectedLabelStyle: GoogleFonts.poppins(
          color: Pallets.mildBlue,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: IgnorePointer(child: Icon(Icons.home_outlined)),
            activeIcon: IgnorePointer(child: Icon(Icons.home_outlined)),
          ),
          BottomNavigationBarItem(
            label: 'Categories',
            icon: IgnorePointer(child: Icon(Iconsax.book)),
            activeIcon: IgnorePointer(child: Icon(Iconsax.book)),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: IgnorePointer(
              child: BlocConsumer<CartBloc, CartState>(
                bloc: mycart,
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is GetCartSuccessState) {
                    final cartitems = state.response.data?.items;


                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(Icons.shopping_cart_outlined),
                        cartitems!.isEmpty?SizedBox(): Positioned(
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
            activeIcon: IgnorePointer(
              child: Icon(Icons.shopping_cart_outlined),
            ),
          ),
          // BottomNavigationBarItem(
          //   label: 'Wishlist',
          //   icon: IgnorePointer(
          //       child:Icon(Icons.favorite_border)
          //   ),
          //   activeIcon: IgnorePointer(
          //       child: Icon(Icons.favorite_border)
          //   ),
          // ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: IgnorePointer(child: Icon(Iconsax.profile_tick5)),
            activeIcon: IgnorePointer(child: Icon(Iconsax.profile_tick5)),
          ),
        ],
      ),
    );
  }
}
