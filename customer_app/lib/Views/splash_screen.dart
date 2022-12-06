import 'dart:async';

import 'package:flutter/material.dart';
import '../Constants/color_data.dart';
import '../Constants/constant.dart';
import '../Constants/pref_data.dart';
import '../Constants/resizer/fetch_pixels.dart';
import '../Constants/widget_utils.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    PrefData.isLogIn().then((value) {
      Timer(
        const Duration(seconds: 3),
        () {
          (value)
              ? Constant.sendToNext(context, Routes.homeScreenRoute)
              : Constant.sendToNext(context, Routes.introRoute);
        },
      );
    });
  }

  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: buildLogo(),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }

  Container buildLogo() {
    return Container(
          color: blueColor,
          child: Center(
              child: getSvgImageWithSize(
                  context,
                  "splash_logo.svg",
                  FetchPixels.getPixelHeight(180),
                  FetchPixels.getPixelHeight(180)))
        );
  }
}
