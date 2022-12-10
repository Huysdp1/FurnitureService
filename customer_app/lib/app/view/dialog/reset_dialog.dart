
import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';

class ResetDialog extends StatefulWidget {
  const ResetDialog({Key? key}) : super(key: key);

  @override
  State<ResetDialog> createState() => _ResetDialogState();
}

class _ResetDialogState extends State<ResetDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(20))),
      backgroundColor: backGroundColor,
      content: Builder(
        builder: (context) {
          return buildColumnList(context);
        },
      ),
    );
  }

  Column buildColumnList(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getVerSpace(FetchPixels.getPixelHeight(20)),
            getSvgImage("reset_image.svg"),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            getCustomFont("Reset Password", 22, Colors.black, 1,
                fontWeight: FontWeight.w900, textAlign: TextAlign.center),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            buildDetailWidget(),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            buildButton(context),
            getVerSpace(FetchPixels.getPixelHeight(20)),
          ],
        );
  }

  Widget buildDetailWidget() {
    return getMultilineCustomFont(
                "Your password has been successfully changed!",
                16,
                Colors.black,

                fontWeight: FontWeight.w400,
                txtHeight: 1.3,
                textAlign: TextAlign.center);
  }

  Widget buildButton(BuildContext context) {
    return getButton(context, blueColor, "Ok", Colors.white, () {
              Constant.sendToNext(context, Routes.loginRoute);
            }, 18,
                weight: FontWeight.w600,
                buttonHeight: FetchPixels.getPixelHeight(60),
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)));
  }
}
