import 'package:customer_app/app/data/data_file.dart';
import 'package:customer_app/app/data/order_data.dart';
import 'package:customer_app/app/models/model_order.dart';
import 'package:customer_app/app/view/bookings/edit_booking.dart';
import 'package:customer_app/app/view/home/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';

class BookingDetail extends StatefulWidget {
  const BookingDetail({Key? key}) : super(key: key);

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  OrderModel? orderModel;
  SharedPreferences? selection;
  @override
  void initState() {
    orderModel = DataFile.orderDetailObj;
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      selection = sp;
      setState(() {});
    });
    super.initState();
  }

  String? cardName;
  String? cardImage;
  String? cardNumber;
  bool isCard = false;
  getCartData() {
    cardImage = selection?.getString("image") ?? "";
    cardName = selection?.getString("cardname") ?? "";
    cardNumber = selection?.getString("cardnumber") ?? "";
    if (cardName!.isNotEmpty) {
      isCard = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    double defHorSpace = FetchPixels.getDefaultHorSpace(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: defHorSpace);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          body: SafeArea(
            child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(20)),
                buildToolbar(context),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                buildBottomExpand(context, edgeInsets, defHorSpace)
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  Expanded buildBottomExpand(
      BuildContext context, EdgeInsets edgeInsets, double defHorSpace) {
    return Expanded(
      flex: 1,
      child: ListView(
        primary: true,
        shrinkWrap: true,
        children: [
          buildTopContainer(context, edgeInsets),
          buildTopWidget(edgeInsets, context),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          buildAboutCleaningWidget(defHorSpace),
          buildBottomWidget(edgeInsets, context)
        ],
      ),
    );
  }

  Container buildAboutCleaningWidget(double defHorSpace) {
    return Container(
      color: const Color(0xFFF2F4F8),
      padding: EdgeInsets.only(
          left: defHorSpace,
          right: defHorSpace,
          top: FetchPixels.getPixelHeight(20),
          bottom: FetchPixels.getPixelHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: FetchPixels.getPixelHeight(52),
                width: FetchPixels.getPixelHeight(52),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(35)),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0.0, 4.0)),
                  ],
                ),
                padding: EdgeInsets.all(FetchPixels.getPixelHeight(14)),
                child: getSvgImage("wallet.svg"),
              ),
              getHorSpace(FetchPixels.getPixelWidth(15)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont("Know about cleaning", 16, Colors.black, 1,
                      fontWeight: FontWeight.w900),
                  getVerSpace(FetchPixels.getPixelHeight(4)),
                  getCustomFont(
                    "Cleaning Service Required",
                    16,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w400,
                  )
                ],
              )
            ],
          ),
          getSvgImage("arrow_right.svg")
        ],
      ),
    );
  }

  Widget buildBottomWidget(EdgeInsets edgeInsets, BuildContext context) {
    return getPaddingWidget(
      edgeInsets,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getVerSpace(FetchPixels.getPixelHeight(30)),
          getCustomFont("Need Help?", 20, Colors.black, 1,
              fontWeight: FontWeight.w900),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          getButtonWithIcon(
              context, Colors.white, "Professional not assigned", Colors.black,
              () {
            // Constant.sendToNext(context, Routes.profileRoute);
          }, 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(56),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(context, Colors.white,
              "I???m unhappy with my booking experience", Colors.black, () {
            // Constant.sendToNext(context, Routes.profileRoute);
          }, 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(56),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(context, Colors.white,
              "Need help with other issues", Colors.black, () {
            // Constant.sendToNext(context, Routes.profileRoute);
          }, 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(56),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),
          getVerSpace(FetchPixels.getPixelHeight(30)),
        ],
      ),
    );
  }

  Widget buildTopWidget(EdgeInsets edgeInsets, BuildContext context) {
    getCartData();
    return getPaddingWidget(
      edgeInsets,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getVerSpace(FetchPixels.getPixelHeight(30)),
          getCustomFont("Ph????ng th???c thanh to??n", 20, Colors.black, 1,
              fontWeight: FontWeight.w900),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          isCard
              ? paymentContainer()
              : getMultilineCustomFont(
                  "Ch??a ch???n h??nh th???c thanh to??n", 16, Colors.black,
                  fontWeight: FontWeight.w400, txtHeight: 1.3),
          getVerSpace(FetchPixels.getPixelHeight(16)),
          getButtonWithIcon(
            context,
            Colors.white,
            "Ch???n h??nh th???c thanh to??n",
            blueColor,
            () async {
              //Constant.sendToNext(context, Routes.paymentRoute);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentScreen(),
                  )).then((value) => getCartData());
            },
            18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
            boxShadow: [
              const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0.0, 4.0)),
            ],
            sufixIcon: true,
            suffixImage: "arrow_right.svg",
          ),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          getCustomFont("About Your Service", 20, Colors.black, 1,
              fontWeight: FontWeight.w900),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          getButtonWithIcon(
              context, Colors.white, "Fixstore Care", Colors.black, () {}, 16,
              weight: FontWeight.w900,
              buttonHeight: FetchPixels.getPixelHeight(72),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: "headset.svg",
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(
              context, Colors.white, "UC Warrenty", Colors.black, () {}, 16,
              weight: FontWeight.w900,
              buttonHeight: FetchPixels.getPixelHeight(72),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: "safe.svg",
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(context, Colors.white, "Standard Rate Card",
              Colors.black, () {}, 16,
              weight: FontWeight.w900,
              buttonHeight: FetchPixels.getPixelHeight(72),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: "starts.svg",
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),
        ],
      ),
    );
  }

  Widget buildTopContainer(BuildContext context, EdgeInsets edgeInsets) {
    return getPaddingWidget(
      edgeInsets,
      Container(
        padding: EdgeInsets.only(
            top: FetchPixels.getPixelHeight(16),
            bottom: FetchPixels.getPixelHeight(16),
            left: FetchPixels.getPixelWidth(16),
            right: FetchPixels.getPixelWidth(16)),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0.0, 4.0)),
            ],
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCustomFont(
                  'Th???i gian h???n:  ${orderModel!.implementationTime}, ${Constant.parseDateNoUTC(orderModel!.implementationDate, false)}',
                  16,
                  textColor,
                  1,
                  fontWeight: FontWeight.w400,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditBookingScreen(),
                        )).then((value) async {
                      await OrderData().fetchOrdersOfCustomer();
                      setState(() {
                        orderModel = DataFile.orderDetailObj;
                      });
                    });
                  },
                  child: getSvgImage("edit.svg",
                      width: FetchPixels.getPixelHeight(24),
                      height: FetchPixels.getPixelHeight(24)),
                )
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: orderModel!.addressM?.addressId != null
                      ? getMultilineCustomFont(
                          "?????a ch???:  ${orderModel!.addressM?.homeNumber},${orderModel!.addressM?.street},${orderModel!.addressM?.ward},${orderModel!.addressM?.district},${orderModel!.addressM?.city}",
                          16,
                          textColor,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400)
                      : getMultilineCustomFont(
                          orderModel!.address ?? "", 16, textColor,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400),
                ),
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCustomFont("Ti???n ?????:", 16, textColor, 1,
                    fontWeight: FontWeight.w400),
                widgetOrderStatus(context, orderModel!.workingStatusId!),
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(
                  "Chi ti???t d???ch v???",
                  16,
                  Colors.black,
                  1,
                  fontWeight: FontWeight.w900,
                ),
                getVerSpace(FetchPixels.getPixelHeight(13)),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: orderModel!.listOrderService?.length,
                  itemBuilder: (context, index) {
                    ListOrderService? serviceModel =
                        orderModel!.listOrderService![index];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: FetchPixels.getPixelHeight(72),
                                  width: FetchPixels.getPixelHeight(72),
                                  decoration: BoxDecoration(
                                    image: getDecorationAssetImage(
                                        context, 'shaving.png'),
                                  ),
                                ),
                                getHorSpace(FetchPixels.getPixelWidth(16)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: getCustomFont(
                                        serviceModel.serviceName ?? "",
                                        16,
                                        Colors.black,
                                        2,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    getVerSpace(FetchPixels.getPixelHeight(4)),
                                    getCustomFont(
                                        "${Constant.showTextMoney(serviceModel.price)}??",
                                        16,
                                        blueColor,
                                        1,
                                        fontWeight: FontWeight.w900)
                                  ],
                                )
                              ],
                            ),
                            getCustomFont(
                              serviceModel.quantity.toString(),
                              14,
                              Colors.black,
                              1,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(20)),
                        index == 2
                            ? Container()
                            : getDivider(
                                dividerColor, FetchPixels.getPixelHeight(1), 1),
                        index == 2
                            ? Container()
                            : getVerSpace(FetchPixels.getPixelHeight(20)),
                      ],
                    );
                  },
                )
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCustomFont("T???ng:", 16, textColor, 1,
                    fontWeight: FontWeight.w400),
                getCustomFont(
                    '${Constant.showTextMoney(orderModel!.totalPrice)}??',
                    16,
                    blueColor,
                    1,
                    fontWeight: FontWeight.w900)
              ],
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            getDivider(dividerColor, 0, 1),
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: FetchPixels.getPixelHeight(42),
                      width: FetchPixels.getPixelHeight(42),
                      decoration: BoxDecoration(
                          image: getDecorationAssetImage(
                              context, "booking_owner.png")),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(9)),
                    orderModel!.addressM?.addressId != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getCustomFont(
                                'Li??n h???: ${orderModel!.addressM!.customerNameOrder}',
                                16,
                                Colors.black,
                                1,
                                fontWeight: FontWeight.w400,
                              ),
                              getVerSpace(FetchPixels.getPixelHeight(6)),
                              getCustomFont(
                                'S??t: ${orderModel!.addressM!.customerPhoneOrder}',
                                16,
                                Colors.black,
                                1,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          )
                        : getCustomFont(
                            "",
                            14,
                            textColor,
                            1,
                            fontWeight: FontWeight.w400,
                          ),
                  ],
                ),
                Container(
                  height: FetchPixels.getPixelHeight(42),
                  width: FetchPixels.getPixelHeight(42),
                  decoration: BoxDecoration(
                      image: getDecorationAssetImage(context, "call_bg.png")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildToolbar(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
      gettoolbarMenu(
        context,
        "back.svg",
        () {
          Constant.backToPrev(context);
        },
        title: "Chi ti???t",
        fontsize: 24,
        weight: FontWeight.w900,
        textColor: Colors.black,
        istext: true,
        // isrightimage: true,
        // rightimage: "edit.svg",
        // rightFunction: () {
        // }
      ),
    );
  }

  Container paymentContainer() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(
          vertical: FetchPixels.getPixelHeight(16),
          horizontal: FetchPixels.getPixelWidth(16)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0.0, 4.0)),
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              getSvgImage(cardImage ?? "",
                  height: FetchPixels.getPixelHeight(46),
                  width: FetchPixels.getPixelHeight(46)),
              getHorSpace(FetchPixels.getPixelWidth(12)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont(
                    cardName ?? "",
                    16,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(3)),
                  SizedBox(
                    width: 250,
                    child: getCustomFont(cardNumber ?? '', 15, Colors.black, 3,
                        fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
