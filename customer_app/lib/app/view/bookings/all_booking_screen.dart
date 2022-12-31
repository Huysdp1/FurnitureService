import 'dart:convert';
import 'package:customer_app/app/models/model_address.dart';
import 'package:customer_app/app/models/model_order.dart';
import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';

class AllBookingScreen extends StatefulWidget {
  const AllBookingScreen({Key? key}) : super(key: key);

  @override
  State<AllBookingScreen> createState() => _AllBookingScreenState();
}

class _AllBookingScreenState extends State<AllBookingScreen> {
  List<OrderModel> orderList = [];
  List<AddressModel> addressList = [];
  Future<List<AddressModel>> getPrefAddressData() async {
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

  Future<List<OrderModel>> getPrefData() async {
    String getModel = await PrefData.getOrderModel();
    if (getModel.isNotEmpty) {
      orderList = OrderModel.fromList(
          json.decode(getModel).cast<Map<String, dynamic>>());
      if (mounted) {
        setState(() {});
      }
    }
    return orderList;
  }

  @override
  void initState() {
    getPrefAddressData();
    PrefData.getOrderModel().then((value) {
      if (value.isNotEmpty) {
        orderList = OrderModel.fromList(
            json.decode(value).cast<Map<String, dynamic>>());
        if (mounted) {
          setState(() {});
        }
      }});

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    EdgeInsets edgeInsets = EdgeInsets.symmetric(
      horizontal: FetchPixels.getDefaultHorSpace(context),
    );
      return FutureBuilder<List<OrderModel>>(
        future: getPrefData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            color: backGroundColor,
            child: orderList.isEmpty
                ? getPaddingWidget(edgeInsets, nullListView(context))
                : bookingListWidget(orderList, addressList),
          );
        }
        );
  }

}
