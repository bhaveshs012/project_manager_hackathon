import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/controllers/google_signin.dart';
import 'package:project_manager_hackathon/landing_page.dart';
import 'package:project_manager_hackathon/screens/introScreen/onboarding_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //created to initialize provider package
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        builder: (context, _) {
          return Sizer(builder: (context, orientation, deviceType) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: OnBoardingPage(),
            );
          });
        });
  }
}
