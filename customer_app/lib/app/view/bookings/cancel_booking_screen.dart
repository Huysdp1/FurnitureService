import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../models/model_address.dart';
import '../../models/model_order.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({Key? key}) : super(key: key);

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  List<OrderModel> orderList = [];

  @override
  void initState() {
    PrefData.getOrderModel().then((value) {
      if (value.isNotEmpty) {
        orderList = OrderModel.fromList(
            json.decode(value).cast<Map<String, dynamic>>()).where((element) => element.workingStatusId! == 1002).toList();
        if (mounted) {
          setState(() {});
        }
      }});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Container(
      color: backGroundColor,
      child: orderList.isEmpty ? nullListView(context) : bookingListWidget(orderList),
    );
  }
}
