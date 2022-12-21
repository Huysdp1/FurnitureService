import 'package:customer_app/app/models/model_order.dart';
import 'package:customer_app/base/resizer/fetch_pixels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/models/model_booking.dart';
import 'color_data.dart';
import 'constant.dart';

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

Widget getAssetImage(String image, double width, double height,
    {Color? color, BoxFit boxFit = BoxFit.contain}) {
  return Image.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
    scale: FetchPixels.getScale(),
  );
}

Widget getAssetImageCircle(
    BuildContext context, String image, double width, double height,
    {Color? color, BoxFit boxFit = BoxFit.contain}) {
  return Image.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
    scale: FetchPixels.getScale(),
  );
}

Widget getSvgImage(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return SvgPicture.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}

Widget getCircularImage(BuildContext context, double width, double height,
    double radius, String img,
    {BoxFit boxFit = BoxFit.contain}) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: getAssetImageCircle(context, img, width, height, boxFit: boxFit),
    ),
  );
}

Widget getPaddingWidget(EdgeInsets edgeInsets, Widget widget) {
  return Padding(
    padding: edgeInsets,
    child: widget,
  );
}

GestureDetector buildBookingListItem(ModelBooking modelBooking,
    BuildContext context, int index, Function function, Function funDelete) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      height: FetchPixels.getPixelHeight(171),
      margin: EdgeInsets.only(
          bottom: FetchPixels.getPixelHeight(20),
          left: FetchPixels.getDefaultHorSpace(context),
          right: FetchPixels.getDefaultHorSpace(context)),
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
        children: [
          // Expanded(child:
          //   Row(
          //     children: [
          //       Container(
          //         height: FetchPixels.getPixelHeight(91),
          //         width: FetchPixels.getPixelHeight(91),
          //         decoration: BoxDecoration(
          //           image: getDecorationAssetImage(
          //               context, modelBooking.image ?? ""),
          //         ),
          //       ),
          //       Expanded(child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           getCustomFont(
          //               modelBooking.name ?? "", 16, Colors.black, 1,
          //               fontWeight: FontWeight.w900),
          //           getVerSpace(FetchPixels.getPixelHeight(6)),
          //           getCustomFont(
          //             modelBooking.date ?? "",
          //             14,
          //             textColor,
          //             1,
          //             fontWeight: FontWeight.w400,
          //           ),
          //           getVerSpace(FetchPixels.getPixelHeight(6)),
          //           Row(
          //             children: [
          //               getSvgImage("star.svg",
          //                   height: FetchPixels.getPixelHeight(16),
          //                   width: FetchPixels.getPixelHeight(16)),
          //               getHorSpace(FetchPixels.getPixelWidth(6)),
          //               getCustomFont(
          //                   modelBooking.rating ?? "", 14, Colors.black, 1,
          //                   fontWeight: FontWeight.w400),
          //             ],
          //           )
          //         ],
          //       ),flex: 1,)
          //     ],
          //   )
          //   ,flex: 1,),

          Expanded(
            flex: 1,
            child: Row(
              children: [
                Container(
                  height: FetchPixels.getPixelHeight(91),
                  width: FetchPixels.getPixelHeight(91),
                  decoration: BoxDecoration(
                    image: getDecorationAssetImage(
                        context, modelBooking.image ?? "",
                        fit: BoxFit.cover),
                  ),
                ),
                getHorSpace(FetchPixels.getPixelWidth(16)),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: getHorSpace(0),
                      ),
                      getCustomFont(
                          modelBooking.name ?? "", 16, Colors.black, 1,
                          fontWeight: FontWeight.w900),
                      getVerSpace(FetchPixels.getPixelHeight(12)),
                      getCustomFont(
                        modelBooking.date ?? "",
                        14,
                        textColor,
                        1,
                        fontWeight: FontWeight.w400,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(12)),
                      Row(
                        children: [
                          getSvgImage("star.svg",
                              height: FetchPixels.getPixelHeight(16),
                              width: FetchPixels.getPixelHeight(16)),
                          getHorSpace(FetchPixels.getPixelWidth(6)),
                          getCustomFont(
                              modelBooking.rating ?? "", 14, Colors.black, 1,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        child: getHorSpace(0),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        funDelete();
                      },
                      child: getSvgImage("trash.svg",
                          width: FetchPixels.getPixelHeight(20),
                          height: FetchPixels.getPixelHeight(20)),
                    ),
                    getPaddingWidget(
                        EdgeInsets.only(bottom: FetchPixels.getPixelHeight(10)),
                        getCustomFont(
                          "\$${modelBooking.price}",
                          16,
                          blueColor,
                          1,
                          fontWeight: FontWeight.w900,
                        ))
                  ],
                )
              ],
            ),
          ),
          getVerSpace(FetchPixels.getPixelHeight(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  getAssetImage("dot.png", FetchPixels.getPixelHeight(8),
                      FetchPixels.getPixelHeight(8)),
                  getHorSpace(FetchPixels.getPixelWidth(8)),
                  getCustomFont(modelBooking.owner ?? "", 14, textColor, 1,
                      fontWeight: FontWeight.w400),
                ],
              ),
              Wrap(
                children: [
                  getButton(
                      context,
                      Color(modelBooking.bgColor!.toInt()),
                      modelBooking.tag ?? "",
                      modelBooking.textColor!,
                      () {},
                      16,
                      weight: FontWeight.w600,
                      borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(37)),
                      insetsGeometrypadding: EdgeInsets.symmetric(
                          vertical: FetchPixels.getPixelHeight(6),
                          horizontal: FetchPixels.getPixelWidth(12)))
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget widgetOrderStatus(context, String status) {
  int color = 0xFFEEFCF0;
  Color theme = success;
  if (status == 'Đã tiếp nhận') {
    color = 0xFFEEFCF0;
    theme = success;
  }
  if (status == 'Chờ khảo sát') {
    color = 0xFFF0F8FF;
    theme = completed;
  }
  if (status == 'Đang thực hiện') {
    color = 0xFFFFF3F3;
    theme = error;
  }
  if (status == 'Chờ thanh toán') {
    color = 0xFFF0F8FF;
    theme = completed;
  }
  if (status == 'Huỷ') {
    color = 0xFFFFF3F3;
    theme = error;
  }
  return Wrap(
    children: [
      getButton(context, Color(color.toInt()), status, theme, () {}, 16,
          weight: FontWeight.w600,
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(37)),
          insetsGeometrypadding: EdgeInsets.symmetric(
              vertical: FetchPixels.getPixelHeight(6),
              horizontal: FetchPixels.getPixelWidth(12)))
    ],
  );
}

