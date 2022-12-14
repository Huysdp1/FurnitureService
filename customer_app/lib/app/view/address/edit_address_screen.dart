import 'package:customer_app/app/data/account_data.dart';
import 'package:customer_app/app/models/model_address.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({Key? key}) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeNumController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isValidated = false;
  SharedPreferences? selection;
  @override
    void initState()  {
     SharedPreferences.getInstance().then((SharedPreferences sp) {
      selection = sp;
      setState(() {});
    }).then((value) {
     nameController.text = selection!.getString("customerNameOrder") ?? "";
         homeNumController.text = selection!.getString("homeNumber") ?? "";
     streetController.text = selection!.getString("street") ?? "";
     wardController.text = selection!.getString("ward") ?? "";
     districtController.text = selection!.getString("district") ?? "";
     cityController.text = selection!.getString("city") ?? "";
     phoneController.text = selection!.getString("phoneAddress") ?? "";
     });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    selection?.remove("customerNameOrder");
    selection?.remove("homeNumber");
    selection?.remove("street");
    selection?.remove("ward");
    selection?.remove("district");
    selection?.remove("city");
    selection?.remove("customerId");
    selection?.remove("phoneAddress");

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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        shrinkWrap: true,
        primary: true,
        children: [
          getDefaultTextFiledWithLabel(
              context, "Tên", true, nameController, Colors.grey,
              function: () {},
              height: FetchPixels.getPixelHeight(60),
              withprefix: true,
              image: "profile.svg",
              isEnable: false,
              minLines: true),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
              context, "Số nhà", true, homeNumController, Colors.grey,
              function: () {},
              isEnable: false,
              withprefix: false,
              minLines: true,
              image: "home.svg",
              height: FetchPixels.getPixelHeight(60),
              alignmentGeometry: Alignment.topLeft),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
              context, "Đường", true, streetController, Colors.grey,
              function: () {},
              isEnable: false,
              withprefix: false,
              minLines: true,
              image: "home_address.svg",
              height: FetchPixels.getPixelHeight(60),
              alignmentGeometry: Alignment.topLeft),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
            context,
            "Phường",
            true,
            wardController,
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
              context, "Quận", true, districtController, Colors.grey,
              function: () {},
              isEnable: false,
              withprefix: false,
              minLines: true,
              height: FetchPixels.getPixelHeight(60),
              withSufix: true,
              suffiximage: "down_arrow.svg"),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
              context, "Thành Phố", true, cityController, Colors.grey,
              function: () {},
              isEnable: false,
              withprefix: false,
              minLines: true,
              height: FetchPixels.getPixelHeight(60),
              withSufix: true,
              suffiximage: "down_arrow.svg"),

          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
              context, "Số điện thoại", true, phoneController, Colors.grey,
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
        title: "Sửa địa chỉ",
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
      child: getButton(context, blueColor, "Lưu", Colors.white,
          () async {
        AddressModel addressModel = AddressModel(
            customerNameOrder: nameController.text,
            customerPhoneOrder: phoneController.text,
            homeNumber: homeNumController.text,
            street: streetController.text,
            ward: wardController.text,
            district: districtController.text,
            city: cityController.text,
        );
        await AccountData().updateAddress(addressModel, selection!.getInt('addressId'));
        setState(() {
        });
        if(mounted){Constant.backToFinish(context);}
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }
}
