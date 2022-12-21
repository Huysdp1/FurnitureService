import 'dart:convert';

import 'package:customer_app/app/data/data_file.dart';
import 'package:customer_app/app/data/order_data.dart';
import 'package:customer_app/app/models/model_order.dart';
import 'package:flutter/material.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/pref_data.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../routes/app_routes.dart';
import '../../bookings/active_booking_screen.dart';
import '../../bookings/all_booking_screen.dart';
import '../../bookings/cancel_booking_screen.dart';
import '../../bookings/complete_booking_screen.dart';

class TabBookings extends StatefulWidget {
  const TabBookings({Key? key}) : super(key: key);

  @override
  State<TabBookings> createState() => _TabBookingsState();
}

class _TabBookingsState extends State<TabBookings>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  static List<OrderModel> orderList = [];
  Future loadAPIData() async {
    await OrderData().fetchOrdersOfCustomer(2);
  }

  Future<List<OrderModel>> getPrefData() async {
    loadAPIData().then((value) async {
      String getModel = await PrefData.getOrderModel();
      if (getModel.isNotEmpty) {
        orderList = OrderModel.fromList(
            json.decode(getModel).cast<Map<String, dynamic>>());
        if (mounted) {
          setState(() {});
        }
      }
    });
    return orderList;
  }

  late TabController tabController;
  var position = 0;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backGroundColor,
      body: FutureBuilder(
          future: getPrefData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getPaddingWidget(
                  EdgeInsets.symmetric(
                      horizontal: FetchPixels.getDefaultHorSpace(context)),
                  withoutleftIconToolbar(context,
                      isrightimage: true,
                      title: "Bookings",
                      weight: FontWeight.w900,
                      textColor: Colors.black,
                      fontsize: 24,
                      istext: true,
                      rightimage: "notification.svg", rightFunction: () {
                    Constant.sendToNext(context, Routes.notificationRoutes);
                  }),
                ),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                tabBar(),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                pageViewer()
              ],
            );
          }),
    );
  }

  Expanded pageViewer() {
    return Expanded(
      child: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: const [
          AllBookingScreen(),
          //ActiveBookingScreen(),
          //CompleteBookingScreen(),
          //CancelBookingScreen()
        ],
        onPageChanged: (value) {
          tabController.animateTo(value);
          position = value;
          setState(() {});
        },
      ),
    );
  }

  List<String> tabsList = ["All", "Active", "Completed", "Cancelled"];

  Widget tabBar() {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
      TabBar(
        indicatorColor: Colors.transparent,
        physics: const BouncingScrollPhysics(),
        controller: tabController,
        labelPadding: EdgeInsets.zero,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
          position = index;
          setState(() {});
        },
        tabs: List.generate(tabsList.length, (index) {
          return Tab(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    getCustomFont(tabsList[index], 16,
                        position == index ? blueColor : Colors.black, 1,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.visible),
                    getVerSpace(FetchPixels.getPixelHeight(7)),
                    Container(
                      height: FetchPixels.getPixelHeight(2),
                      color: position == index
                          ? blueColor
                          : const Color(0xFFE5E8F1),
                    )
                  ],
                )),
          );
        }),
        // Tab(
        //   child: Container(
        //       alignment: Alignment.center,
        //       child: Column(
        //         children: [
        //           getCustomFont(
        //               "All", 16, position == 0 ? blueColor : Colors.black, 1,
        //               fontWeight: FontWeight.w400,
        //               overflow: TextOverflow.visible),
        //           getVerSpace(FetchPixels.getPixelHeight(7)),
        //           Container(
        //             height: FetchPixels.getPixelHeight(2),
        //             color:
        //                 position == 0 ? blueColor : const Color(0xFFE5E8F1),
        //           )
        //         ],
        //       )),
        // ),
        // Tab(
        //   child: Container(
        //       alignment: Alignment.center,
        //       child: Column(
        //         children: [
        //           getCustomFont("Active", 16,
        //               position == 1 ? blueColor : Colors.black, 1,
        //
        //               fontWeight: FontWeight.w400,
        //               overflow: TextOverflow.visible),
        //           getVerSpace(FetchPixels.getPixelHeight(7)),
        //           Container(
        //             height: FetchPixels.getPixelHeight(2),
        //             color:
        //                 position == 1 ? blueColor : const Color(0xFFE5E8F1),
        //           )
        //         ],
        //       )),
        // ),
        // Tab(
        //   child: Container(
        //       alignment: Alignment.center,
        //       child: Column(
        //         children: [
        //           getCustomFont("Completed", 16,
        //               position == 2 ? blueColor : Colors.black, 1,
        //
        //               fontWeight: FontWeight.w400,
        //               overflow: TextOverflow.visible),
        //           getVerSpace(FetchPixels.getPixelHeight(7)),
        //           Container(
        //             height: FetchPixels.getPixelHeight(2),
        //             color:
        //                 position == 2 ? blueColor : const Color(0xFFE5E8F1),
        //           )
        //         ],
        //       )),
        // ),
        // Tab(
        //   child: Container(
        //       alignment: Alignment.center,
        //       child: Column(
        //         children: [
        //           getCustomFont("Cancelled", 16,
        //               position == 3 ? blueColor : Colors.black, 1,
        //
        //               fontWeight: FontWeight.w400,
        //               overflow: TextOverflow.visible),
        //           getVerSpace(FetchPixels.getPixelHeight(7)),
        //           Container(
        //             height: FetchPixels.getPixelHeight(2),
        //             color:
        //                 position == 3 ? blueColor : const Color(0xFFE5E8F1),
        //           )
        //         ],
        //       )),
        // )
      ),
    );
  }
}