GestureDetector buildOrderListItem(OrderModel modelBooking,
    BuildContext context, int index, Function function, Function funDelete) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      height: FetchPixels.getPixelHeight(171),
      margin: EdgeInsets.only(
          bottom: FetchPixels.getPixelHeight(20),
          left: FetchPixels.getDefaultHorSpace(context),
          right: FetchPixels.getDefaultHorSpace(context)),
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
        children: [
          // Expanded(child:
          //   Row(
          //     children: [
          //       Container(
          //         height: FetchPixels.getPixelHeight(91),
          //         width: FetchPixels.getPixelHeight(91),
          //         decoration: BoxDecoration(
          //           image: getDecorationAssetImage(
          //               context, modelBooking.image ?? ""),
          //         ),
          //       ),
          //       Expanded(child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           getCustomFont(
          //               modelBooking.name ?? "", 16, Colors.black, 1,
          //               fontWeight: FontWeight.w900),
          //           getVerSpace(FetchPixels.getPixelHeight(6)),
          //           getCustomFont(
          //             modelBooking.date ?? "",
          //             14,
          //             textColor,
          //             1,
          //             fontWeight: FontWeight.w400,
          //           ),
          //           getVerSpace(FetchPixels.getPixelHeight(6)),
          //           Row(
          //             children: [
          //               getSvgImage("star.svg",
          //                   height: FetchPixels.getPixelHeight(16),
          //                   width: FetchPixels.getPixelHeight(16)),
          //               getHorSpace(FetchPixels.getPixelWidth(6)),
          //               getCustomFont(
          //                   modelBooking.rating ?? "", 14, Colors.black, 1,
          //                   fontWeight: FontWeight.w400),
          //             ],
          //           )
          //         ],
          //       ),flex: 1,)
          //     ],
          //   )
          //   ,flex: 1,),

          Expanded(
            flex: 1,
            child: Row(
              children: [
                Container(
                  height: FetchPixels.getPixelHeight(91),
                  width: FetchPixels.getPixelHeight(91),
                  decoration: BoxDecoration(
                    image: getDecorationAssetImage(
                        context, modelBooking.orderImages!.first ?? "",
                        fit: BoxFit.cover),
                  ),
                ),
                getHorSpace(FetchPixels.getPixelWidth(16)),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: getHorSpace(0),
                      ),
                      getCustomFont(
                          modelBooking.address ?? "", 16, Colors.black, 1,
                          fontWeight: FontWeight.w900),
                      getVerSpace(FetchPixels.getPixelHeight(12)),
                      getCustomFont(
                        '${modelBooking.implementationTime}, ${Constant.parseDateNoUTC(modelBooking.implementationDate, false)}',
                        14,
                        textColor,
                        1,
                        fontWeight: FontWeight.w400,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(12)),
                      // Row(
                      //   children: [
                      //     getSvgImage("star.svg",
                      //         height: FetchPixels.getPixelHeight(16),
                      //         width: FetchPixels.getPixelHeight(16)),
                      //     getHorSpace(FetchPixels.getPixelWidth(6)),
                      //     getCustomFont(
                      //         modelBooking. ?? "", 14, Colors.black, 1,
                      //         fontWeight: FontWeight.w400),
                      //   ],
                      // ),
                      Expanded(
                        flex: 1,
                        child: getHorSpace(0),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        funDelete();
                      },
                      child: getSvgImage("trash.svg",
                          width: FetchPixels.getPixelHeight(20),
                          height: FetchPixels.getPixelHeight(20)),
                    ),
                    getPaddingWidget(
                        EdgeInsets.only(bottom: FetchPixels.getPixelHeight(10)),
                        getCustomFont(
                          "\${Constant.showTextMoney(modelBooking.totalPrice)}đ",
                          16,
                          blueColor,
                          1,
                          fontWeight: FontWeight.w900,
                        ))
                  ],
                )
              ],
            ),
          ),
          getVerSpace(FetchPixels.getPixelHeight(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  getAssetImage("dot.png", FetchPixels.getPixelHeight(8),
                      FetchPixels.getPixelHeight(8)),
                  getHorSpace(FetchPixels.getPixelWidth(8)),
                  getCustomFont(
                      modelBooking.description ?? "", 14, textColor, 1,
                      fontWeight: FontWeight.w400),
                ],
              ),
              widgetOrderStatus(context, modelBooking.status.toString()),
            ],
          )
        ],
      ),
    ),
  );
}

