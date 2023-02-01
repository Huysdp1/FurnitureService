import 'dart:convert';

import 'package:customer_app/app/data/service_data.dart';
import 'package:customer_app/app/models/model_category.dart';
import 'package:customer_app/app/models/model_service.dart';
import 'package:customer_app/app/view/dialog/cart_dialog.dart';
import 'package:flutter/material.dart';
import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';
import '../../models/model_popular_service.dart';
import '../../routes/app_routes.dart';


class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  List<ModelPopularService> popularServiceLists = DataFile.popularServiceList;
  List<ServiceModel> serviceList = [];
  List<ServiceModel> selectionServices =[];
  List<CategoryModel> categoryLists = [];
  // SharedPreferences? selection;
  var cateId = 0;

  getPrefData() async {
    cateId = await PrefData.getDefIndex();
    String getModel = await PrefData.getCategoryModel();
    if (getModel.isNotEmpty) {
      categoryLists = CategoryModel.fromList(
          json.decode(getModel).cast<Map<String, dynamic>>());
      setState(() {});
    }
    serviceList = await ServiceData().fetchServicesAndCategories();
    if(serviceList.isNotEmpty){
      serviceList = serviceList.where((element) => element.categoryId == cateId).toList();
    setState(() {
    });}
  }

  @override
  void initState() {
    super.initState();
    getPrefData();
  }

  int total = 0;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    double defSpace = FetchPixels.getDefaultHorSpace(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: defSpace);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(1),
            automaticallyImplyLeading: false,
            title: getPaddingWidget(
                EdgeInsets.zero,
                gettoolbarMenu(context, "back.svg", () {
                  Constant.backToPrev(context);
                },
                    title: "Chi tiết",
                    weight: FontWeight.w900,
                    textColor: Colors.black,
                    fontsize: 24,
                    istext: true,
                    isrightimage: true,
                    rightimage: "clipboard.svg",
                    counter: DataFile.selectionServices.length,
                    rightFunction: () {
                      showModalBottomSheet(
                          backgroundColor: backGroundColor,
                          isDismissible: false,
                          isScrollControlled: true,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(FetchPixels.getPixelHeight(40)),
                            ),
                          ),
                          builder: (context) {
                            return const CartDialog();
                          });
                    })),
          ),
          body: SafeArea(
            child: buildPage(edgeInsets, context, cateId, defSpace),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  ListView buildPage(
      EdgeInsets edgeInsets, BuildContext context, int id, double defSpace) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getPaddingWidget(edgeInsets, productImage(cateId)),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        dropdownButton(),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getPaddingWidget(edgeInsets, productDescription(context)),
        getVerSpace(FetchPixels.getPixelHeight(29)),
        getPaddingWidget(
            edgeInsets,
            getCustomFont("Các dịch vụ ${categoryLists.firstWhere((element) => element.categoryId==id).categoryName!.toLowerCase()}:", 16, Colors.black, 1,
                fontWeight: FontWeight.w900)),
        getVerSpace(FetchPixels.getPixelHeight(15)),
        buildListView(defSpace),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getPaddingWidget(
          edgeInsets,
          totalContainer(),
        ),
        viewCartButton(context),
        getVerSpace(FetchPixels.getPixelHeight(30))
        // packageList(context)
      ],
    );
  }

  ListView buildListView(double defSpace) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      primary: false,
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

  Widget viewCartButton(BuildContext context) {
    return getButton(context, blueColor, "Tiếp tục", Colors.white, () {
      DataFile.selectionServices.addAll(selectionServices);
      Constant.sendToNext(context, Routes.addressRoute);
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
        insetsGeometry: EdgeInsets.symmetric(
            horizontal: FetchPixels.getDefaultHorSpace(context)));
  }

  Container totalContainer() {
    return Container(
      child: total == 0
          ? Container()
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Tổng", 24, Colors.black, 1,
                        fontWeight: FontWeight.w900),
                    getCustomFont(
                      "${Constant.showTextMoney(total)}đ",
                      24,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w900,
                    )
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(30)),
              ],
            ),
    );
  }

  Column addButton(ServiceModel serviceModel, BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!DataFile.selectionServices.any((element) => element.serviceId == serviceModel.serviceId)
        )
          getButton(context, Colors.transparent, "Thêm", blueColor, () {
            serviceModel.quantity = 1;
            total = total + (int.parse(serviceModel.price!) * 1);
            DataFile.selectionServices.add(serviceModel);
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
                  DataFile.selectionServices.firstWhere((element) => element.serviceId == serviceModel.serviceId).quantity
                  = (DataFile.selectionServices.firstWhere((element) => element.serviceId == serviceModel.serviceId).quantity! + 1);
                  total = total + (int.parse(serviceModel.price!) * 1);
                  setState(() {});
                },
              ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              getCustomFont(
                DataFile.selectionServices.firstWhere((element) => element.serviceId == serviceModel.serviceId).quantity.toString(),
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
                  if(DataFile.selectionServices.firstWhere((element) => element.serviceId == serviceModel.serviceId).quantity! > 1) {
                    DataFile.selectionServices
                        .firstWhere((element) =>
                    element.serviceId == serviceModel.serviceId)
                        .quantity
                    = (DataFile.selectionServices
                        .firstWhere((element) =>
                    element.serviceId == serviceModel.serviceId)
                        .quantity! - 1);
                  }else{
                    DataFile.selectionServices
                        .removeWhere((element) =>
                    element.serviceId == serviceModel.serviceId);
                  }
                  total = total - (int.parse(serviceModel.price!) * 1);
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
        //getVerSpace(FetchPixels.getPixelHeight(17)),
        // getMultilineCustomFont(
        //     categoryLists.firstWhere((element) => element.categoryId==cateId).,
        //     16,
        //     Colors.black,
        //     fontWeight: FontWeight.w400,
        //     txtHeight: 1.3),
      ],
    );
  }

  Hero productImage(int index) {
    return Hero(
        tag: popularServiceLists[index],
        child: getCircularImage(
            context,
            FetchPixels.getPixelWidth(374),
            FetchPixels.getPixelHeight(225),
            FetchPixels.getPixelHeight(16),
            popularServiceLists[index].image ?? "",
            boxFit: BoxFit.cover));
    // getAssetImage(popularServiceLists[index].image ?? "",
    // FetchPixels.getPixelWidth(374), FetchPixels.getPixelHeight(225),
    // boxFit: BoxFit.fill),);
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
              PrefData.setDefIndex(newValue!);
              getPrefData();
            });
          },
        ),
      ],
    );
  }
}
