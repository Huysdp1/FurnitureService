
import 'package:customer_app/app/data/account_data.dart';
import 'package:customer_app/app/view/dialog/failure_dialog.dart';
import 'package:customer_app/app/view/dialog/success_dialog.dart';
import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordScreen> {
  TextEditingController oldPassCtl = TextEditingController();
  TextEditingController newPassCtl = TextEditingController();
  TextEditingController confirmNewPassCtl = TextEditingController();
  bool isValidated = false;
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          bottomNavigationBar:
          Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: saveButton(context),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getDefaultHorSpace(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
        primary: true,
        shrinkWrap: true,
        children: [
          getVerSpace(FetchPixels.getPixelHeight(40)),
          getDefaultTextFiledWithLabel(
              context, "Mật khẩu cũ", isValidated, oldPassCtl, Colors.grey,
              function: () {},
              height: FetchPixels.getPixelHeight(60),
              isEnable: false,
              isPass: true,
              withprefix: true,
              image: "lock.svg",
              imageWidth: FetchPixels.getPixelHeight(24),
              imageHeight: FetchPixels.getPixelHeight(24)),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
              context, "Mật khẩu mới", isValidated, newPassCtl, Colors.grey,
              function: () {},
              height: FetchPixels.getPixelHeight(60),
              isEnable: false,
              isPass: true,
              withprefix: true,
              image: "lock.svg",
              imageWidth: FetchPixels.getPixelHeight(24),
              imageHeight: FetchPixels.getPixelHeight(24)),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(
              context, "Nhập lại", isValidated, confirmNewPassCtl, Colors.grey,
              function: () {},
              height: FetchPixels.getPixelHeight(60),
              isEnable: false,
              withprefix: true,
              isPass: true,
              image: "lock.svg",
              imageWidth: FetchPixels.getPixelHeight(24),
              imageHeight: FetchPixels.getPixelHeight(24)),
        ],
      ),
    );
  }

  Widget buildToolbar(BuildContext context) {
    return gettoolbarMenu(context, "back.svg", () {
      Constant.backToPrev(context);
    },
        istext: true,
        title: "Đổi mật khẩu",
        weight: FontWeight.w900,
        fontsize: 24,
        textColor: Colors.black);
  }

  Container saveButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(30)),
      child: getButton(context, blueColor, "Xác nhận", Colors.white, () {
        if(newPassCtl.text == confirmNewPassCtl.text) {
          AccountData().changePassword(oldPassCtl.text, newPassCtl.text).then((value) {
            if(value.statusCode==200){
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
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
                            getSvgImage("group.svg"),
                            getVerSpace(FetchPixels.getPixelHeight(30)),
                            getCustomFont("Thành công", 22, Colors.black, 1,
                                fontWeight: FontWeight.w900),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            getMultilineCustomFont(
                                "Đổi mật khẩu thành công!",
                                16,
                                Colors.black,
                                fontWeight: FontWeight.w400,

                                textAlign: TextAlign.center,
                                txtHeight:1.3),
                            getVerSpace(FetchPixels.getPixelHeight(30)),
                            getButton(context, blueColor, "Ok", Colors.white, () {
                                Constant.backToFinish(context);
                                Constant.backToFinish(context);
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
                  );
                },);
            }else{
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return FailureDialog(title: 'Không thành công', description: value.body);
                },);
            }
          });
          // Constant.backToPrev(context);
          // Constant.backToPrev(context);
        }else{
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return const FailureDialog(title: 'Mật khẩu mới không khớp', description: 'Xác nhận mật khẩu mới chưa đúng!');
            },);
        }
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }

}
