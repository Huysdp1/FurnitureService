import 'dart:convert';
import 'package:customer_app/app/models/model_order.dart';
import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';
import '../../models/model_booking.dart';
import '../../routes/app_routes.dart';

class AllBookingScreen extends StatefulWidget {
  const AllBookingScreen({Key? key}) : super(key: key);

  @override
  State<AllBookingScreen> createState() => _AllBookingScreenState();
}

class _AllBookingScreenState extends State<AllBookingScreen> {
  List<OrderModel> orderList = [];

  @override
  Widget build(BuildContext context) {
    EdgeInsets edgeInsets = EdgeInsets.symmetric(
      horizontal: FetchPixels.getDefaultHorSpace(context),
    );
    return FutureBuilder(
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
                : allBookingList(),
          );
        });
  }

  getPrefData() async {
    String getModel = await PrefData.getOrderModel();
    if (getModel.isNotEmpty) {
      orderList = OrderModel.fromList(
          json.decode(getModel).cast<Map<String, dynamic>>());
      print(orderList.first.toJson());
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getPrefData();
  }

  ListView allBookingList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: orderList.length,
      itemBuilder: (context, index) {
        OrderModel orderModel = orderList[index];
        return buildOrderListItem(orderModel, context, index, () {
          // ModelBooking booking = ModelBooking(
          //     "",
          //     modelBooking.name ?? "",
          //     modelBooking.date ?? "",
          //     modelBooking.rating ?? "",
          //     modelBooking.price ?? 0.0,
          //     modelBooking.owner ?? "",
          //     modelBooking.tag,
          //     0,
          //     null);
          // PrefData.setBookingModel(jsonEncode(booking));
          Constant.sendToNext(context, Routes.bookingRoute);
        }, () {
          setState(() {
            orderList.removeAt(index);
          });
        });
      },
    );
  }

  Column nullListView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSvgImage("clipboard.svg",
            height: FetchPixels.getPixelHeight(124),
            width: FetchPixels.getPixelHeight(124)),
        getVerSpace(FetchPixels.getPixelHeight(40)),
        getCustomFont("No Bookings Yet!", 20, Colors.black, 1,
            fontWeight: FontWeight.w900),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont(
          "Go to services and book the best services. ",
          16,
          Colors.black,
          1,
          fontWeight: FontWeight.w400,
        ),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getButton(
            context, backGroundColor, "Go to Service", blueColor, () {}, 18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            insetsGeometry: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(106)),
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
            isBorder: true,
            borderColor: blueColor,
            borderWidth: 1.5)
      ],
    );
  }
}
