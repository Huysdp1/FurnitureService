import 'dart:convert';

import 'package:customer_app/app/data/account_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../models/model_address.dart';
import '../../routes/app_routes.dart';
import '../dialog/delete_dialog.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  SharedPreferences? selection;
  List<AddressModel> addressList =[];
  Future loadAddressData() async {
    await AccountData().fetchCustomerAddress(context);
  }

  Future<List<AddressModel>> getPrefAddressData() async {
    loadAddressData().then((value) async {
      String getModel = await PrefData.getAddressModel();
      if (getModel.isNotEmpty) {
        addressList = AddressModel.fromList(
            json.decode(getModel).cast<Map<String, dynamic>>());
        if (mounted) {
          setState(() {});
        }
      }
    });
    return addressList;
  }
  @override
  void initState() {

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
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 1),() {
                  setState(() {
                  });});
              },
              child: FutureBuilder<List<AddressModel>>(
                  future: getPrefAddressData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: FetchPixels.getPixelWidth(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getVerSpace(FetchPixels.getPixelHeight(20)),
                            buildToolbar(context),
                            getVerSpace(FetchPixels.getPixelHeight(30)),
                            Visibility(
                              visible: addressList.isNotEmpty,
                              child: getCustomFont(
                                  "Địa chỉ của bạn", 16, Colors.black, 1,
                                  fontWeight: FontWeight.w400),
                            ),
                            buildExpand(context),
                            Visibility(
                              visible: addressList.isNotEmpty,
                              child: addAddressButton(context),
                            )
                          ],
                        ),
                      );
                    }
                  }),
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);

          return false;
        });
  }

  Expanded buildExpand(BuildContext context) {
    return Expanded(
      flex: 1,
      child: (addressList.isEmpty)
          ? buildEmptyWidget(context)
          : buildAddressList(),
    );
  }

  Column buildEmptyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: FetchPixels.getPixelHeight(124),
          width: FetchPixels.getPixelHeight(124),
          decoration: BoxDecoration(
            image: getDecorationAssetImage(context, 'home_address.png'),
          ),
        ),
        getVerSpace(FetchPixels.getPixelHeight(40)),
        getCustomFont("Chưa có địa chỉ!", 20, Colors.black, 1,
            fontWeight: FontWeight.w900),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont(
          "Thêm địa chỉ mới để đặt lịch dễ dàng hơn",
          16,
          Colors.black,
          1,
          fontWeight: FontWeight.w400,
        ),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getButton(context, backGroundColor, "Tạo địa chỉ", blueColor, () async {
          var re = await Constant.sendToNext(context, Routes.addAddressScreenRoute);
          addressList.add(re);
          setState(() {

          });
        }, 18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            insetsGeometry:
                EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(98)),
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
            isBorder: true,
            borderColor: blueColor,
            borderWidth: 1.5)
      ],
    );
  }

  ListView buildAddressList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: FetchPixels.getPixelHeight(20)),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      primary: true,
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        AddressModel modelAddress = addressList[index];
        return Container(
          margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
          padding: EdgeInsets.only(
            bottom: FetchPixels.getPixelHeight(16),
            left: FetchPixels.getPixelWidth(16),
          ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: FetchPixels.getPixelHeight(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          getCustomFont(
                            modelAddress.customerNameOrder ?? "",
                            16,
                            Colors.black,
                            1,
                            fontWeight: FontWeight.w900,
                          ),
                          modelAddress.customerPhoneOrder != null ? getCustomFont(
                             "  ||  ",
                            16,
                            Colors.black,
                            1,
                            fontWeight: FontWeight.w400,
                          ): getCustomFont( "",
                            16,
                            Colors.black,
                            1,
                            fontWeight: FontWeight.w400,
                          ),
                          getCustomFont(
                            modelAddress.customerPhoneOrder ?? "",
                            16,
                            Colors.black,
                            1,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      SizedBox(
                        width: FetchPixels.getPixelWidth(280),
                        child: getMultilineCustomFont(
                            '${modelAddress.homeNumber},  ${modelAddress.street}, ${modelAddress.ward}, ${modelAddress.district}, ${modelAddress.city}',
                            16,
                            Colors.black,
                            fontWeight: FontWeight.w400,
                            txtHeight: 1.3),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      modelAddress.isDefault == true
                          ? Container(
                              //color: Colors.purple,
                              alignment: Alignment.center,
                              width: 80,
                              height: 25,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 1),
                              ),
                              child: getCustomFont(
                                "Mặc định",
                                14,
                                Colors.red,
                                1,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          : Container(),

                    ],
                  ),
                ),
              ),
              PopupMenuButton<int>(
                onSelected: (value) async {
                  if (value == 1) {
                    await AccountData()
                        .setDefaultAddress(modelAddress.addressId);
                    setState(() {});
                  }
                  if (value == 3) {
                    showDialog(
                        barrierDismissible: false,
                        builder: (context) {
                          selection!.setInt("index", modelAddress.addressId ?? 0);
                          return const DeleteDialog();
                        },
                        context: context);
                    setState(() {});
                  }
                  if (value == 2) {
                    selection!.setInt("addressId", modelAddress.addressId ?? 0);
                    selection!
                        .setString("customerNameOrder", modelAddress.customerNameOrder ?? '');
                    selection!
                        .setString("homeNumber", modelAddress.homeNumber ?? '');
                    selection!.setString("street", modelAddress.street ?? '');
                    selection!.setString("ward", modelAddress.ward ?? '');
                    selection!
                        .setString("district", modelAddress.district ?? '');
                    selection!.setString("city", modelAddress.city ?? '');
                    selection!.setString("phoneAddress", modelAddress.customerPhoneOrder ?? '');
                    if(mounted){
                         await Constant.sendToNext(context, Routes.editAddressRoute);
                      // setState(() {
                      //   modelAddress.copyWith(
                      //       customerNameOrder: address.customerNameOrder,
                      //       customerPhoneOrder: address.customerPhoneOrder,
                      //       homeNumber: address.homeNumber,
                      //       street: address.street,
                      //       ward: address.ward,
                      //       district: address.district,
                      //       city: address.city,
                      //   );
                      // });
                    }
                  }
                },
                padding: EdgeInsets.only(top: FetchPixels.getPixelHeight(15)),
                icon: getSvgImage("more_vert.svg",
                    width: FetchPixels.getPixelHeight(2),
                    height: FetchPixels.getPixelHeight(16)),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(12))),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getCustomFont(
                          "Đặt mặc định",
                          14,
                          Colors.black,
                          1,
                          fontWeight: FontWeight.w400,
                        ),
                        const Icon(Icons.star_outlined, color: Colors.yellow),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(
                    height: 0,
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: getCustomFont(
                      "Chỉnh sửa",
                      14,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const PopupMenuDivider(
                    height: 0,
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: getCustomFont(
                      "Xóa",
                      14,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
                offset: const Offset(-20, 40),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildToolbar(BuildContext context) {
    return gettoolbarMenu(context, "back.svg", () {
      Constant.backToPrev(context);
    },
        istext: true,
        title: "Địa chỉ của tôi",
        weight: FontWeight.w900,
        fontsize: 24,
        textColor: Colors.black);
  }

  Column addAddressButton(BuildContext context) {
    return Column(
      children: [
        getButton(context, blueColor, "Thêm địa chỉ mới", Colors.white, () async {
          var re = await Constant.sendToNext(context, Routes.addAddressScreenRoute);
          addressList.add(re);
          setState(() {

          });
        }, 18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(14))),
        getVerSpace(FetchPixels.getPixelHeight(30))
      ],
    );
  }
}
