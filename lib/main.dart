import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/controllers/google_signin.dart';
import 'package:project_manager_hackathon/landing_page.dart';
import 'package:project_manager_hackathon/screens/introScreen/onboarding_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    //created to initialize provider package
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        builder: (context, _) {
          return Sizer(builder: (context, orientation, deviceType) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: FutureBuilder<bool>(
                future: getFlag(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data == false) {
                    setFlag();
                    return OnBoardingPage();
                  } else {
                    return LandingPage();
                  }
                },
              ),
            );
          });
        });
  }
}

Future<bool> getFlag() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getBool("visited") ?? false;
}

setFlag() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setBool('visited', true);
}
