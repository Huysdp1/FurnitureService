import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';
import '../../models/model_booking.dart';
import '../../routes/app_routes.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({Key? key}) : super(key: key);

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  List<ModelBooking> bookingLists = DataFile.bookingList;
  SharedPreferences? booking;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      booking = sp;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Container(
      color: backGroundColor,
      child: bookingLists.isEmpty ? nullListView(context) : cancelBookingList(),
    );
  }

  ListView cancelBookingList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: bookingLists.length,
      itemBuilder: (context, index) {
        ModelBooking modelBooking = bookingLists[index];
        return modelBooking.tag == "Cancelled"
            ? buildBookingListItem(modelBooking, context, index, () {
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
              })
            : Container();
      },
    );
  }

  Widget nullListView(BuildContext context) {
    return getPaddingWidget(
        EdgeInsets.symmetric(
            horizontal: FetchPixels.getDefaultHorSpace(context)),
        Column(
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
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(14)),
                isBorder: true,
                borderColor: blueColor,
                borderWidth: 1.5)
          ],
        ));
  }
}
