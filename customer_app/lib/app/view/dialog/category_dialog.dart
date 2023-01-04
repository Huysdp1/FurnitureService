
import 'dart:convert';

import 'package:customer_app/app/models/model_order.dart';
import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';
import '../../data/order_data.dart';
import '../../data/service_data.dart';
import '../../models/model_category.dart';
import '../../models/model_service.dart';

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({Key? key}) : super(key: key);

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  List<CategoryModel> categoryLists = [];
  List<ServiceModel> serviceList = [];
  OrderModel? orderModel;
  var cateId = -1;
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
  @override
  void initState() {
    orderModel = DataFile.orderDetailObj;
    getPrefCateSerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Wrap(
      children: [
        Container(
          child: getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
            Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(34)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Thêm dịch vụ", 20, Colors.black, 1,
                        fontWeight: FontWeight.w900, ),
                    GestureDetector(
                      onTap: () {
                        Constant.backToPrev(context);
                      },
                      child: getSvgImage("close.svg",
                          height: FetchPixels.getPixelHeight(24),
                          width: FetchPixels.getPixelHeight(24)),
                    )
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                dropdownButton(),
                getHorSpace(FetchPixels.getPixelWidth(20)),
                buildListView(FetchPixels.getDefaultHorSpace(context)),
                getVerSpace(FetchPixels.getPixelHeight(29)),
                continueButton(context),
                getVerSpace(FetchPixels.getPixelHeight(30))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget continueButton(BuildContext context) {
    return getButton(context, blueColor, "Xong", Colors.white, () {
      Constant.backToPrev(context);
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)));
  }

  ListView buildListView(double defSpace) {
    return ListView.builder(
      shrinkWrap: true,
      primary: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount: serviceList.length,
      itemBuilder: (context, index) {
        ServiceModel serviceModel = serviceList[index];
        return Container(
          margin: EdgeInsets.only(
              bottom: FetchPixels.getPixelHeight(20),
              left: defSpace,
              right: defSpace),
          width: FetchPixels.getPixelWidth(374),
          padding: EdgeInsets.only(
              left: FetchPixels.getPixelWidth(16),
              right: FetchPixels.getPixelWidth(16),
              top: FetchPixels.getPixelHeight(16),
              bottom: FetchPixels.getPixelHeight(16)),
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
            children: [
              packageImage(context, serviceModel),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: FetchPixels.getPixelWidth(10),right: FetchPixels.getPixelWidth(2)),
                  child: packageDescription(serviceModel),
                ),
              ),
              addButton(serviceModel, context, index)
            ],
          ),
        );
      },
    );
  }

  Column addButton(ServiceModel serviceModel, BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if(!orderModel!.listOrderService!.any((element) => element.serviceId == serviceModel.serviceId)
        )
          getButton(context, Colors.transparent, "Thêm", blueColor, () {
            orderModel!.totalPrice = (int.parse(orderModel!.totalPrice!) +
                (int.parse(serviceModel.price!) * 1))
                .toString();
            orderModel!.listOrderService?.add(ListOrderService(
                serviceId: serviceModel.serviceId, quantity: 1,serviceName: serviceModel.serviceName,price: serviceModel.price));
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
                    .toString()?? "1",
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
                onTap: () async {
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
                    await OrderData().deleteOrderCustomer(orderModel!.orderId, orderModel!.listOrderService?.firstWhere((element) => element.serviceId==serviceModel.serviceId).orderServiceId);
                    orderModel!.listOrderService?.removeWhere((element) =>
                    element.serviceId == serviceModel.serviceId);
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
        getCustomFont("${Constant.showTextMoney(serviceModel.price)}đ", 16, blueColor, 1,
            fontWeight: FontWeight.w900)
      ],
    );
  }

  Column packageDescription(ServiceModel serviceModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont(
          serviceModel.serviceName ?? '',
          16,
          Colors.black,
          2,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w700,
        ),
        getVerSpace(FetchPixels.getPixelHeight(6)),
        getCustomFont("Mô tả: ${serviceModel.serviceDescription}", 14, textColor, 3,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w400),
      ],
    );
  }

  Container packageImage(BuildContext context, ServiceModel model) {
    return Container(
      height: FetchPixels.getPixelHeight(96),
      width: FetchPixels.getPixelHeight(96),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(10)),
          color: listColor,
          image: getDecorationAssetImage(context, 'shaving.png' ?? "")),
    );
  }

  Column productDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont("Dịch vụ ${categoryLists.firstWhere((element) => element.categoryId==cateId).categoryName!.toLowerCase()}", 24, Colors.black, 1,
            fontWeight: FontWeight.w900),
        getVerSpace(FetchPixels.getPixelHeight(17)),
        getVerSpace(FetchPixels.getPixelHeight(24)),
        getMultilineCustomFont(
            "Đây là mô tả về dịch vụ vệ sinh",
            16,
            Colors.black,
            fontWeight: FontWeight.w400,
            txtHeight: 1.3),
      ],
    );
  }

  Widget dropdownButton(){
    return Row(
      children: [
        getHorSpace(FetchPixels.getPixelWidth(20)),
        getCustomFont("Phân loại:", 18, Colors.black, 1,
            fontWeight: FontWeight.w900),
        getHorSpace(FetchPixels.getPixelWidth(16)),
        DropdownButton(
          // Initial Value
          value: cateId,
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),
          // Array list of items
          items: categoryLists.map((CategoryModel items) {
            return DropdownMenuItem(
              value: items.categoryId,
              child: SizedBox(
                width:
                MediaQuery.of(context).size.width / 5,
                child: getCustomFont(items.categoryName?? "", 16, Colors.black, 1,
                    fontWeight: FontWeight.w400),
              ),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (newValue) async {
            setState(() {
              cateId = newValue!;
              getPrefCateSerData();
            });
          },
        ),
      ],
    );
  }

}
