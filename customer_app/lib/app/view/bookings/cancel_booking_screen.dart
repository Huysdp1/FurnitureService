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
  List<AddressModel> addressList = [];
  Future<List<AddressModel>?> getPrefAddressData() async {
    String getModel = await PrefData.getAddressModel();
    if (getModel.isNotEmpty) {
      addressList = AddressModel.fromList(
          json.decode(getModel).cast<Map<String, dynamic>>());
      if (mounted) {
        setState(() {});
      }
    }
    return addressList;
  }

  @override
  void initState() {
    getPrefAddressData();
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
      child: orderList.isEmpty ? nullListView(context) : bookingListWidget(orderList, addressList),
    );
  }
}
