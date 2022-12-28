
import 'package:customer_app/app/models/model_service.dart';
import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';

class CartDialog extends StatefulWidget {
  const CartDialog({Key? key}) : super(key: key);

  @override
  State<CartDialog> createState() => _CartDialogState();
}

class _CartDialogState extends State<CartDialog> {
  var total = 0;
  @override
  void initState() {
    for(var e in DataFile.selectionServices){
      total = total + (e.quantity! * int.parse(e.price!));
    }

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
                    getCustomFont("Dịch vụ đã chọn", 20, Colors.black, 1,
                         fontWeight: FontWeight.w900),
                    GestureDetector(
                        onTap: () {
                          Constant.backToPrev(context);
                        },
                        child: getSvgImage("close.svg",
                            height: FetchPixels.getPixelHeight(24),
                            width: FetchPixels.getPixelHeight(24)))
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                colorList(),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                totalContainer(),
                doneButton(context),
                getVerSpace(FetchPixels.getPixelHeight(30))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget doneButton(BuildContext context) {
    return getButton(context, blueColor, "Xong", Colors.white, () {
      Constant.backToPrev(context);
      //Constant.sendToNext(context, Routes.cartRoute);
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)));
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
                    getCustomFont("${Constant.showTextMoney(total)}đ", 24, Colors.black, 1,
                        fontWeight: FontWeight.w900, )
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(30)),
              ],
            ),
    );
  }

  ListView colorList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount: DataFile.selectionServices.length,
      itemBuilder: (context, index) {
        ServiceModel serviceModel = DataFile.selectionServices[index];
        return Container(
          margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
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
              Container(
                height: FetchPixels.getPixelHeight(104),
                width: FetchPixels.getPixelHeight(104),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(10)),
                    image: getDecorationAssetImage(
                        context, 'shaving.png' ?? "")),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: FetchPixels.getPixelWidth(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(serviceModel.serviceName ?? '', 16, Colors.black, 1,
                          fontWeight: FontWeight.w900, ),
                      getVerSpace(FetchPixels.getPixelHeight(4)),
                      getCustomFont(
                          serviceModel.categoryName ?? "", 14, textColor, 1,
                           fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(6)),
                      // Row(
                      //   children: [
                      //     getSvgImage("star.svg",
                      //         height: FetchPixels.getPixelHeight(16),
                      //         width: FetchPixels.getPixelHeight(16)),
                      //     getHorSpace(FetchPixels.getPixelWidth(6)),
                      //     getCustomFont(
                      //         modelColor.rating ?? "", 14, Colors.black, 1,
                      //         fontWeight: FontWeight.w400,
                      //        )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (serviceModel.quantity==0)
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
              )
            ],
          ),
        );
      },
    );
  }
}
