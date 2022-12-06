
import 'package:flutter/material.dart';

import '../../Constants/color_data.dart';
import '../../Constants/constant.dart';
import '../../Constants/resizer/fetch_pixels.dart';
import '../../Constants/widget_utils.dart';
import '../../Routes/app_routes.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  void finish() {
    Constant.backToPrev(context);
  }

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getDefaultHorSpace(context)),
              child: buildList(context),
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }

  ListView buildList(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: true,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(26)),
        gettoolbarMenu(
          context,
          "back.svg",
          () {
            finish();
          },
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getCustomFont("Forgot Password?", 24, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        buildDetailView(),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        buildMailTextFiled(context),
        getVerSpace(FetchPixels.getPixelHeight(50)),
        buildButton(context),
      ],
    );
  }

  Widget buildMailTextFiled(BuildContext context) {
    return getDefaultTextFiledWithLabel(
        context, "Email", emailController, Colors.grey,
        function: () {},
        height: FetchPixels.getPixelHeight(60),
        isEnable: false,
        withprefix: true,
        image: "message.svg",
        imageWidth: FetchPixels.getPixelWidth(19),
        imageHeight: FetchPixels.getPixelHeight(17.66));
  }

  Widget buildButton(BuildContext context) {
    return getButton(context, blueColor, "Submit", Colors.white, () {
      Constant.sendToNext(context, Routes.resetRoute);
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)));
  }

  Widget buildDetailView() {
    return getPaddingWidget(
        EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(60)),
        getMultilineCustomFont(
            "We need your registration email for reset password!",
            16,
            Colors.black,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
            txtHeight: 1.3));
  }
}
