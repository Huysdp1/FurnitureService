
import 'package:customer_app/app/data/order_data.dart';
import 'package:customer_app/app/models/model_service.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';
import '../../models/model_cart.dart';
import '../dialog/confirm_dialog.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  List<ServiceModel> list = [];
  int total = 0;
  int discount = 0;
  late CartModel fromCart;
  Future<List<ServiceModel>> getList() async {
    list = [];
    for (var value in DataFile.selectionServices) {
      list.add(value);
    }
    return list;
  }
  List<ListService> listSerId = [];
   createOrder() {
     for(var val in list){
       listSerId.add(ListService(serviceId: val.serviceId,quantity: val.quantity));
    }
    CartModel fromCart = CartModel(
      customerId: 2,
      address: '${DataFile.selectionAddress.homeNumber}, ${DataFile.selectionAddress.street}, ${DataFile.selectionAddress.ward}, ${DataFile.selectionAddress.district}, ${DataFile.selectionAddress.city}',
      createAt: DateTime.now().toString(),
      implementationDate: date,
      implementationTime: time,
      totalPrice: total.toString(),
      listService: listSerId
    );
     OrderData().createOrderCustomer(fromCart);
  }
  int cartTotalPrice() {
    for (var value in DataFile.selectionServices) {
      total += int.parse(value.price!) * value.quantity!;
    }
    return total;
  }
  List<ServiceModel> ser = [];
  void getPrefData(){
    date = selection?.getString('selectDate')?? now.toString();
    time = selection?.getString("time") ?? "8:00";
  }
  SharedPreferences? selection;
  DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();


    SharedPreferences.getInstance().then((SharedPreferences sp) {
      selection = sp;
      setState(() {});
    });
    cartTotalPrice();
    now;
  }

  String? date;
  String? time;

  bool confirm = false;

  @override
  Widget build(BuildContext context) {
    getPrefData();
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          bottomNavigationBar: confirmButton(context),
          body: SafeArea(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
              child: Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  gettoolbarMenu(context, "back.svg", () {
                    Constant.backToPrev(context);
                  },
                      title: "Hoàn tất đơn",

                      weight: FontWeight.w900,
                      istext: true,
                      fontsize: 24,
                      textColor: Colors.black),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  processTracker(),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dateTimeContainer(),
                            getVerSpace(FetchPixels.getPixelHeight(20)),
                            addressContainer(),
                            getVerSpace(FetchPixels.getPixelHeight(20)),
                            cartList(),
                            getVerSpace(FetchPixels.getPixelHeight(30)),
                            paymentDetail(),
                            getVerSpace(FetchPixels.getPixelHeight(30)),
                          ],
                        ),
                      ),
                    ),
                  )
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

  Container confirmButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(33)),
      child: getButton(context, blueColor, "Xác nhận", Colors.white, () async {
        await createOrder();
        setState(() {
          confirm = true;
          selection!.remove("selectDate");
          selection!.remove("time");
          selection!.remove("image");
          DataFile.selectionServices.clear();
        });
        showDialog(
            barrierDismissible: false,
            builder: (context) {
              return const ConfirmDialog();
            },
            context: context);
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }

  Column paymentDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont("Thông tin thanh toán", 20, Colors.black, 1,
            fontWeight: FontWeight.w900, ),
        getVerSpace(FetchPixels.getPixelHeight(16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getCustomFont("Tổng dịch vụ", 16, Colors.black, 1,
                fontWeight: FontWeight.w400, ),
            getCustomFont("${Constant.showTextMoney(total)}đ", 16, Colors.black, 1,
                fontWeight: FontWeight.w600, )
          ],
        ),
        getVerSpace(FetchPixels.getPixelHeight(16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getCustomFont("Giảm giá (0%)", 16, Colors.black, 1,
                fontWeight: FontWeight.w400, ),
            getCustomFont("-${Constant.showTextMoney(discount)}đ", 16, Colors.black, 1,
                fontWeight: FontWeight.w600, )
          ],
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getDivider(dividerColor, FetchPixels.getPixelHeight(1), 1),
        getVerSpace(FetchPixels.getPixelHeight(16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getCustomFont("Tổng tiền", 24, Colors.black, 1,
                 fontWeight: FontWeight.w900),
            getCustomFont("${Constant.showTextMoney(total - discount)}đ", 24, Colors.black, 1,
                fontWeight: FontWeight.w900, )
          ],
        ),
      ],
    );
  }

  Container cartList() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(16),
          right: FetchPixels.getPixelWidth(16),
          top: FetchPixels.getPixelHeight(16)),
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
          getCustomFont("Chi tiết dịch vụ", 16, Colors.black, 1,
              fontWeight: FontWeight.w900, ),
          getVerSpace(FetchPixels.getPixelHeight(13)),
          FutureBuilder<List<ServiceModel>>(
              future: getList(),
              builder: (context, snapshot) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  list = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      ServiceModel? serviceModel = list[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child:
                                          getCustomFont(serviceModel.serviceName ?? "", 16,
                                            Colors.black, 2,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w700,
                                          ),

                                      ),
                                      getVerSpace(
                                          FetchPixels.getPixelHeight(4)),
                                      getCustomFont(
                                          serviceModel.categoryName.toString(),
                                          14,
                                          textColor,
                                          2,
                                          fontWeight: FontWeight.w400,
                                          ),
                                      getVerSpace(
                                          FetchPixels.getPixelHeight(9)),
                                      getCustomFont("\$${serviceModel.price}",
                                          16, blueColor, 1,

                                          fontWeight: FontWeight.w900)
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: getSvgImage("add1.svg",
                                        width: FetchPixels.getPixelHeight(30),
                                        height:
                                            FetchPixels.getPixelHeight(30)),
                                    onTap: () {
                                      serviceModel.quantity =
                                          (serviceModel.quantity! + 1);
                                      total = total + (int.parse(serviceModel.price!) * 1);
                                      setState(() {});
                                    },
                                  ),
                                  getHorSpace(FetchPixels.getPixelWidth(10)),
                                  getCustomFont(serviceModel.quantity.toString(),
                                      14, Colors.black, 1,
                                      fontWeight: FontWeight.w400,
                                      ),
                                  getHorSpace(FetchPixels.getPixelWidth(10)),
                                  GestureDetector(
                                    child: getSvgImage("minus.svg",
                                        width: FetchPixels.getPixelHeight(30),
                                        height:
                                            FetchPixels.getPixelHeight(30)),
                                    onTap: () {
                                      if (serviceModel.quantity! <= 1) {
                                        setState(() {
                                          DataFile.selectionServices.removeAt(index);
                                        });
                                      } else {
                                        serviceModel.quantity =
                                            (serviceModel.quantity! - 1);
                                      }
                                      // print(modelSalon.quantity);
                                      total = total - (int.parse(serviceModel.price!) * 1);

                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          getVerSpace(FetchPixels.getPixelHeight(20)),
                          index == 2
                              ? Container()
                              : getDivider(dividerColor,
                                  FetchPixels.getPixelHeight(1), 1),
                          index == 2
                              ? Container()
                              : getVerSpace(FetchPixels.getPixelHeight(20)),
                        ],
                      );
                    },
                  );
                } else {
                  return Container();
                }
              })
        ],
      ),
    );
  }


  Container addressContainer() {
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
              getSvgImage("location.svg"),
              getHorSpace(FetchPixels.getPixelWidth(4)),
              getCustomFont("Địa chỉ", 16, Colors.black, 1,
                  fontWeight: FontWeight.w900, ),
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getCustomFont(
                  DataFile.selectionAddress.customerNameOrder ?? '', 16, Colors.black, 1,
                  fontWeight: FontWeight.w700),
              if(DataFile.selectionAddress.customerPhoneOrder != null)
                getCustomFont(' || ', 16, Colors.black, 1),

              getCustomFont(
                  DataFile.selectionAddress.customerPhoneOrder ?? '', 16, Colors.black, 1,
                  fontWeight: FontWeight.w400),
            ],
          ),
      getVerSpace(FetchPixels.getPixelHeight(8)),
          getMultilineCustomFont(
              '${DataFile.selectionAddress.homeNumber},  ${DataFile.selectionAddress.street}, ${DataFile.selectionAddress.ward}, ${DataFile.selectionAddress.district}, ${DataFile.selectionAddress.city}',
              16,
              Colors.black,
              fontWeight: FontWeight.w400,
              txtHeight: 1.4),

        ],
      ),
    );
  }

  Container dateTimeContainer() {
    return Container(
      width: FetchPixels.getPixelWidth(374),
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(18),
          right: FetchPixels.getPixelWidth(20),
          top: FetchPixels.getPixelHeight(18),
          bottom: FetchPixels.getPixelHeight(18)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0.0, 4.0)),
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              getSvgImage("calender.svg",
                  width: FetchPixels.getPixelHeight(24),
                  height: FetchPixels.getPixelHeight(24)),
              getHorSpace(FetchPixels.getPixelWidth(12)),
              getCustomFont(
                  "Thời gian hẹn: $time, ${Constant.parseDateNoUTC(date, false)}", 16, Colors.black, 1,
                   fontWeight: FontWeight.w400)
            ],
          ),
        ],
      ),
    );
  }

  Row processTracker() {
    return Row(
      children: [
        Container(
          height: FetchPixels.getPixelHeight(52),
          width: FetchPixels.getPixelHeight(52),
          padding: EdgeInsets.all(FetchPixels.getPixelHeight(14)),
          decoration: BoxDecoration(
              color: procced,
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(50))),
          child: getSvgImage("location_select.svg"),
        ),
        Expanded(
          child: DottedLine(
            dashColor: blueColor,
            lineThickness: FetchPixels.getPixelHeight(1),
          ),
        ),
        Container(
          height: FetchPixels.getPixelHeight(52),
          width: FetchPixels.getPixelHeight(52),
          padding: EdgeInsets.all(FetchPixels.getPixelHeight(14)),
          decoration: BoxDecoration(
              color: procced,
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(50))),
          child: getSvgImage("clock.svg"),
        ),
        Expanded(
          child: DottedLine(
            dashColor: blueColor,
            lineThickness: FetchPixels.getPixelHeight(1),
          ),
        ),
        Container(
          height: FetchPixels.getPixelHeight(52),
          width: FetchPixels.getPixelHeight(52),
          padding: EdgeInsets.all(FetchPixels.getPixelHeight(14)),
          decoration: confirm == true
              ? BoxDecoration(
                  color: procced,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(50)))
              : BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0.0, 4.0)),
                  ],
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(50))),
          child: getSvgImage(confirm == true ? "check_select.svg" : "check.svg",
              height: FetchPixels.getPixelHeight(24),
              width: FetchPixels.getPixelHeight(24)),
        ),
      ],
    );
  }
}
