import 'dart:async';
import 'dart:convert';

import 'package:customer_app/app/data/account_data.dart';
import 'package:customer_app/app/data/data_file.dart';
import 'package:customer_app/app/models/model_address.dart';
import 'package:customer_app/base/pref_data.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}



class _AddressScreenState extends State<AddressScreen> {
  SharedPreferences? selection;
  FutureOr onGoBack() async{
    await AccountData().fetchCustomerAddress();
    setState(() {
      getPrefData();
    });
  }
  getPrefData() async {
    String getModel = await PrefData.getAddressModel();
    if (getModel.isNotEmpty) {
      DataFile.selectionAddress = AddressModel.fromList(
          json.decode(getModel).cast<Map<String, dynamic>>()).firstWhere((element) => element.isDefault!);
      setState(() {});
    }
  }

  @override
  initState()  {
    super.initState();
    getPrefData();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      selection = sp;
      setState(() {});
    });

  }
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          bottomNavigationBar: continueButton(context),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    gettoolbarMenu(context, "back.svg", () {
                      Constant.backToPrev(context);
                    },
                        title: "Chọn địa chỉ",
                        weight: FontWeight.w900,
                        istext: true,
                        fontsize: 24,
                        textColor: Colors.black),
                    getVerSpace(FetchPixels.getPixelHeight(30)),
                    processTracker(),
                    getVerSpace(FetchPixels.getPixelHeight(30)),
                    addressList(),
                    getVerSpace(FetchPixels.getPixelHeight(30)),
                    newAddressButton(context)
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  Container continueButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(30)),
      child: getButton(context, blueColor, "Tiếp tục", Colors.white, () {
        Constant.sendToNext(context, Routes.dateTimeRoute);
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }

  Widget newAddressButton(BuildContext context) {
    return getButton(
        context, const Color(0xFFF2F4F8), "+ Add New Address", blueColor, () {
            //Constant.sendToNext(context, Routes.addAddressScreenRoute);
            Navigator.pushNamed(context, Routes.addAddressScreenRoute).then((value) => onGoBack());
    }, 18,
        weight: FontWeight.w600,
        buttonWidth: FetchPixels.getPixelWidth(224),
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)));
  }

  Column addressList() {
    return Column(
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
          child: FutureBuilder<List<AddressModel>>(
            future: AccountData().fetchCustomerAddress(),
            builder: (context,snapshot) {
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              }else {
                return ListView.builder(
                padding: EdgeInsets.symmetric(
                    vertical: FetchPixels.getPixelHeight(16),
                    horizontal: FetchPixels.getPixelWidth(16)),
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                primary: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  scrollDirection:
                  Axis.vertical,
                itemBuilder: ((context, index) {
                  AddressModel modelAddress = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        DataFile.selectionAddress = modelAddress;
                      });
                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
                      width: FetchPixels.getPixelWidth(374),
                      padding: EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelWidth(16),
                          vertical: FetchPixels.getPixelHeight(16)),
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
                                    modelAddress.customerNameOrder ?? '', 16, Colors.black, 1,
                                    fontWeight: FontWeight.w900),
                              ),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              Align(
                                alignment: Alignment.topLeft,
                                child: getCustomFont(
                                    modelAddress.customerPhoneOrder ?? '', 16, Colors.black, 1,
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
                              DataFile.selectionAddress.addressId == modelAddress.addressId ? "selected.svg" : "unselected.svg",
                              height: FetchPixels.getPixelHeight(24),
                              width: FetchPixels.getPixelHeight(24))
                        ],
                      ),
                    ),
                  );
                }),
              );
              }
            }
          ),
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),

      ],
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
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(50))),
          child: getSvgImage("location.svg"),
        ),
        Expanded(
          child: DottedLine(
            dashColor: const Color(0xFFBEC4D3),
            lineThickness: FetchPixels.getPixelHeight(1),
          ),
        ),
        Container(
          height: FetchPixels.getPixelHeight(52),
          width: FetchPixels.getPixelHeight(52),
          padding: EdgeInsets.all(FetchPixels.getPixelHeight(14)),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E8F1), width: 1),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(50))),
          child: getSvgImage("clock.svg"),
        ),
        Expanded(
          child: DottedLine(
            dashColor: const Color(0xFFBEC4D3),
            lineThickness: FetchPixels.getPixelHeight(1),
          ),
        ),
        Container(
          height: FetchPixels.getPixelHeight(52),
          width: FetchPixels.getPixelHeight(52),
          padding: EdgeInsets.all(FetchPixels.getPixelHeight(14)),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E8F1), width: 1),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(50))),
          child: getSvgImage("check.svg"),
        ),
      ],
    );
  }
}
