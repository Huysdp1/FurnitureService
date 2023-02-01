
import 'package:customer_app/base/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/color_data.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/account_data.dart';
import '../../routes/app_routes.dart';

class TimeOutDialog extends StatefulWidget {
  const TimeOutDialog({Key? key}) : super(key: key);

  @override
  State<TimeOutDialog> createState() => _TimeOutDialogState();
}

class _TimeOutDialogState extends State<TimeOutDialog> {
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      body: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(20))),
        backgroundColor: backGroundColor,
        content: Builder(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getSvgImage("info.svg"),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getCustomFont("Hết phiên đăng nhập", 22, Colors.black, 1,
                    fontWeight: FontWeight.w900),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getMultilineCustomFont(
                    "Vui lòng đăng nhập lại!",
                    16,
                    Colors.black,
                    fontWeight: FontWeight.w400,

                    textAlign: TextAlign.center,
                    txtHeight:1.3),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getButton(context, blueColor, "Ok", Colors.white, () async {

                    await AccountData().logoutCustomer();
                    if(mounted){
                      Constant.sendToNext(context, Routes.loginRoute);
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
                }, 18,
                    weight: FontWeight.w600,
                    buttonHeight: FetchPixels.getPixelHeight(60),
                    borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15))),
                getVerSpace(FetchPixels.getPixelHeight(20)),
              ],
            );
          },
        ),
      ),
    );
  }
}
