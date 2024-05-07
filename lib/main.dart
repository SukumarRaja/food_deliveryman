import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'app/providers/mobile_auth.dart';
import 'app/providers/profile.dart';
import 'app/ui/pages/auth/resgistration.dart';
import 'app/ui/pages/auth/sign_in_logic.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance
      .activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, _, __) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<MobileAuthProvider>(
                create: (_) => MobileAuthProvider()),
            ChangeNotifierProvider<ProfileProvider>(
                create: (_) => ProfileProvider())
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
              ),
              home: const SignInLogic()
              // home: const Registration()
          ),
        );
      },
    );
  }
}
