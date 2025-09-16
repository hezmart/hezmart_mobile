import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:hezmart/app_config.dart';
import 'core/constants/package_exports.dart';
import 'core/navigation/routes.dart';

import 'core/services/network/url_config.dart';
import 'core/services/theme_service/app_theme.dart';

// Worksndshop

void main() {
  AppConfig.initializeAndRunInstance(
      appName: "Hezmart", enviroment: Environment.staging);
}

class Hezmart extends StatelessWidget {
  const Hezmart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        builder: (contextAlt, child) {
          return OverlaySupport.global(
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: MaterialApp.router(
                // theme: ThemeData(),
                // theme: AppTheme.lightTheme,
                // darkTheme:AppTheme.darkTheme,
                debugShowCheckedModeBanner: false,
                title: "Hezmart",
                //TODO: SET LOCALE HERE
                // locale: ref.watch(localeProvider).locale,
                localizationsDelegates: const [
                  // S.delegate,
                  // GlobalMaterialLocalizations.delegate,
                  // GlobalWidgetsLocalizations.delegate,
                  // GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('es'), // Spanish
                ],

                routerConfig: CustomRoutes.goRouter,
              ),
            ),
          );
        });
  }
}
