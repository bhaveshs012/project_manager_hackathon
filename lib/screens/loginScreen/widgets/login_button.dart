import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/controllers/google_signin.dart';
import 'package:project_manager_hackathon/landing_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CollectionReference userReference =
    //     FirebaseFirestore.instance.collection('users');
    // checkUserExists(email) async {
    //   var docs = await userReference.where("email", isEqualTo: email).get();
    //   return docs.size;
    // }

    return MaterialButton(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      padding: EdgeInsets.all(0.8.h),
      onPressed: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.googleLogIn().then((value) => Get.offAll(LandingPage()));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: ListTile(
          leading: Image.asset(
            'assets/logos/google-logo.png',
            height: 12.h,
            width: 12.w,
          ),
          title: Text('Login with Google',
              textAlign: TextAlign.center,
              style: title2Style.copyWith(color: Themes.primaryColor)),
        ),
      ),
    );
  }
}
