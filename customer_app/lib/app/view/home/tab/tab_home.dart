import 'dart:convert';

import 'package:customer_app/app/data/service_data.dart';
import 'package:customer_app/app/models/model_address.dart';
import 'package:flutter/material.dart';

import '../../../../base/color_data.dart';
import '../../../../base/constant.dart';
import '../../../../base/pref_data.dart';
import '../../../../base/resizer/fetch_pixels.dart';
import '../../../../base/widget_utils.dart';
import '../../../data/account_data.dart';
import '../../../data/data_file.dart';
import '../../../models/model_category.dart';
import '../../../models/model_popular_service.dart';
import '../../../routes/app_routes.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  TextEditingController searchController = TextEditingController();
  List<ModelPopularService> popularServiceLists = DataFile.popularServiceList;
  List<CategoryModel> categoryList = [];
  late AddressModel addressModel;
  ValueNotifier selectedPage = ValueNotifier(0);
  Future loadCateData() async {
    await ServiceData().fetchCategories();
  }

  Future loadAddressData() async {
    await AccountData().fetchCustomerAddress();
  }

  final _controller = PageController();
  Future<AddressModel> getPrefAddressData() async {
    loadAddressData().then((value) async {
      String getModel = await PrefData.getAddressModel();
      if (getModel.isNotEmpty) {
        addressModel = AddressModel.fromList(
                json.decode(getModel).cast<Map<String, dynamic>>())
            .firstWhere((element) => element.isDefault == true);
        DataFile.defaultAddress = addressModel;
        if (mounted) {
          setState(() {});
        }
      }
    });
    return addressModel;
  }

  Future<List<CategoryModel>> getPrefData() async {
    loadCateData().then((value) async {
      String getModel = await PrefData.getCategoryModel();
      if (getModel.isNotEmpty) {
        categoryList = CategoryModel.fromList(
            json.decode(getModel).cast<Map<String, dynamic>>());
        if (mounted) {
          setState(() {});
        }
      }
    });
    return categoryList;
  }

  @override
  void initState() {
    // SharedPreferences.getInstance().then((SharedPreferences sp) {
    //   selection = sp;
    //   setState(() {});
    // });
    addressModel = DataFile.defaultAddress;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double horSpace = FetchPixels.getDefaultHorSpace(context);
    return Column(
      children: [
        getVerSpace(FetchPixels.getPixelHeight(21)),
        getPaddingWidget(
          EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getSvgImage(
                "menu.svg",
              ),
              FutureBuilder<AddressModel>(
                  future: getPrefAddressData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      if (addressModel.homeNumber != null) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              getSvgImage("location.svg"),
                              getHorSpace(FetchPixels.getPixelWidth(4)),
                              Expanded(
                                child: getMultilineCustomFont(
                                    "${addressModel.homeNumber}, ${addressModel.street}, ${addressModel.ward}, ${addressModel.district}, ${addressModel.city}",
                                    14,
                                    Colors.black,
                                    overflow: TextOverflow.fade,
                                    fontWeight: FontWeight.w400,
                                    maxLines: 4
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Row(
                        children: [
                          getSvgImage("location.svg"),
                          getHorSpace(FetchPixels.getPixelWidth(4)),
                          getCustomFont(
                            "",
                            14,
                            Colors.black,
                            1,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      );
                    }
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getSvgImage("location.svg"),
                          getHorSpace(FetchPixels.getPixelWidth(4)),
                          Expanded(
                            child: getMultilineCustomFont(
                              "${addressModel.homeNumber}, ${addressModel.street}, ${addressModel.ward}, ${addressModel.district}, ${addressModel.city}",
                              14,
                              Colors.black,
                              overflow: TextOverflow.fade,
                              fontWeight: FontWeight.w400,
                              maxLines: 4
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              GestureDetector(
                onTap: () {
                  Constant.sendToNext(context, Routes.notificationRoutes);
                },
                child: getSvgImage(
                  "notification.svg",
                ),
              ),
            ],
          ),
        ),
        getVerSpace(FetchPixels.getPixelHeight(32)),
        getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
            getSearchWidget(context, searchController, () {
              Constant.sendToNext(context, Routes.searchRoute);
            }, (value) {})),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        Expanded(
          flex: 1,
          child: ListView(
            primary: true,
            shrinkWrap: true,
            children: [
              pageView(),
              getVerSpace(FetchPixels.getPixelHeight(24)),
              getPaddingWidget(
                EdgeInsets.symmetric(horizontal: horSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getCustomFont("Loại dịch vụ", 20, Colors.black, 1,
                        fontWeight: FontWeight.w900),
                    GestureDetector(
                      onTap: () {
                        Constant.sendToNext(context, Routes.categoryRoute);
                      },
                      child: getCustomFont(
                        "Tất cả",
                        14,
                        blueColor,
                        1,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(16)),
              FutureBuilder(
                  future: getPrefData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                        height: FetchPixels.getPixelHeight(132),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryList.length,
                          primary: false,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            CategoryModel modelCategory = categoryList[index];
                            return GestureDetector(
                              onTap: () {
                                PrefData.setDefIndex(categoryList[index].categoryId!);
                                Constant.sendToNext(
                                    context, Routes.detailRoute);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: (index == 0) ? horSpace : 0,
                                    right: FetchPixels.getPixelWidth(20),
                                    bottom: FetchPixels.getPixelHeight(28)),
                                padding: EdgeInsets.only(
                                    top: FetchPixels.getPixelHeight(16),
                                    bottom: FetchPixels.getPixelHeight(12)),
                                width: FetchPixels.getPixelWidth(91),
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
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getSvgImage(
                                        DataFile.categoryImage[index] ?? "",
                                        width: FetchPixels.getPixelHeight(44),
                                        height: FetchPixels.getPixelHeight(44)),
                                    getVerSpace(FetchPixels.getPixelHeight(10)),
                                    getCustomFont(
                                        modelCategory.categoryName ?? "",
                                        14,
                                        Colors.black,
                                        1,
                                        fontWeight: FontWeight.w400),
                                  ],
                                ),
                              ),
                            );
                          },
                        ));
                  }),
              getPaddingWidget(
                EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont(
                      "Nổi bật",
                      20,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w900,
                    ),
                    getCustomFont("Xem tất cả", 14, blueColor, 1,
                        fontWeight: FontWeight.w600)
                  ],
                ),
              ),
              getVerSpace(FetchPixels.getPixelHeight(16)),
              SizedBox(
                height: FetchPixels.getPixelHeight(215),
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: popularServiceLists.length,
                  itemBuilder: (context, index) {
                    ModelPopularService modelPopularService =
                        popularServiceLists[index];
                    return GestureDetector(
                      onTap: () {
                        PrefData.setDefIndex(index);
                        Constant.sendToNext(context, Routes.detailRoute);
                      },
                      child: Container(
                        width: FetchPixels.getPixelWidth(177),
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
                        padding: EdgeInsets.only(
                            left: FetchPixels.getPixelWidth(10),
                            right: FetchPixels.getPixelWidth(10),
                            top: FetchPixels.getPixelHeight(10),
                            bottom: FetchPixels.getPixelHeight(10)),
                        margin: EdgeInsets.only(
                            left: (index % 2 == 0) ? horSpace : 0,
                            bottom: FetchPixels.getPixelHeight(24),
                            right: FetchPixels.getPixelWidth(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                                tag: popularServiceLists[index],
                                child: getCircularImage(
                                    context,
                                    double.infinity,
                                    FetchPixels.getPixelHeight(115),
                                    FetchPixels.getPixelHeight(12),
                                    modelPopularService.image ?? "",
                                    boxFit: BoxFit.cover)),
                            // getAssetImage(
                            //     modelPopularService.image ?? "",
                            //     double.infinity,
                            //     FetchPixels.getPixelHeight(115),boxFit: BoxFit.fill),
                            // ),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Align(
                                alignment: Alignment.topLeft,
                                child: getCustomFont(
                                  modelPopularService.name ?? "",
                                  14,
                                  Colors.black,
                                  1,
                                  fontWeight: FontWeight.w900,
                                )),
                            getVerSpace(FetchPixels.getPixelHeight(4)),
                            Align(
                                alignment: Alignment.topLeft,
                                child: getCustomFont(
                                    modelPopularService.category ?? "",
                                    14,
                                    Colors.black,
                                    1,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Column pageView() {
    return Column(
      children: [
        SizedBox(
          height: FetchPixels.getPixelHeight(184),
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (value) {
              selectedPage.value = value;
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: FetchPixels.getPixelWidth(374),
                    decoration: BoxDecoration(
                        color: const Color(0xFFD0DDFF),
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(20)),
                        image: getDecorationAssetImage(context, "maskgroup.png",
                            fit: BoxFit.fill)),
                    alignment: Alignment.center,
                  ),
                  Positioned(
                      child: SizedBox(
                    height: FetchPixels.getPixelHeight(180),
                    width: FetchPixels.getPixelWidth(374),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getPaddingWidget(
                          EdgeInsets.only(
                              left: FetchPixels.getPixelWidth(20),
                              top: FetchPixels.getPixelHeight(20),
                              bottom: FetchPixels.getPixelHeight(20)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: FetchPixels.getPixelHeight(130),
                                  child: getMultilineCustomFont(
                                      "Wall Painting Service", 20, Colors.black,
                                      fontWeight: FontWeight.w900,
                                      txtHeight: 1.3)),
                              // getVerSpace(FetchPixels.getPixelHeight(6)),
                              getCustomFont(
                                "Make your wall stylish",
                                14,
                                Colors.black,
                                1,
                                fontWeight: FontWeight.w400,
                              ),
                              // getVerSpace(FetchPixels.getPixelHeight(16)),
                              getButton(context, blueColor, "Book Now",
                                  Colors.white, () {}, 14,
                                  weight: FontWeight.w600,
                                  buttonWidth: FetchPixels.getPixelWidth(108),
                                  borderRadius: BorderRadius.circular(
                                      FetchPixels.getPixelHeight(12)),
                                  insetsGeometrypadding: EdgeInsets.symmetric(
                                      vertical:
                                          FetchPixels.getPixelHeight(12))),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                right: FetchPixels.getPixelWidth(21)),
                            height: FetchPixels.getPixelHeight(175),
                            width: FetchPixels.getPixelHeight(142),
                            color: Colors.transparent,
                            child: getAssetImage(
                                "washer.png",
                                FetchPixels.getPixelHeight(142),
                                FetchPixels.getPixelHeight(175)))
                      ],
                    ),
                  ))
                ],
              );
            },
          ),
        ),
        getVerSpace(FetchPixels.getPixelHeight(14)),
        ValueListenableBuilder(
          valueListenable: selectedPage,
          builder: (context, value, child) {
            return Container(
              height: FetchPixels.getPixelHeight(8),
              width: FetchPixels.getPixelWidth(44),
              alignment: Alignment.center,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return getPaddingWidget(
                    EdgeInsets.only(right: FetchPixels.getPixelWidth(10)),
                    getAssetImage(
                      "dot.png",
                      FetchPixels.getPixelHeight(8),
                      FetchPixels.getPixelHeight(8),
                      color: selectedPage.value == index
                          ? blueColor
                          : blueColor.withOpacity(0.2),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