DecorationImage getDecorationAssetImage(BuildContext buildContext, String image,
    {BoxFit fit = BoxFit.contain}) {
  return DecorationImage(
      image: AssetImage((Constant.assetImagePath) + image),
      fit: fit,
      scale: FetchPixels.getScale());
}

Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
    textScaleFactor: FetchPixels.getTextScale(),
  );
}

Widget getMultilineCustomFont(String text, double fontSize, Color fontColor,
    {String fontFamily = Constant.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight = 1.0}) {
  return Text(
    text,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    textAlign: textAlign,
    textScaleFactor: FetchPixels.getTextScale(),
  );
}

BoxDecoration getButtonDecoration(Color bgColor,
    {BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow> shadow = const [],
    DecorationImage? image}) {
  return BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius,
      border: border,
      boxShadow: shadow,
      image: image);
}

Widget getButton(BuildContext context, Color bgColor, String text,
    Color textColor, Function function, double fontsize,
    {bool isBorder = false,
    EdgeInsetsGeometry? insetsGeometry,
    borderColor = Colors.transparent,
    FontWeight weight = FontWeight.bold,
    bool isIcon = false,
    String? image,
    Color? imageColor,
    double? imageWidth,
    double? imageHeight,
    bool smallFont = false,
    double? buttonHeight,
    double? buttonWidth,
    List<BoxShadow> boxShadow = const [],
    EdgeInsetsGeometry? insetsGeometrypadding,
    BorderRadius? borderRadius,
    double? borderWidth}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      padding: insetsGeometrypadding,
      width: buttonWidth,
      height: buttonHeight,
      decoration: getButtonDecoration(
        bgColor,
        borderRadius: borderRadius,
        shadow: boxShadow,
        border: (isBorder)
            ? Border.all(color: borderColor, width: borderWidth!)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (isIcon) ? getSvgImage(image!) : getHorSpace(0),
          (isIcon)
              ? getHorSpace(FetchPixels.getPixelWidth(10))
              : getHorSpace(0),
          getCustomFont(
            text,
            fontsize,
            textColor,
            1,
            textAlign: TextAlign.center,
            fontWeight: weight,
          )
        ],
      ),
    ),
  );
}

