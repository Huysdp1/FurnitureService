import 'package:customer_app/app/data/service_data.dart';
import 'package:customer_app/app/models/model_service.dart';
import 'package:flutter/material.dart';
import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';
import '../../models/model_popular_service.dart';
import '../dialog/color_dialog.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  List<ModelPopularService> popularServiceLists = DataFile.popularServiceList;
  List<ServiceModel> serviceList = [];
  List<ServiceModel> selectionServices =[];
  // SharedPreferences? selection;
  var index = 0;

  getPrefData() async {
    index = await PrefData.getDefIndex();
    serviceList = await ServiceData().fetchServicesAndCategories();
    setState(() {});
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
          body: SafeArea(
            child: buildPage(edgeInsets, context, index, defSpace),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  ListView buildPage(
      EdgeInsets edgeInsets, BuildContext context, int index, double defSpace) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getPaddingWidget(
            edgeInsets,
            gettoolbarMenu(context, "back.svg", () {
              Constant.backToPrev(context);
            },
                title: "Detail",
                weight: FontWeight.w900,
                textColor: Colors.black,
                fontsize: 24,
                istext: true,
                isrightimage: true,
                rightimage: "more.svg",
                rightFunction: () {})),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getPaddingWidget(edgeInsets, productImage(index)),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getPaddingWidget(edgeInsets, productDescription(context)),
        getVerSpace(FetchPixels.getPixelHeight(29)),
        getPaddingWidget(
            edgeInsets,
            getCustomFont("Packages", 16, Colors.black, 1,
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
                  padding: EdgeInsets.only(left: FetchPixels.getPixelWidth(16)),
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

  // Expanded packageList(BuildContext context) {
  //   return Expanded(
  //     child: SingleChildScrollView(
  //       physics: const BouncingScrollPhysics(),
  //       child: ConstrainedBox(
  //         constraints: const BoxConstraints(),
  //         child: Column(
  //           children: [
  //             ListView.builder(
  //               shrinkWrap: true,
  //               physics: const BouncingScrollPhysics(),
  //               padding: EdgeInsets.zero,
  //               scrollDirection: Axis.vertical,
  //               itemCount: salonProductLists.length,
  //               itemBuilder: (context, index) {
  //                 ModelSalon modelSalon = salonProductLists[index];
  //                 return Container(
  //                   margin:
  //                       EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
  //                   width: FetchPixels.getPixelWidth(374),
  //                   padding: EdgeInsets.only(
  //                       left: FetchPixels.getPixelWidth(16),
  //                       right: FetchPixels.getPixelWidth(16),
  //                       top: FetchPixels.getPixelHeight(16),
  //                       bottom: FetchPixels.getPixelHeight(16)),
  //                   decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       boxShadow: const [
  //                         BoxShadow(
  //                             color: Colors.black12,
  //                             blurRadius: 10,
  //                             offset: Offset(0.0, 4.0)),
  //                       ],
  //                       borderRadius: BorderRadius.circular(
  //                           FetchPixels.getPixelHeight(12))),
  //                   child: Row(
  //                     children: [
  //                       packageImage(context, modelSalon),
  //                       Expanded(
  //                         child: Container(
  //                           padding: EdgeInsets.only(
  //                               left: FetchPixels.getPixelWidth(16)),
  //                           child: packageDescription(modelSalon),
  //                         ),
  //                       ),
  //                       addButton(modelSalon, context, index)
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),
  //             getVerSpace(FetchPixels.getPixelHeight(10)),
  //             totalContainer(),
  //             viewCartButton(context),
  //             getVerSpace(FetchPixels.getPixelHeight(30))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget viewCartButton(BuildContext context) {
    return getButton(context, blueColor, "Xem hóa đơn", Colors.white, () {
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
            DataFile.selectionServices = selectionServices;
            return const ColorDialog();
          });
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
        if (serviceModel.quantity == 0)
          getButton(context, Colors.transparent, "Thêm", blueColor, () {
            serviceModel.quantity = (serviceModel.quantity! + 1);
            total = total + (int.parse(serviceModel.price!) * 1);
            selectionServices.add(serviceModel);
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
                  serviceModel.quantity = (serviceModel.quantity! + 1);
                  total = total + (int.parse(serviceModel.price!) * 1);
                  // DataFile.cartList[index.toString()]!.quantity =
                  //     modelSalon.quantity;
                  setState(() {});
                },
              ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              getCustomFont(
                serviceModel.quantity.toString(),
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
                  serviceModel.quantity = (serviceModel.quantity! - 1);
                  total = total - (int.parse(serviceModel.price!) * 1);
                  if(serviceModel.quantity ==0) {
                    selectionServices.remove(serviceModel);
                  }
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
          1,
          fontWeight: FontWeight.w900,
        ),
        getVerSpace(FetchPixels.getPixelHeight(4)),
        getCustomFont(serviceModel.categoryName ?? "", 14, textColor, 1,
            fontWeight: FontWeight.w400),
        getVerSpace(FetchPixels.getPixelHeight(6)),
        getCustomFont(serviceModel.serviceDescription ?? "", 14, textColor, 1,
            fontWeight: FontWeight.w400),
        // Row(
        //   children: [
        //     getSvgImage("star.svg",
        //         height: FetchPixels.getPixelHeight(16),
        //         width: FetchPixels.getPixelHeight(16)),
        //     getHorSpace(FetchPixels.getPixelWidth(6)),
        //     // getCustomFont(
        //     //   modelSalon.rating ?? "",
        //     //   14,
        //     //   Colors.black,
        //     //   1,
        //     //   fontWeight: FontWeight.w400,
        //     // )
        //   ],
        // )
      ],
    );
  }

  Container packageImage(BuildContext context, ServiceModel model) {
    return Container(
      height: FetchPixels.getPixelHeight(104),
      width: FetchPixels.getPixelHeight(104),
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
        getCustomFont("Dịch vụ bảo trì", 24, Colors.black, 1,
            fontWeight: FontWeight.w900),
        getVerSpace(FetchPixels.getPixelHeight(17)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getSvgImage("star.svg",
                    width: FetchPixels.getPixelHeight(25),
                    height: FetchPixels.getPixelHeight(25)),
                getHorSpace(FetchPixels.getPixelWidth(10)),
                getCustomFont(
                  "4.5",
                  16,
                  Colors.black,
                  1,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            getButton(
                context, Colors.white, "10K Bookings", blueColor, () {}, 14,
                weight: FontWeight.w400,
                boxShadow: [
                  const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0.0, 4.0)),
                ],
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(20)),
                buttonHeight: FetchPixels.getPixelHeight(40),
                insetsGeometrypadding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(18)))
          ],
        ),
        getVerSpace(FetchPixels.getPixelHeight(24)),
        getMultilineCustomFont(
            "There is a distinction between a beauty salon and a hair salon and although many small treatments, beauty salons provide extended services related to skin health.",
            16,
            Colors.black,
            fontWeight: FontWeight.w400,
            txtHeight: 1.3),
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
}
