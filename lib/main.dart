import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_movies_app/controllers/movie_controller.dart';
import 'package:my_movies_app/screens/splash_screen.dart';
import 'package:my_movies_app/services/api.dart';

void main() async {
  await GetStorage.init();
  Api.initializeInterceptors();

  runApp(MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
        // etc.
      };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.create(() => MovieController());

    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.grey[700],
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          // iconTheme: IconThemeData(color: Colors.black),
          // color: Colors.blue,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.amber,
          secondary: Colors.amber,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.dark,
      // translations: Translation(),
      locale: Locale('en'), //Get.deviceLocale
      fallbackLocale: Locale('en'),
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 100),
      home: SplashScreen(),
    );
  }
}