Widget getButtonWithIcon(BuildContext context, Color bgColor, String text,
    Color textColor, Function function, double fontsize,
    {bool isBorder = false,
    EdgeInsetsGeometry? insetsGeometry,
    borderColor = Colors.transparent,
    FontWeight weight = FontWeight.bold,
    bool prefixIcon = false,
    bool sufixIcon = false,
    String? prefixImage,
    String? suffixImage,
    Color? imageColor,
    double? imageWidth,
    double? imageHeight,
    bool smallFont = false,
    double? buttonHeight,
    double? buttonWidth,
    List<BoxShadow> boxShadow = const [],
    EdgeInsetsGeometry? insetsGeometrypadding,
    BorderRadius? borderRadius,
    double? borderWidth,
    String fontFamily = "Regular"}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      margin: insetsGeometry,
      padding: insetsGeometrypadding,
      width: buttonWidth,
      height: buttonHeight,
      decoration: getButtonDecoration(
        bgColor,
        borderRadius: borderRadius,
        shadow: boxShadow,
        border: (isBorder)
            ? Border.all(color: borderColor, width: borderWidth!)
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              getHorSpace(FetchPixels.getPixelWidth(18)),
              (prefixIcon) ? getSvgImage(prefixImage!) : getHorSpace(0),
              (prefixIcon)
                  ? getHorSpace(FetchPixels.getPixelWidth(12))
                  : getHorSpace(0),
              getCustomFont(text, fontsize, textColor, 1,
                  textAlign: TextAlign.center,
                  fontWeight: weight,
                  fontFamily: fontFamily)
            ],
          ),
          Row(
            children: [
              (sufixIcon) ? getSvgImage(suffixImage!) : getHorSpace(0),
              (sufixIcon)
                  ? getHorSpace(FetchPixels.getPixelWidth(18))
                  : getHorSpace(0),
            ],
          )
        ],
      ),
    ),
  );
}

