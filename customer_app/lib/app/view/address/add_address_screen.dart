import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          bottomNavigationBar: addAddressButton(context),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getDefaultHorSpace(context)),
              child: Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  buildToolbar(context),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  buildExpand(context)
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  Expanded buildExpand(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        primary: true,
        children: [
          getDefaultTextFiledWithLabel(
              context, "Tên", nameController, Colors.grey,
              function: () {},
              height: FetchPixels.getPixelHeight(60),
              withprefix: true,
              image: "profile.svg",
              isEnable: false,
              minLines: true),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
              context, "Địa chỉ", addressController, Colors.grey,
              function: () {},
              isEnable: false,
              withprefix: false,
              minLines: true,
              height: FetchPixels.getPixelHeight(120),
              alignmentGeometry: Alignment.topLeft),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
            context,
            "Tòa nhà",
            landmarkController,
            Colors.grey,
            function: () {},
            isEnable: false,
            withprefix: false,
            minLines: true,
            height: FetchPixels.getPixelHeight(60),
            withSufix: true,
            suffiximage: "down_arrow.svg",
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
              context, "Thành Phố", cityController, Colors.grey,
              function: () {},
              isEnable: false,
              withprefix: false,
              minLines: true,
              height: FetchPixels.getPixelHeight(60),
              withSufix: true,
              suffiximage: "down_arrow.svg"),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
              context, "Số điện thoại", phoneController, Colors.grey,
              function: () {},
              height: FetchPixels.getPixelHeight(60),
              withprefix: true,
              image: "call.svg",
              isEnable: false,
              minLines: true),
        ],
      ),
    );
  }

  Widget buildToolbar(BuildContext context) {
    return gettoolbarMenu(context, "back.svg", () {
      Constant.backToPrev(context);
    },
        istext: true,
        title: "Thêm địa chỉ mới",
        weight: FontWeight.w900,
        fontsize: 24,
        textColor: Colors.black);
  }

  Container addAddressButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(30)),
      child: getButton(context, blueColor, "Thêm địa chỉ mới", Colors.white,
          () {
        Constant.backToPrev(context);
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }
}
