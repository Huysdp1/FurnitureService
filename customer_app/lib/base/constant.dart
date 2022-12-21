import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constant {
  static String assetImagePath = "assets/images/";
  static bool isDriverApp = false;
  static const String fontsFamily = "Lato";
  static const String fromLogin = "getFromLoginClick";
  static const String homePos = "getTabPos";
  static const int stepStatusNone = 0;
  static const int stepStatusActive = 1;
  static const int stepStatusDone = 2;
  static const int stepStatusWrong = 3;

  static double getPercentSize(double total, double percent) {
    return (percent * total) / 100;
  }

  static backToPrev(BuildContext context) {
    Navigator.of(context).pop();
  }

  static getCurrency(BuildContext context) {
    return "ETH";
  }

  static sendToNext(BuildContext context, String route, {Object? arguments}) {
    if (arguments != null) {
      Navigator.pushNamed(context, route, arguments: arguments);
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  static backToPrevWithRes(BuildContext context, {Object? arguments}) {
    if (arguments != null) {
      Navigator.of(context).pop(arguments);
    } else {
      Navigator.of(context).pop();
    }
  }

  static sendToNextWithRes(BuildContext context, String route,
      {Object? arguments, Function? fun}) {
    if (arguments != null) {
      Navigator.pushNamed(context, route, arguments: arguments).then((value) {
        if (fun != null) {
          fun();
        }
      });
    } else {
      Navigator.pushNamed(context, route).then((value) {
        if (fun != null) {
          fun();
        }
      });
    }
  }

  static double getToolbarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + kToolbarHeight;
  }

  static double getToolbarTopHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static sendToScreen(Widget widget, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  static backToFinish(BuildContext context) {
    Navigator.of(context).pop();
  }

  static closeApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  static String? validateCharacters(String txt, String? title) {
    if (title == 'Số điện thoại' &&
        !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(txt)) {
      return 'Số điện thoại không đúng định dạng';
    }
    if (title == 'Mật khẩu' && txt.length < 8) {
      return "Mật khẩu phải từ 8 ký tự";
    }
    if (txt.isEmpty) {
      return "Trống!";
    }
    return null;
  }

  static String? showTextMoney(dynamic txt) {
    String converted = txt.toString().replaceAllMapped(
        RegExp(r"(?<=\d)(?=(\d\d\d)+(?!\d))"), (match) => "${match.group(0)}.");

    return converted;
  }

  static String? parseDateNoUTC(date, bool isTime) {
    if (date == null) {
      return '--:--\n--/--/----';
    }
    DateTime dt1 = DateTime.parse(date);
    if (isTime) {
      String hour = dt1.hour.toString();
      String minute = dt1.minute.toString();
      if (dt1.hour < 10) {
        hour = '0$hour';
      }
      if (dt1.minute < 10) {
        minute = '0$minute';
      }
      return '$hour:$minute, ${dt1.day}/${dt1.month}/${dt1.year}';
    } else {
      return '${dt1.day}/${dt1.month}/${dt1.year}';
    }
  }
}
