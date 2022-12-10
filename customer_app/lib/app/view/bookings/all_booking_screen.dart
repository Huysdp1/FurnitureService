import 'dart:convert';
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
  List<ModelBooking> bookingLists = DataFile.bookingList;

  @override
  Widget build(BuildContext context) {
    EdgeInsets edgeInsets = EdgeInsets.symmetric(
      horizontal: FetchPixels.getDefaultHorSpace(context),
    );
    return Container(
      color: backGroundColor,
      child: bookingLists.isEmpty
          ? getPaddingWidget(edgeInsets, nullListView(context))
          : allBookingList(),
    );
  }


  @override
  void initState() {
    super.initState();

  }

  ListView allBookingList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: bookingLists.length,
      itemBuilder: (context, index) {
        ModelBooking modelBooking = bookingLists[index];
        return buildBookingListItem(modelBooking, context, index, () {
          ModelBooking booking = ModelBooking(
              "",
              modelBooking.name ?? "",
              modelBooking.date ?? "",
              modelBooking.rating ?? "",
              modelBooking.price ?? 0.0,
              modelBooking.owner ?? "",
              modelBooking.tag,
              0,
              null);
          PrefData.setBookingModel(jsonEncode(booking));
          Constant.sendToNext(context, Routes.bookingRoute);
        }, () {
          setState(() {
            bookingLists.removeAt(index);
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
