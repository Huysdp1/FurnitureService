
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../dialog/verify_dialog.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  void finishView() {
    Constant.backToPrev(context);
  }
  @override
  void initState() {
    super.initState();
    verify();
  }
  TextEditingController smsCode = TextEditingController();
  late String _verificationCode;
     verify() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+84 399 390 110',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              showDialog(
                  barrierDismissible: false,
                  builder: (context) {
                    return const VerifyDialog();
                  },
                  context: context);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode.text);
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            smsCode.text = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));

  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: FetchPixels.getPixelWidth(79),
      height: FetchPixels.getPixelHeight(68),
      textStyle: TextStyle(
          fontSize: FetchPixels.getPixelHeight(24),
          color: blueColor,
          fontWeight: FontWeight.w900,
          ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0.0, 4.0)),
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15))),
    );

    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
            child: Container(
              padding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
              child: Column(
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
                  getCustomFont("Xác thực tài khoản", 24, Colors.black, 1,
                      fontWeight: FontWeight.w900, ),
                  getVerSpace(FetchPixels.getPixelHeight(10)),
                  getCustomFont("Nhập mã xác thực được gửi qua số điện thoại!", 16,
                      Colors.black, 1,
                       fontWeight: FontWeight.w400),
                  getVerSpace(FetchPixels.getPixelHeight(42)),
                  Pinput(
                    defaultPinTheme: defaultPinTheme,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    length: 6,
                    showCursor: true,
                    onCompleted: (pin){
                      try {
                        smsCode.text = pin;
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {

                      });
                    },
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(50)),
                  getButton(context, blueColor, "Xác thực", Colors.white, () async {
                    await FirebaseAuth.instance.signInWithCredential(
                        PhoneAuthProvider.credential(
                            verificationId: _verificationCode, smsCode: smsCode.text))
                        .then((value) async{
                      if (value.user != null) {

                        showDialog(
                            barrierDismissible: false,
                            builder: (context) {
                              return const VerifyDialog();
                            },
                            context: context);

                      }
                    });

                  }, 18,
                      weight: FontWeight.w600,
                      buttonHeight: FetchPixels.getPixelHeight(60),
                      borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(15))),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getCustomFont("Chưa nhận được mã?", 14, Colors.black, 1,
                           fontWeight: FontWeight.w400),
                      GestureDetector(
                        onTap: () {
                          verify();
                        },
                        child: getCustomFont(" Gửi lại", 16, blueColor, 1,
                          fontWeight: FontWeight.w900, ),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }
}
