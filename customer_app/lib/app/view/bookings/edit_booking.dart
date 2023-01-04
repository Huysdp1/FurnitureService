import 'dart:async';
import 'dart:convert';
import 'package:customer_app/app/data/data_file.dart';
import 'package:customer_app/app/data/order_data.dart';
import 'package:customer_app/app/models/model_cart.dart';
import 'package:customer_app/app/models/model_order.dart';
import 'package:customer_app/app/view/dialog/category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/account_data.dart';
import '../../data/service_data.dart';
import '../../models/model_address.dart';
import '../../models/model_category.dart';
import '../../models/model_service.dart';
import '../../routes/app_routes.dart';

class EditBookingScreen extends StatefulWidget {
  const EditBookingScreen({Key? key}) : super(key: key);

  @override
  State<EditBookingScreen> createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  List<CategoryModel> categoryLists = [];
  List<ServiceModel> serviceList = [];
  List<String> timeLists = DataFile.timeList;
  OrderModel? orderModel;
  bool showMoreAddress = false;
  SharedPreferences? selection;
  var cateId = -1;
  int total = 0;
  getPrefCateSerData() async {
    String getModel = await PrefData.getCategoryModel();
    if (getModel.isNotEmpty) {
      categoryLists = CategoryModel.fromList(
          json.decode(getModel).cast<Map<String, dynamic>>());
      setState(() {});
    }
    if (cateId == -1) {
      cateId = categoryLists.first.categoryId!;
    }
    serviceList = await ServiceData().fetchServicesAndCategories(cateId);
    if (serviceList.isNotEmpty) {
      setState(() {});
    }
  }

  List<AddressModel> addressLists = [];
  getPrefAddressData() async {
    String getModel = await PrefData.getAddressModel();
    if (getModel.isNotEmpty) {
      addressLists = AddressModel.fromList(
          json.decode(getModel).cast<Map<String, dynamic>>());
      setState(() {});
    }
  }

  FutureOr onGoBack() async {
    await AccountData().fetchCustomerAddress();
    setState(() {
      getPrefAddressData();
    });
  }

