import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/image_widget.dart';
import '../../core/navigation/route_url.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        context.goNamed(PageUrl.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          height: 80,
          child: ImageWidget(
            imageUrl: "assets/images/pngs/logo.png",
            imageType: ImageWidgetType.asset,
          ),
        ),
      ),
    );
  }
}