Widget getDefaultTextFiledWithLabel(
    BuildContext context,
    String s,
    bool isValidated,
    TextEditingController textEditingController,
    Color fontColor,
    {bool withprefix = false,
    bool withSufix = false,
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isPass = false,
    bool isEnable = true,
    double? height,
    double? imageHeight,
    double? imageWidth,
    String? image,
    String? suffiximage,
    required Function function,
    Function? imagefunction,
    AlignmentGeometry alignmentGeometry = Alignment.centerLeft}) {
  FocusNode myFocusNode = FocusNode();
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew =
          mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());

      return AbsorbPointer(
        absorbing: isEnable,
        child: Container(
          height: height,
          margin: margin,
          alignment: alignmentGeometry,
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
          child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: MediaQuery(
                data: mqDataNew,
                child: Row(
                  children: [
                    (!withprefix)
                        ? getHorSpace(FetchPixels.getPixelWidth(16))
                        : Padding(
                            padding: EdgeInsets.only(
                                right: FetchPixels.getPixelWidth(12),
                                left: FetchPixels.getPixelWidth(18)),
                            child: getSvgImage(image!,
                                height: FetchPixels.getPixelHeight(24),
                                width: FetchPixels.getPixelHeight(24)),
                          ),
                    Expanded(
                      child: TextField(
                        maxLines: (minLines) ? null : 1,
                        controller: textEditingController,
                        obscuringCharacter: "*",
                        autofocus: false,
                        focusNode: myFocusNode,
                        obscureText: isPass,
                        showCursor: false,
                        onTap: () {
                          function();
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: FetchPixels.getPixelHeight(16),
                        ),
                        onChanged: (_) => setState(() => ''),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: s,
                            errorText: isValidated
                                ? Constant.validateCharacters(
                                    textEditingController.text, s)
                                : null,
                            hintStyle: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: FetchPixels.getPixelHeight(16),
                            )),
                      ),
                    ),
                    (!withSufix)
                        ? getHorSpace(FetchPixels.getPixelWidth(16))
                        : Padding(
                            padding: EdgeInsets.only(
                                right: FetchPixels.getPixelWidth(18),
                                left: FetchPixels.getPixelWidth(12)),
                            child: InkWell(
                              onTap: () {
                                if (imagefunction != null) {
                                  imagefunction();
                                }
                              },
                              child: getSvgImage(suffiximage!,
                                  height: FetchPixels.getPixelHeight(24),
                                  width: FetchPixels.getPixelHeight(24)),
                            ),
                          ),
                  ],
                ),
              )),
        ),
      );
    },
  );
}

Widget getCardDateTextField(
  BuildContext context,
  String s,
  TextEditingController textEditingController,
  Color fontColor, {
  bool minLines = false,
  EdgeInsetsGeometry margin = EdgeInsets.zero,
  bool isPass = false,
  bool isEnable = true,
  double? height,
  required Function function,
}) {
  FocusNode myFocusNode = FocusNode();
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew =
          mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());

      return AbsorbPointer(
        absorbing: isEnable,
        child: Container(
          height: height,
          margin: margin,
          alignment: Alignment.centerLeft,
          padding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(18)),
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
          child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: MediaQuery(
                data: mqDataNew,
                child: TextField(
                  maxLines: (minLines) ? null : 1,
                  controller: textEditingController,
                  obscuringCharacter: "*",
                  autofocus: false,
                  focusNode: myFocusNode,
                  obscureText: isPass,
                  showCursor: false,
                  onTap: () {
                    function();
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: FetchPixels.getPixelHeight(16),
                  ),
                  // textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: s,
                      hintStyle: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: FetchPixels.getPixelHeight(16),
                      )),
                ),
              )),
        ),
      );
    },
  );
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

