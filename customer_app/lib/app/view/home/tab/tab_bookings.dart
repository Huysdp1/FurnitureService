
import 'package:customer_app/app/data/order_data.dart';
import 'package:customer_app/app/models/model_order.dart';
import 'package:flutter/material.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
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
  Future<List<OrderModel>?> loadAPIData() async {
    return await OrderData().fetchOrdersOfCustomer();
  }

  late TabController tabController;
  var position = 0;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
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
      body: FutureBuilder<List<OrderModel>?>(
          future: loadAPIData(),
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
                      title: "Lịch hẹn",
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
        children:  const [
          AllBookingScreen(),
          ActiveBookingScreen(),
          CompleteBookingScreen(),
          CancelBookingScreen()
        ],
        onPageChanged: (value) {
          tabController.animateTo(value);
          position = value;
          setState(() {});
        },
      ),
    );
  }

  List<String> tabsList = ["Tất cả", "Đang xử lí", "Hoàn tất", "Đã hủy"];

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
      ),
    );
  }
}
