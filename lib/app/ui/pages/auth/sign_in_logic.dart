import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../services/mobile.dart';

class SignInLogic extends StatefulWidget {
  const SignInLogic({super.key});

  @override
  State<SignInLogic> createState() => _SignInLogicState();
}

class _SignInLogicState extends State<SignInLogic> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MobileAuthServices.checkAuthentication(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: const Image(
            fit: BoxFit.fill,
            image:
                AssetImage("assets/images/splashScreenImage/SplashScreen.png")),
      ),
    );
  }
}
