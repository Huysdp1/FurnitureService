
import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../home/home_screen.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog({Key? key}) : super(key: key);

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(20))),
        backgroundColor: backGroundColor,
        content: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getSvgImage("confirm.svg",
                    width: FetchPixels.getPixelHeight(71.37),
                    height: FetchPixels.getPixelHeight(99.92)),
                getVerSpace(FetchPixels.getPixelHeight(40)),
                getCustomFont("Đặt lịch thành công", 22, Colors.black, 1,
                    fontWeight: FontWeight.w900, ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getMultilineCustomFont(
                    "Lịch hẹn của bạn đã được gửi đi!\nNhân viên sẽ liên hệ lại cho bạn ngay!",
                    16,
                    Colors.black,
                    
                    fontWeight: FontWeight.w400,
                    txtHeight:1.3,
                    textAlign: TextAlign.center),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getButton(context, blueColor, "Ok", Colors.white, () {
                  Constant.backToPrev(context);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomeScreen(1)));
                }, 18,
                    weight: FontWeight.w600,
                    buttonHeight: FetchPixels.getPixelHeight(60),
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(14))),
                getVerSpace(FetchPixels.getPixelHeight(10)),
              ],
            );
          },
        ),
      ),
    );
  }
}
