import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/addUser/add_user_screen.dart';
import 'package:project_manager_hackathon/screens/loginScreen/login_screen.dart';
import 'package:project_manager_hackathon/screens/loginScreen/widgets/login_button.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/bottom_navbar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Themes.primaryColor));
          } else if (snapshot.hasData) {
            final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: snapshot.data!.email)
                .snapshots();
            return StreamBuilder<QuerySnapshot>(
                stream: _userStream,
                builder: (context, AsyncSnapshot data) {
                  if (data.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Themes.primaryColor));
                  } else if (data.data.docs.length == 0) {
                    return AddUserScreen();
                  } else if (data.hasData) {
                    final List userList = [];
                    data.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      userList.add(a);
                      a['id'] = document.id;
                    }).toList();
                    return MyCustomBottomNavbar(
                      initailIndex: 0,
                      user: MyUser(
                          name: userList[0]["name"],
                          department: userList[0]["department"],
                          email: userList[0]["email"],
                          post: userList[0]["post"],
                          id: userList[0]["id"],
                          is_admin: userList[0]["is_admin"]),
                    );
                  } else {
                    return AddUserScreen();
                  }
                });
          } else if (snapshot.hasError) {
            //implement error screen
            print("error");
            return const Center(child: Text("Error"));
          } else {
            print("user not logged in");
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
