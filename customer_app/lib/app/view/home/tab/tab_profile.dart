

import 'package:customer_app/app/data/account_data.dart';
import 'package:customer_app/app/models/model_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/pref_data.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../routes/app_routes.dart';

class TabProfile extends StatefulWidget {
  const TabProfile({Key? key}) : super(key: key);

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backGroundColor,
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        child: FutureBuilder<AccountModel>(
          future: AccountData().fetchCustomerInfo(),
          builder: (context,snapshot) {
            if(snapshot.hasData) {
              return buildProfileWidget(context,snapshot.data);
            } else if(snapshot.hasError){
              return buildProfileWidget(context);
            }
              return const Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }

  ListView buildProfileWidget(BuildContext context, [AccountModel? data]) {
    return ListView(
      children: [
        getVerSpace(FetchPixels.getPixelHeight(20)),
        buildToolbarWidget(context),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        Center(child: profilePictureView(context, data)),
        getVerSpace(FetchPixels.getPixelHeight(16)),
        Center(child: getCustomFont(data?.customerName ?? "", 18, textColor, 1,
            fontWeight: FontWeight.w700),),
        getVerSpace(FetchPixels.getPixelHeight(36)),
        myProfileButton(context,data),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        myCardButton(context),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        myAddressButton(context),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        settingButton(context),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        logoutButton(context, data)
      ],
    );
  }

  Widget buildToolbarWidget(BuildContext context) {
    return withoutleftIconToolbar(context,
        isrightimage: true,
        title: "Thông tin cá nhân",
        weight: FontWeight.w900,
        textColor: Colors.black,
        fontsize: 24,
        istext: true,
        rightimage: "notification.svg", rightFunction: () {
      Constant.sendToNext(context, Routes.notificationRoutes);
    });
  }

  Widget logoutButton(BuildContext context, [AccountModel? data]) {
    return getButton(context, blueColor, "Đăng xuất", Colors.white, () async {
      if(data != null){
        await AccountData().logoutCustomer(data.accountId!);
        if(mounted){
          Constant.sendToNext(context, Routes.loginRoute);
        }
      }else{
        PrefData.setLogIn(false);
        PrefData.setCusId(-1);
        const FlutterSecureStorage().deleteAll();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        if(mounted){
          Constant.sendToNext(context, Routes.loginRoute);
        }
      }
      // Constant.closeApp();
    }, 18,
        weight: FontWeight.w600,
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
        buttonHeight: FetchPixels.getPixelHeight(60));
  }

  Widget settingButton(BuildContext context,) {
    return getButtonWithIcon(context, Colors.white, "Đổi mật khẩu", Colors.black,
        () {
      Constant.sendToNext(context, Routes.changePasswordScreen);
    }, 16,
        weight: FontWeight.w400,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
        boxShadow: [
          const BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
        ],
        prefixIcon: true,
        prefixImage: "setting.svg",
        sufixIcon: true,
        suffixImage: "arrow_right.svg");
  }

  Widget myAddressButton(BuildContext context) {
    return getButtonWithIcon(context, Colors.white, "Địa chỉ", Colors.black,
        () {
      Constant.sendToNext(context, Routes.myAddressRoute);
    }, 16,
        weight: FontWeight.w400,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
        boxShadow: [
          const BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
        ],
        prefixIcon: true,
        prefixImage: "location.svg",
        sufixIcon: true,
        suffixImage: "arrow_right.svg");
  }

  Widget myCardButton(BuildContext context) {
    return getButtonWithIcon(context, Colors.white, "Ví của tôi", Colors.black,
        () {
      Constant.sendToNext(context, Routes.cardRoute);
    }, 16,
        weight: FontWeight.w400,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
        boxShadow: [
          const BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
        ],
        prefixIcon: true,
        prefixImage: "wallet.svg",
        sufixIcon: true,
        suffixImage: "arrow_right.svg");
  }

  Widget myProfileButton(BuildContext context, [AccountModel? data]) {
    return getButtonWithIcon(context, Colors.white, "Hồ sơ", Colors.black,
        () {
      Constant.sendToNext(context, Routes.profileRoute);
    }, 16,
        weight: FontWeight.w400,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
        boxShadow: [
          const BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
        ],
        prefixIcon: true,
        prefixImage: "profile.svg",
        sufixIcon: true,
        suffixImage: "arrow_right.svg");
  }

  Stack profilePictureView(BuildContext context,[AccountModel? data]) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: FetchPixels.getPixelHeight(100),
          width: FetchPixels.getPixelHeight(100),
          decoration: BoxDecoration(
            image: getDecorationAssetImage(context, "profile_image.png"),
          ),
        ),
        Positioned(
            top: FetchPixels.getPixelHeight(68),
            left: FetchPixels.getPixelHeight(70),
            child: Container(
              height: FetchPixels.getPixelHeight(46),
              width: FetchPixels.getPixelHeight(46),
              padding: EdgeInsets.symmetric(
                  vertical: FetchPixels.getPixelHeight(10),
                  horizontal: FetchPixels.getPixelHeight(10)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0.0, 4.0)),
                  ],
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(35))),
              child: getSvgImage("camera.svg",
                  height: FetchPixels.getPixelHeight(24),
                  width: FetchPixels.getPixelHeight(24)),
            )),
      ],
    );
  }
}
