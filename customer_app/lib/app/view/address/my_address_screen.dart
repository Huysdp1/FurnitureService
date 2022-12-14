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
            child: FutureBuilder<List<AddressModel>>(
              future: AccountData().fetchCustomerAddress(2),
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
                          visible: snapshot.data!.isNotEmpty,
                          child: getCustomFont(
                              "Your addresses", 16, Colors.black, 1,
                              fontWeight: FontWeight.w400),
                        ),
                        buildExpand(context, snapshot.data!),
                        Visibility(
                          visible: snapshot.data!.isNotEmpty,
                          child: addAddressButton(context),
                        )
                      ],
                    ),
                  );
                }
              }
              ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);

          return false;
        });
  }

  Expanded buildExpand(BuildContext context,List<AddressModel> addressList) {
    return Expanded(
      flex: 1,
      child: (addressList.isEmpty)
          ? buildEmptyWidget(context)
          : buildAddressList(addressList),
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
        getCustomFont("No Address Yet!", 20, Colors.black, 1,
            fontWeight: FontWeight.w900),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont(
          "Add your address and lets get started.",
          16,
          Colors.black,
          1,
          fontWeight: FontWeight.w400,
        ),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getButton(context, backGroundColor, "Add Address", blueColor, () {}, 18,
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

  ListView buildAddressList(List<AddressModel> addressList) {
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
                      getCustomFont(
                        modelAddress.customer ?? "",
                        16,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w900,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      SizedBox(
                        width: FetchPixels.getPixelWidth(280),
                        child: getMultilineCustomFont(
                            '${modelAddress.homeNumber},  ${modelAddress.street}, ${modelAddress.ward}, ${modelAddress.district}, ${modelAddress.city}', 16, Colors.black,
                            fontWeight: FontWeight.w400, txtHeight: 1.3),
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      modelAddress.isDefault==true ?Container(
                        //color: Colors.purple,
                        alignment: Alignment.center,
                        width: 80,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 1),
                        ),
                        child: getCustomFont("Mặc định",
                          14,
                          Colors.red,
                          1,
                          fontWeight: FontWeight.w300,
                        ),
                      ):Container(),
                      // getCustomFont(
                      //   modelAddress.phone ?? "",
                      //   16,
                      //   Colors.black,
                      //   1,
                      //   fontWeight: FontWeight.w400,
                      // ),
                    ],
                  ),
                ),
              ),
              PopupMenuButton<int>(
                onSelected: (value) async {
                  if (value == 1) {
                    await AccountData().setDefaultAddress(2, modelAddress.addressId);
                    setState(() {

                    });
                  }
                  if (value == 3) {
                    PrefData.setDefIndex(index);
                    showDialog(
                        barrierDismissible: false,
                        builder: (context) {
                          return const DeleteDialog();
                        },
                        context: context);
                    setState(() {});
                  }
                  if (value == 2) {
                    //await selection!.setString("customerId", modelAddress.customerId.toString() ?? '');
                     selection!.setString("customer", modelAddress.customer ?? '');
                     selection!.setString("homeNumber", modelAddress.homeNumber ?? '');
                     selection!.setString("street", modelAddress.street ?? '');
                     selection!.setString("ward", modelAddress.ward ?? '');
                     selection!.setString("district", modelAddress.district ?? '');
                     selection!.setString("city", modelAddress.city ?? '');
                    //selection!.setString("phone", modelAddress.phone ?? '');
                     Constant.sendToNext(context, Routes.editAddressRoute);
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
                        const Icon(Icons.star_outlined,color: Colors.yellow),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(
                    height: 0,
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: getCustomFont(
                      "Edit",
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
                      "Delete",
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
        title: "My Address",
        weight: FontWeight.w900,
        fontsize: 24,
        textColor: Colors.black);
  }

  Column addAddressButton(BuildContext context) {
    return Column(
      children: [
        getButton(context, blueColor, "Add New Address", Colors.white, () {
          Constant.sendToNext(context, Routes.addAddressScreenRoute);
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
