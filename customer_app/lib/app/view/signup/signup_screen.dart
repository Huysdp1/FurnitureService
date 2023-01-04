
import 'package:customer_app/app/data/account_data.dart';
import 'package:flutter/material.dart';
import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/pref_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../routes/app_routes.dart';
import '../dialog/failure_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void finishView() {
    Constant.backToPrev(context);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool agree = false;

  bool isPass = true;
  String defCode = "";
  String defCountry = PrefData.defCountryName;

  getPrefVal() async {
    defCode = await PrefData.getDefCode();
    defCountry = await PrefData.getDefCountry();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPrefVal();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(20)),
              child: buildSignUpWidget(context),
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }

  ListView buildSignUpWidget(BuildContext context) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(26)),
        gettoolbarMenu(
          context,
          "back.svg",
          () {
            finishView();
          },
        ),
        getVerSpace(FetchPixels.getPixelHeight(22)),
        getCustomFont(
          "Đăng ký",
          24,
          Colors.black,
          1,
          fontWeight: FontWeight.w900,
        ),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont("Nhập thông tin đăng ký!", 16, Colors.black, 1,
            fontWeight: FontWeight.w400),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getDefaultTextFiledWithLabel(
          context,
          "Tên",
          false,
          nameController,
          Colors.grey,
          function: () {},
          height: FetchPixels.getPixelHeight(60),
          isEnable: false,
          withprefix: true,
          image: "user.svg",
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getDefaultTextFiledWithLabel(
          context,
          "Tài khoản",
          false,
          emailController,
          Colors.grey,
          function: () {},
          height: FetchPixels.getPixelHeight(60),
          isEnable: false,
          withprefix: true,
          image: "message.svg",
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        GestureDetector(
            onTap: () {
              Constant.sendToNextWithRes(context, Routes.selectCountryRoute,
                  fun: () {
                getPrefVal();
              });
            },
            child: getCountryTextField(context, "Số điện thoại", false,
                phoneNumberController, textColor, defCode,
                function: () {},
                height: FetchPixels.getPixelHeight(60),
                isEnable: false,
                minLines: true,
                image: defCountry)),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getDefaultTextFiledWithLabel(
            context, "Mật khẩu", false, passwordController, Colors.grey,
            function: () {},
            height: FetchPixels.getPixelHeight(60),
            isEnable: false,
            withprefix: true,
            image: "lock.svg",
            isPass: isPass,
            imageWidth: FetchPixels.getPixelWidth(19),
            imageHeight: FetchPixels.getPixelHeight(17.66),
            withSufix: true,
            suffiximage: "eye.svg", imagefunction: () {
          setState(() {
            isPass = !isPass;
          });
        }),

        getVerSpace(FetchPixels.getPixelHeight(50)),
        getButton(context, blueColor, "Đăng ký", Colors.white, () {
          AccountData().registerCustomer(nameController.text, emailController.text, passwordController.text, phoneNumberController.text).then((value) {
            if(value.statusCode==200){
              AccountData().loginCustomer(emailController.text, passwordController.text).then((value) => Constant.sendToNext(context, Routes.homeScreenRoute));
            }else{
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return FailureDialog(title: 'Đăng ký thất bại', description: value.body.toString());
                },);
            }
          }
          );
          //Constant.sendToNext(context, Routes.verifyRoute);
        }, 18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(15))),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getCustomFont(
              "Đã có tài khoản?",
              14,
              Colors.black,
              1,
              fontWeight: FontWeight.w400,
            ),
            GestureDetector(
              onTap: () {
                finishView();
              },
              child: getCustomFont(" Đăng nhập", 16, blueColor, 1,
                  fontWeight: FontWeight.w900),
            )
          ],
        )
      ],
    );
  }
}
