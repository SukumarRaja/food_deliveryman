import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config/config.dart';
import '../../../providers/mobile_auth.dart';
import '../../../services/mobile.dart';
import '../../../utility/colors.dart';
import '../../../utility/text_styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var selectedCountry = "+91";
  TextEditingController mobileController = TextEditingController();

  bool receivedOtpButtonPressed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        receivedOtpButtonPressed = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            SizedBox(height: 3.h),
            Text(
              "Enter your mobile number",
              style: AppTextStyles.body16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (data) {
                          setState(() {
                            selectedCountry = "+${data.phoneCode}";
                          });
                          debugPrint("Selected country is ${data.displayName}");
                        });
                  },
                  child: Container(
                    height: 6.h,
                    width: 25.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.sp),
                        border: Border.all(color: grey)
                        // color: greyShade3
                        ),
                    child: Text(selectedCountry, style: AppTextStyles.body14),
                  ),
                ),
                SizedBox(
                    width: 65.w,
                    child: TextFormField(
                      controller: mobileController,
                      cursorColor: black,
                      style: AppTextStyles.textFieldTextStyle,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: greyShade3,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 2.w),
                        hintText: "Mobile number",
                        hintStyle: AppTextStyles.textFieldHintTextStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: grey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: grey)),
                      ),
                    ))
              ],
            ),
            SizedBox(height: 3.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: black,
                minimumSize: Size(90.w, 6.h),
              ),
              onPressed: () {
                setState(() {
                  receivedOtpButtonPressed = true;
                });
                context.read<MobileAuthProvider>().updateMobileNumber(
                    "$selectedCountry${mobileController.text.trim()}");
                MobileAuthServices.receiveOtp(
                    context: context,
                    mobileNo:
                        "$selectedCountry${mobileController.text.trim()}");
              },
              child: receivedOtpButtonPressed
                  ? CircularProgressIndicator(color: white)
                  : Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Next",
                            style: AppTextStyles.body16.copyWith(color: white),
                          ),
                        ),
                        Positioned(
                            right: 2.w,
                            child: Icon(Icons.arrow_forward,
                                color: white, size: 4.h))
                      ],
                    ),
            ),
            SizedBox(height: 3.w),
            Text(
              "By proceeding, you consent to get calls, Whatsapp or SMS messages, including by automated means, from ${AppConfig.appName} and its affiliates to the number provided",
              style: AppTextStyles.small12.copyWith(color: grey),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(child: Divider(color: grey)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text("or",
                      style:
                          AppTextStyles.small12.copyWith(color: Colors.grey)),
                ),
                Expanded(child: Divider(color: grey)),
              ],
            ),
            SizedBox(height: 2.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                  minimumSize: Size(90.w, 6.h),
                  elevation: 2),
              onPressed: () {},
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Continue with google",
                      style: AppTextStyles.body16.copyWith(color: black),
                    ),
                  ),
                  Positioned(
                      left: 2.w,
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        color: black,
                        size: 2.h,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
