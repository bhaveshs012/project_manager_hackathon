import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/controllers/google_signin.dart';
import 'package:project_manager_hackathon/landing_page.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.user}) : super(key: key);
  final fbUser = FirebaseAuth.instance.currentUser;
  final MyUser user;
  Future<int> _getCompletedTasks() async {
    QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection("tasks")
        .where("status", isEqualTo: "completed")
        .get();
    if (qSnap.docs.isEmpty) return 0;
    return qSnap.docs.length;
  }

  Future<int> _getOnGoingTasks() async {
    QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection("tasks")
        .where("status", isEqualTo: "ongoing")
        .get();
    if (qSnap.docs.isEmpty) return 0;
    return qSnap.docs.length;
  }

  Future<int> _getInReviewTasks() async {
    QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection("tasks")
        .where("status", isEqualTo: "in_review")
        .get();
    if (qSnap.docs.isEmpty) return 0;
    return qSnap.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          " Profile ",
          style: title2Style,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 40,
          ),
          onPressed: () => Get.offAll(
              () => MyCustomBottomNavbar(initailIndex: 0, user: user)),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.GoogleLogOut();
              Get.offAll(LandingPage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(fbUser!.photoURL.toString()),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              user.name,
              style: title1Style,
            ),
            SizedBox(height: 1.h),
            Text(
              user.post,
              style: subtitlestyle,
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Themes.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Text(
                user.department,
                style: subtitlestyle.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 3.5.h),
            Row(
              children: [
                Text(
                  " Task Status",
                  style: title2Style,
                )
              ],
            ),
            SizedBox(height: 2.h),
            FutureBuilder(
                future: Future.wait([
                  _getCompletedTasks(),
                  _getOnGoingTasks(),
                  _getInReviewTasks(),
                ]),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: Themes.primaryColor));
                  } else if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProjectStatus(
                          title: "Completed",
                          value: snapshot.data![0],
                        ),
                        ProjectStatus(
                          title: "On Going",
                          value: snapshot.data![1],
                        ),
                        ProjectStatus(
                          title: "In Review",
                          value: snapshot.data![2],
                        ),
                      ],
                    );
                  }
                  return Container();
                })
          ],
        ),
      ),
    );
  }
}

class ProjectStatus extends StatelessWidget {
  const ProjectStatus({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: subtitlestyle.copyWith(fontSize: 15.sp),
          ),
          SizedBox(height: 1.h),
          Text(
            value.toString(),
            style: subtitlestyle.copyWith(
                fontSize: 17.sp,
                color: Themes.primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