Widget getCardEditText(BuildContext context, String s,
    TextEditingController textEditingController, Color fontColor,
    {bool withprefix = false,
    bool withSufix = false,
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isPass = false,
    bool isEnable = true,
    double? height,
    double? imageHeight,
    double? imageWidth,
    String? image,
    String? suffiximage,
    required Function function,
    Function? imagefunction}) {
  FocusNode myFocusNode = FocusNode();
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew =
          mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());

      return AbsorbPointer(
        absorbing: isEnable,
        child: Container(
          height: height,
          margin: margin,
          alignment: Alignment.centerLeft,
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
          child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  setState(() {
                    myFocusNode.canRequestFocus = true;
                  });
                } else {
                  setState(() {
                    myFocusNode.canRequestFocus = false;
                  });
                }
              },
              child: MediaQuery(
                data: mqDataNew,
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberFormatter(),
                  ],
                  maxLines: (minLines) ? null : 1,
                  controller: textEditingController,
                  maxLength: 19,
                  obscuringCharacter: "*",
                  autofocus: false,
                  focusNode: myFocusNode,
                  obscureText: isPass,
                  showCursor: false,
                  onTap: () {
                    function();
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: FetchPixels.getPixelHeight(16),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      counterText: "",
                      prefixIcon: (withprefix)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right: FetchPixels.getPixelWidth(12),
                                  left: FetchPixels.getPixelWidth(18)),
                              child: getSvgImage(image!,
                                  height: FetchPixels.getPixelHeight(24),
                                  width: FetchPixels.getPixelHeight(24)),
                            )
                          : null,
                      suffixIcon: (withSufix)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  right: FetchPixels.getPixelWidth(18),
                                  left: FetchPixels.getPixelWidth(12)),
                              child: InkWell(
                                onTap: () {
                                  imagefunction!();
                                },
                                child: getSvgImage(suffiximage!,
                                    height: FetchPixels.getPixelHeight(24),
                                    width: FetchPixels.getPixelHeight(24)),
                              ),
                            )
                          : null,
                      border: InputBorder.none,
                      hintText: s,
                      hintStyle: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: FetchPixels.getPixelHeight(16),
                      )),
                ),
              )),
        ),
      );
    },
  );
}

