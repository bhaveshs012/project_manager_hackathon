import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/controllers/google_signin.dart';
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
      color: Themes.primaryColor,
      padding: EdgeInsets.all(0.8.h),
      onPressed: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.googleLogIn();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: ListTile(
            title: Text('Login with Google',
                textAlign: TextAlign.center, style: title1Style)),
      ),
    );
  }
}