import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../providers/mobile_auth.dart';
import '../../../services/mobile.dart';
import '../../../utility/colors.dart';
import '../../../utility/text_styles.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  int resentOtpCounter = 60;

  decreaseOtpCounter() async {
    if (resentOtpCounter > 0) {
      setState(() {
        resentOtpCounter -= 1;
      });
      await Future.delayed(const Duration(seconds: 1), () {
        decreaseOtpCounter();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      decreaseOtpCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: 10.w,
            bottom: 3.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: EdgeInsets.all(1.5.h),
                elevation: 2,
                backgroundColor: greyShade3,
              ),
              onPressed: () {},
              child: FaIcon(
                FontAwesomeIcons.arrowLeft,
                size: 3.h,
                color: black,
              ),
            ),
          ),
          Positioned(
            right: 10.w,
            bottom: 3.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                elevation: 2,
                backgroundColor: greyShade3,
              ),
              onPressed: () {
                MobileAuthServices.verifyOtp(
                    context: context, otp: otpController.text.trim());
              },
              child: Row(
                children: [
                  Text(
                    "Next",
                    style: AppTextStyles.body14,
                  ),
                  SizedBox(width: 2.w),
                  FaIcon(
                    FontAwesomeIcons.arrowRight,
                    size: 3.h,
                    color: black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(height: 2.h),
          Text(
              "Enter the 4-digit code sent to you at ${context.read<MobileAuthProvider>().mobileNumber!}",
              style: AppTextStyles.body16),
          PinCodeTextField(
            appContext: context,
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            textStyle: AppTextStyles.body14,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor: Colors.white,
                inactiveColor: greyShade3,
                selectedFillColor: white,
                selectedColor: black,
                activeColor: black),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: transparent,
            enableActiveFill: true,
            errorAnimationController: errorController,
            controller: otpController,
            onCompleted: (v) {
              debugPrint("Completed");
            },
            onChanged: (value) {
              debugPrint(value);
              setState(() {
                // currentText = value;
              });
            },
            beforeTextPaste: (text) {
              debugPrint("Allowing to paste $text");
              return true;
            },
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.sp), color: greyShade3),
            child: Text(
              "I haven't received a code (0.$resentOtpCounter)",
              style: AppTextStyles.small10
                  .copyWith(color: resentOtpCounter > 0 ? black38 : black),
            ),
          )
        ],
      ),
    );
  }
}