  @override
  void initState() {
    orderModel = DataFile.orderDetailObj;
    getPrefAddressData();
    getPrefCateSerData();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      selection = sp;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(20)),
              child: Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  buildToolbar(context),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          getCustomFont("Địa chỉ", 16, Colors.black, 1,
                              fontWeight: FontWeight.w900),
                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          addressList(),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          getCustomFont("Chọn ngày", 16, Colors.black, 1,
                              fontWeight: FontWeight.w900),
                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          calendarContainer(),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          getCustomFont("Chọn giờ", 16, Colors.black, 1,
                              fontWeight: FontWeight.w900),
                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          timeList(),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getCustomFont("Dịch vụ", 16, Colors.black, 1,
                                  fontWeight: FontWeight.w900),
                              showMoreServiceButton(context),
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          Container(
                            child: buildListView(
                                FetchPixels.getDefaultHorSpace(context)),
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(30)),
                          finalButton(context),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  ListView buildListView(double defSpace) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      primary: false,
      itemCount: orderModel!.listOrderService?.length,
      itemBuilder: (context, index) {
        ListOrderService serviceModel = orderModel!.listOrderService![index];
        return Container(
          margin: EdgeInsets.only(
              bottom: FetchPixels.getPixelHeight(20),
              left: defSpace,
              right: defSpace),
          width: FetchPixels.getPixelWidth(324),
          padding: EdgeInsets.only(
              left: FetchPixels.getPixelWidth(16),
              right: FetchPixels.getPixelWidth(16),
              top: FetchPixels.getPixelHeight(4),
              bottom: FetchPixels.getPixelHeight(4)),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              packageImage(context, serviceModel),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: FetchPixels.getPixelWidth(10),
                      right: FetchPixels.getPixelWidth(2)),
                  child: packageDescription(serviceModel),
                ),
              ),
              addButton(serviceModel, context)
            ],
          ),
        );
      },
    );
  }

  Column packageDescription(ListOrderService serviceModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getVerSpace(FetchPixels.getPixelWidth(8)),
        getCustomFont(
          serviceModel.serviceName ?? '',
          16,
          Colors.black,
          3,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }

  Column addButton(ListOrderService serviceModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        getVerSpace(FetchPixels.getPixelWidth(8)),
        if (orderModel!.listOrderService?.any(
                (element) => element.serviceId == serviceModel.serviceId) ==
            false)
          getButton(context, Colors.transparent, "Thêm", blueColor, () {
            orderModel!.totalPrice = (int.parse(orderModel!.totalPrice!) +
                    (int.parse(serviceModel.price!) * 1))
                .toString();
            orderModel!.listOrderService?.add(ListOrderService(
                serviceId: serviceModel.serviceId, quantity: 1));
            setState(() {});
          }, 14,
              weight: FontWeight.w600,
              insetsGeometrypadding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(20),
                  vertical: FetchPixels.getPixelHeight(12)),
              borderColor: blueColor,
              borderWidth: 1.5,
              isBorder: true,
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(10)))
        else
          Row(
            children: [
              GestureDetector(
                child: getSvgImage("add1.svg",
                    width: FetchPixels.getPixelHeight(30),
                    height: FetchPixels.getPixelHeight(30)),
                onTap: () {
                  orderModel!.listOrderService
                      ?.firstWhere((element) =>
                          element.serviceId == serviceModel.serviceId)
                      .quantity = (orderModel!.listOrderService!
                          .firstWhere((element) =>
                              element.serviceId == serviceModel.serviceId)
                          .quantity! +
                      1);
                  orderModel!.totalPrice = (int.parse(orderModel!.totalPrice!) +
                          (int.parse(serviceModel.price!) * 1))
                      .toString();
                  setState(() {});
                },
              ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              getCustomFont(
                orderModel!.listOrderService
                        ?.firstWhere((element) =>
                            element.serviceId == serviceModel.serviceId)
                        .quantity
                        .toString() ??
                    "",
                14,
                Colors.black,
                1,
                fontWeight: FontWeight.w400,
              ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              GestureDetector(
                child: getSvgImage("minus.svg",
                    width: FetchPixels.getPixelHeight(30),
                    height: FetchPixels.getPixelHeight(30)),
                onTap: () {
                  if (orderModel!.listOrderService!
                          .firstWhere((element) =>
                              element.serviceId == serviceModel.serviceId)
                          .quantity! >
                      1) {
                    orderModel!.listOrderService
                        ?.firstWhere((element) =>
                            element.serviceId == serviceModel.serviceId)
                        .quantity = (orderModel!.listOrderService!
                            .firstWhere((element) =>
                                element.serviceId == serviceModel.serviceId)
                            .quantity! -
                        1);
                  } else {
                    orderModel!.listOrderService?.removeWhere((element) =>
                        element.serviceId == serviceModel.serviceId);
                    OrderData().deleteOrderCustomer(orderModel!.orderId, serviceModel.orderServiceId);
                    DataFile.orderDetailObj.listOrderService?.removeWhere((element) =>
                  element.serviceId == serviceModel.serviceId);
                    DataFile.orderDetailObj.totalPrice = totalPriceCalculator(DataFile.orderDetailObj).toString();
                  }
                  orderModel!.totalPrice = (int.parse(orderModel!.totalPrice!) -
                          (int.parse(serviceModel.price!) * 1))
                      .toString();
                  setState(() {});
                },
              ),
            ],
          ),
        getVerSpace(FetchPixels.getPixelHeight(40)),
        getCustomFont(
            "${Constant.showTextMoney(serviceModel.price)}đ", 16, blueColor, 1,
            fontWeight: FontWeight.w900)
      ],
    );
  }

  Container packageImage(BuildContext context, ListOrderService model) {
    return Container(
      height: FetchPixels.getPixelHeight(96),
      width: FetchPixels.getPixelHeight(96),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(10)),
          color: listColor,
          image: getDecorationAssetImage(context, 'shaving.png' ?? "")),
    );
  }

  Container finalButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getButton(context, textColor.withOpacity(0.7), "Huỷ", Colors.white,
              () async {
              Constant.backToFinish(context);
              }, 18,
              weight: FontWeight.w600,
              buttonWidth: FetchPixels.getPixelWidth(102),
              buttonHeight: FetchPixels.getPixelHeight(50),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(14))),
          getButton(context, blueColor, "Lưu", Colors.white, () async {
                  CartModel cart = CartModel(
                    address: orderModel?.address,
                    totalPrice: totalPriceCalculator(orderModel!).toString(),
                    implementationDate: orderModel?.implementationDate,
                    implementationTime: orderModel?.implementationTime,
                    listService: []
                  );
                  for(var e in orderModel!.listOrderService!){
                     cart.listService!.add(ListService(serviceId: e.serviceId,quantity: e.quantity));
                  }
                  await OrderData().updateOrderCustomer(cart, orderModel!.orderId);
                  if(mounted) {
                    Constant.backToFinish(context);
                  }

          }, 18,
              weight: FontWeight.w600,
              buttonWidth: FetchPixels.getPixelWidth(102),
              buttonHeight: FetchPixels.getPixelHeight(50),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(14))),
        ],
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
        title: "Cập nhật đơn",
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


  Widget newAddressButton(BuildContext context) {
    return getButton(
        context, const Color(0xFFF2F4F8), "+ Add New Address", blueColor, () {
      Navigator.pushNamed(context, Routes.addAddressScreenRoute)
          .then((value) => onGoBack());
    }, 18,
        weight: FontWeight.w600,
        buttonWidth: FetchPixels.getPixelWidth(224),
        buttonHeight: FetchPixels.getPixelHeight(40),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)));
  }



  String btnTitle = "Địa chỉ khác";
  Widget showMoreAddressButton(BuildContext context) {
    return getButton(
        context, const Color(0xFFF2F4F8), btnTitle, blueColor, () {
          if(showMoreAddress){
            btnTitle = "Địa chỉ khác";
          }else{
            btnTitle = 'Đóng';
          }
        setState(() {
          showMoreAddress = !showMoreAddress;
        });
    }, 18,
        weight: FontWeight.w600,
        buttonWidth: FetchPixels.getPixelWidth(174),
        buttonHeight: FetchPixels.getPixelHeight(30),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)));
  }
  int totalPriceCalculator(OrderModel order){
    int totalPrice = 0;
    for(var e in order.listOrderService!){
      totalPrice = totalPrice + (int.parse(e.price!) * e.quantity!);
    }
    return totalPrice;
  }
  Widget showMoreServiceButton(BuildContext context) {
    return getButton(
        context, backGroundColor, "Thêm dịch vụ", blueColor, () {
      showModalBottomSheet(
          backgroundColor: backGroundColor,
          isDismissible: true,
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(FetchPixels.getPixelHeight(40)),
            ),
          ),
          builder: (context) {
            DataFile.orderDetailObj = orderModel!;
            return const CategoryDialog();
          }).then((value) => orderModel = DataFile.orderDetailObj);
    }, 16,
        weight: FontWeight.w500,
        buttonWidth: FetchPixels.getPixelWidth(154),
        buttonHeight: FetchPixels.getPixelHeight(20),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)));
  }

  Column addressList() {
    return showMoreAddress ? Column(
      children: [
         Container(
            width: FetchPixels.getPixelWidth(374),
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
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: FetchPixels.getPixelHeight(12),
                  horizontal: FetchPixels.getPixelWidth(16)),
              itemCount: addressLists.length,
              shrinkWrap: true,
              primary: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: ((context, index) {
                AddressModel modelAddress = addressLists[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      orderModel!.address = modelAddress.addressId.toString();
                      orderModel!.addressM = modelAddress;
                    });
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(bottom: FetchPixels.getPixelHeight(8)),
                    width: FetchPixels.getPixelWidth(374),
                    padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelWidth(12),
                        vertical: FetchPixels.getPixelHeight(12)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0.0, 4.0)),
                        ],
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: getCustomFont(
                                  modelAddress.customerNameOrder ?? '',
                                  16,
                                  Colors.black,
                                  1,
                                  fontWeight: FontWeight.w900),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Align(
                              alignment: Alignment.topLeft,
                              child: getCustomFont(
                                  modelAddress.customerPhoneOrder ?? '',
                                  16,
                                  Colors.black,
                                  1,
                                  fontWeight: FontWeight.w400),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                  width: FetchPixels.getPixelWidth(280),
                                  child: getMultilineCustomFont(
                                      '${modelAddress.homeNumber},  ${modelAddress.street}, ${modelAddress.ward}, ${modelAddress.district}, ${modelAddress.city}',
                                      16,
                                      Colors.black,
                                      fontWeight: FontWeight.w400,
                                      txtHeight: 1.4)),
                            ),
                          ],
                        ),
                        getSvgImage(
                            orderModel!.addressM?.addressId ==
                                    modelAddress.addressId
                                ? "selected.svg"
                                : "unselected.svg",
                            height: FetchPixels.getPixelHeight(24),
                            width: FetchPixels.getPixelHeight(24))
                      ],
                    ),
                  ),
                );
              }),
            )),
        getVerSpace(FetchPixels.getPixelHeight(12)),
        newAddressButton(context),
        getVerSpace(FetchPixels.getPixelHeight(12)),
        showMoreAddressButton(context),
      ],
    ):
    Column(
      children: [
        Container(
            width: FetchPixels.getPixelWidth(374),
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
            child: Container(
                    margin:
                    EdgeInsets.only(bottom: FetchPixels.getPixelHeight(8)),
                    width: FetchPixels.getPixelWidth(374),
                    padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelWidth(12),
                        vertical: FetchPixels.getPixelHeight(12)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0.0, 4.0)),
                        ],
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: getCustomFont(
                                  orderModel!.addressM!.customerNameOrder ?? '',
                                  16,
                                  Colors.black,
                                  1,
                                  fontWeight: FontWeight.w900),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Align(
                              alignment: Alignment.topLeft,
                              child: getCustomFont(
                                  orderModel!.addressM!.customerPhoneOrder ?? '',
                                  16,
                                  Colors.black,
                                  1,
                                  fontWeight: FontWeight.w400),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                  width: FetchPixels.getPixelWidth(280),
                                  child: getMultilineCustomFont(
                                      '${orderModel!.addressM!.homeNumber},  ${orderModel!.addressM!.street}, ${orderModel!.addressM!.ward}, ${orderModel!.addressM!.district}, ${orderModel!.addressM!.city}',
                                      16,
                                      Colors.black,
                                      fontWeight: FontWeight.w400,
                                      txtHeight: 1.4)),
                            ),
                          ],
                        ),
                        getSvgImage(
                                 "selected.svg",
                            height: FetchPixels.getPixelHeight(24),
                            width: FetchPixels.getPixelHeight(24))
                      ],
                    ),
                  ),
              ),
        getVerSpace(FetchPixels.getPixelHeight(12)),
        showMoreAddressButton(context)
      ],
    );
  }

  GridView timeList() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: timeLists.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              orderModel!.implementationTime =
                  timeLists[index].characters.take(5).toString();
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0.0, 4.0)),
                ],
                border: orderModel!.implementationTime ==
                        timeLists[index].characters.take(5).toString()
                    ? Border.all(color: blueColor, width: 2)
                    : null,
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(12))),
            child: getCustomFont(
              timeLists[index],
              16,
              orderModel!.implementationTime ==
                      timeLists[index].characters.take(5).toString()
                  ? blueColor
                  : Colors.black,
              1,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: FetchPixels.getPixelHeight(56),
          crossAxisSpacing: FetchPixels.getPixelWidth(19),
          mainAxisSpacing: FetchPixels.getPixelHeight(16)),
    );
  }

  Container calendarContainer() {
    return Container(
      height: FetchPixels.getPixelHeight(263),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0.0, 4.0)),
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(20))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(20)),
        child: SfDateRangePicker(
          monthViewSettings: const DateRangePickerMonthViewSettings(
            dayFormat: "EEE",
          ),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            orderModel!.implementationDate =
                DateTime.parse(args.value.toString()).toString();
          },
          initialSelectedDate: DateTime.parse(orderModel!.implementationDate!),
          selectionShape: DateRangePickerSelectionShape.circle,
          selectableDayPredicate: (date) {
            // if (date.weekday == 6 || date.weekday == 7) {
            //   return false;
            // }
            DateTime now = DateTime.now().subtract(const Duration(days: 1));
            if (!now.isBefore(date)) {
              return false;
            }
            return true;
          },
          showNavigationArrow: true,
          backgroundColor: Colors.white,
          selectionColor: blueColor,
          monthCellStyle: DateRangePickerMonthCellStyle(
              todayCellDecoration: BoxDecoration(
                  border: Border.all(color: blueColor), shape: BoxShape.circle),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: FetchPixels.getPixelHeight(14),
                fontWeight: FontWeight.w400,
              ),
              todayTextStyle: TextStyle(
                color: blueColor,
                fontSize: FetchPixels.getPixelHeight(14),
                fontWeight: FontWeight.w400,
              )),
          selectionTextStyle: TextStyle(
            color: Colors.white,
            fontSize: FetchPixels.getPixelHeight(14),
            fontWeight: FontWeight.w400,
          ),
          selectionMode: DateRangePickerSelectionMode.single,
          headerStyle: DateRangePickerHeaderStyle(
              textAlign: TextAlign.start,
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: FetchPixels.getPixelHeight(16))),
        ),
      ),
    );
  }
}
