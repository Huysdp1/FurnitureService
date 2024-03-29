import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../data/data_file.dart';
import '../../routes/app_routes.dart';

class DateTimeScreen extends StatefulWidget {
  const DateTimeScreen({Key? key}) : super(key: key);

  @override
  State<DateTimeScreen> createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> with SingleTickerProviderStateMixin{
  final PageController _controller = PageController(
    initialPage: 0,
  );

  late TabController tabController;
  var position = 0;


  List<String> timeLists = DataFile.timeList;
  var select = 0;

  SharedPreferences? selection;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      selection = sp;
      setState(() {});
    }).then((value) { selection!.setString('selectDate', noww.toString());});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          bottomNavigationBar: doneButton(context),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  gettoolbarMenu(context, "back.svg", () {
                    Constant.backToPrev(context);
                  },
                      title: "Chọn ngày & giờ",
                      weight: FontWeight.w900,
                      istext: true,
                      fontsize: 24,
                      textColor: Colors.black),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  processTracker(),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  calendarContainer(),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  getCustomFont("Chọn giờ", 16, Colors.black, 1,
                      fontWeight: FontWeight.w900),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  timeList()
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

  DateTime noww = DateTime.now();

  Container doneButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(33)),
      child: getButton(context, blueColor, "Tiếp tục", Colors.white, () {

        Constant.sendToNext(context, Routes.orderDetailRoute);
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }
  bool checkValidTime(time){
    if(DateTime.parse(selection!.getString('selectDate')!).isAfter(noww)){
      print('1');
      return true;
    }else{
      if(int.parse(time.toString()) > noww.hour){
        print('2');
        return true;
      }else{
        print('3');
        return false;
      }
    }

  }
  Expanded timeList() {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemCount: timeLists.length,
        itemBuilder: (context, index) {
          return checkValidTime(timeLists[index].characters.take(2))
           ? GestureDetector(
            onTap: () {
              setState(() {
                select = index;
                selection!.setString("time", timeLists[index].characters.take(5).toString());
              });
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0.0, 4.0)),
                  ],
                  border: select == index
                      ? Border.all(color: blueColor, width: 2)
                      : null,
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(12))),
              child: getCustomFont(
                timeLists[index],
                16,
                select == index ? blueColor : Colors.black,
                1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ): Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white12.withOpacity(0.8),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0.0, 2.0)),
                ],
                border: null,
                borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
            child: getCustomFont(
              timeLists[index],
              16,
              Colors.black,
              1,
              fontWeight: FontWeight.w600,
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: FetchPixels.getPixelHeight(56),
            crossAxisSpacing: FetchPixels.getPixelWidth(19),
            mainAxisSpacing: FetchPixels.getPixelHeight(16)),
      ),
    );
  }

  Container calendarContainer() {
    return Container(
      height: FetchPixels.getPixelHeight(363),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0.0, 4.0)),
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(20))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(20)),
        child: SfDateRangePicker(
          monthViewSettings: const DateRangePickerMonthViewSettings(
            dayFormat: "EEE",
          ),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            selection!.setString('selectDate', DateTime.parse(args.value.toString()).toString());
            setState(() {
            });
          },
          initialSelectedDate: noww,
          selectionShape: DateRangePickerSelectionShape.circle,
          selectableDayPredicate: (date) {
            // if (date.weekday == 6 || date.weekday == 7) {
            //   return false;
            // }
            DateTime now = DateTime.now().subtract(const Duration(days: 1));
            if (!now.isBefore(date)) {
              return false;
            }
            return true;
          },
          showNavigationArrow: true,
          backgroundColor: Colors.white,
          selectionColor: blueColor,
          monthCellStyle: DateRangePickerMonthCellStyle(
              todayCellDecoration: BoxDecoration(
                  border: Border.all(color: blueColor), shape: BoxShape.circle),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: FetchPixels.getPixelHeight(14),
                fontWeight: FontWeight.w400,
              ),
              todayTextStyle: TextStyle(
                color: blueColor,
                fontSize: FetchPixels.getPixelHeight(14),
                fontWeight: FontWeight.w400,
              )),
          selectionTextStyle: TextStyle(
            color: Colors.white,
            fontSize: FetchPixels.getPixelHeight(14),
            fontWeight: FontWeight.w400,
          ),
          selectionMode: DateRangePickerSelectionMode.single,
          headerStyle: DateRangePickerHeaderStyle(
              textAlign: TextAlign.start,
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: FetchPixels.getPixelHeight(16))),
        ),
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
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
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