Widget getCountryTextField(BuildContext context, String s, bool isValidated,
    TextEditingController textEditingController, Color fontColor, String code,
    {bool withprefix = false,
    bool withSufix = false,
    bool minLines = false,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isPass = false,
    bool isEnable = true,
    double? height,
    String? image,
    required Function function,
    Function? imagefunction}) {
  FocusNode myFocusNode = FocusNode();
  return StatefulBuilder(
    builder: (context, setState) {
      final mqData = MediaQuery.of(context);
      final mqDataNew =
          mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());

      return AbsorbPointer(
        absorbing: isEnable,
        child: Container(
          height: height,
          margin: margin,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getHorSpace(FetchPixels.getPixelWidth(18)),
              getAssetImage(image!, FetchPixels.getPixelHeight(24),
                  FetchPixels.getPixelHeight(24)),
              getHorSpace(FetchPixels.getPixelWidth(12)),
              getCustomFont(
                code,
                16,
                Colors.black,
                1,
                fontWeight: FontWeight.w400,
              ),
              getSvgImage("down_arrow.svg"),
              getHorSpace(FetchPixels.getPixelWidth(20)),
              Expanded(
                child: MediaQuery(
                  data: mqDataNew,
                  child: TextField(
                    maxLines: (minLines) ? null : 1,
                    controller: textEditingController,
                    obscuringCharacter: "*",
                    autofocus: false,
                    focusNode: myFocusNode,
                    obscureText: isPass,
                    showCursor: false,
                    onTap: () {
                      function();
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: FetchPixels.getPixelHeight(16),
                    ),
                    onChanged: (_) => setState(() => ''),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: s,
                        errorText: isValidated
                            ? Constant.validateCharacters(
                                textEditingController.text, s)
                            : null,
                        hintStyle: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: FetchPixels.getPixelHeight(16),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget getSvgImageWithSize(
    BuildContext context, String image, double width, double height,
    {Color? color, BoxFit fit = BoxFit.fill}) {
  return SvgPicture.asset(
    Constant.assetImagePath + image,
    color: color,
    width: width,
    height: height,
    fit: fit,
  );
}

Widget getSearchWidget(
    BuildContext context,
    TextEditingController searchController,
    Function filterClick,
    ValueChanged<String> onChanged,
    {bool withPrefix = true,
    ValueChanged<String>? onSubmit}) {
  double height = FetchPixels.getPixelHeight(60);

  final mqData = MediaQuery.of(context);
  final mqDataNew =
      mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());

  double iconSize = FetchPixels.getPixelHeight(24);

  return Container(
    width: double.infinity,
    height: height,
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
        ],
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
    child: Row(
      children: [
        getHorSpace(FetchPixels.getPixelWidth(16)),
        getSvgImageWithSize(context, "search.svg", iconSize, iconSize),
        getHorSpace(FetchPixels.getPixelWidth(18)),
        Expanded(
          flex: 1,
          child: MediaQuery(
              data: mqDataNew,
              child: IntrinsicHeight(
                child: TextField(
                  onTap: () {
                    filterClick();
                  },
                  controller: searchController,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "Search...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontFamily: Constant.fontsFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: textColor)),
                  style: const TextStyle(
                      fontFamily: Constant.fontsFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              )),
        ),

        // Padding(
        //   padding: EdgeInsets.only(
        //       right: FetchPixels.getPixelWidth(18),
        //       left: FetchPixels.getPixelWidth(19)),
        //   child: getSvgImage("search.svg",
        //       height: FetchPixels.getPixelHeight(24),
        //       width: FetchPixels.getPixelHeight(24)),
        // ),
        // Expanded(
        //   child: MediaQuery(
        //       data: mqDataNew,
        //       child: IntrinsicHeight(
        //         child: TextField(
        //           onTap: () {
        //             filterClick();
        //           },
        //           onSubmitted: onSubmit,
        //           textInputAction: TextInputAction.search,
        //           controller: searchController,
        //           onChanged: onChanged,
        //           decoration: InputDecoration(
        //               // contentPadding: EdgeInsets.zero,
        //               // isCollapsed: true,
        //               isDense: true,
        //               hintText: "Search...",
        //               border: InputBorder.none,
        //               hintStyle: TextStyle(
        //                   color: textColor,
        //                   fontWeight: FontWeight.w400,
        //                   fontSize: 16,
        //                   )),
        //           style: const TextStyle(
        //               color: Colors.black,
        //               fontWeight: FontWeight.w400,
        //               fontSize: 16,
        //               ),
        //           textAlign: TextAlign.start,
        //           maxLines: 1,
        //         ),
        //       )),
        //   flex: 1,
        // ),
        getHorSpace(FetchPixels.getPixelWidth(3)),
      ],
    ),
  );
}

Widget gettoolbarMenu(BuildContext context, String image, Function function,
    {bool istext = false,
    double? fontsize,
    String? title,
    Color? textColor,
    FontWeight? weight,
    String fontFamily = "",
    bool isrightimage = false,
    String? rightimage,
    Function? rightFunction}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
          onTap: () {
            function();
          },
          child: getSvgImage(image,
              height: FetchPixels.getPixelHeight(24),
              width: FetchPixels.getPixelHeight(24))),
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: (istext)
              ? getCustomFont(title!, fontsize!, textColor!, 1,
                  fontWeight: weight!, fontFamily: fontFamily)
              : null,
        ),
      ),
      (isrightimage)
          ? InkWell(
              onTap: () {
                rightFunction!();
              },
              child: getSvgImage(rightimage!,
                  height: FetchPixels.getPixelHeight(24),
                  width: FetchPixels.getPixelHeight(24)))
          : Container(),
    ],
  );
}

Widget withoutleftIconToolbar(BuildContext context,
    {bool istext = false,
    double? fontsize,
    String? title,
    Color? textColor,
    FontWeight? weight,
    String fontFamily = "",
    bool isrightimage = false,
    String? rightimage,
    Function? rightFunction}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: (istext)
              ? getCustomFont(title!, fontsize!, textColor!, 1,
                  fontWeight: weight!, fontFamily: fontFamily)
              : null,
        ),
      ),
      (isrightimage)
          ? InkWell(
              onTap: () {
                if (rightFunction != null) {
                  rightFunction();
                }
              },
              child: getSvgImage(rightimage!,
                  height: FetchPixels.getPixelHeight(24),
                  width: FetchPixels.getPixelHeight(24)))
          : Container(),
    ],
  );
}

Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

Widget getDivider(Color color, double height, double thickness) {
  return Divider(
    color: color,
    height: height,
    thickness: thickness,
  );
}
