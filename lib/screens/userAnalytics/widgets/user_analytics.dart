import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/empty_widget.dart';
import 'package:project_manager_hackathon/screens/userAnalytics/widgets/user_card.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class UserAnalytics extends StatelessWidget {
  UserAnalytics({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  Future<int> _getCompletedTasks(String id) async {
    QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("tasks")
        .where("status", isEqualTo: "completed")
        .get();
    if (qSnap.docs.isEmpty) return 0;
    return qSnap.docs.length;
  }

  Future<int> _getOnGoingTasks(String id) async {
    QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("tasks")
        .where("status", isEqualTo: "ongoing")
        .get();
    if (qSnap.docs.isEmpty) return 0;
    return qSnap.docs.length;
  }

  Future<int> _getInReviewTasks(String id) async {
    QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("tasks")
        .where("status", isEqualTo: "in_review")
        .get();
    if (qSnap.docs.isEmpty) return 0;
    return qSnap.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: padding,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _userStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: Themes.primaryColor));
                    } else if (snapshot.hasData) {
                      final List userList = [];
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map a = document.data() as Map<String, dynamic>;
                        userList.add(a);
                        a['id'] = document.id;
                      }).toList();
                      return ListView.builder(
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                              future: Future.wait([
                                _getCompletedTasks(
                                  userList[index]['id'],
                                ),
                                _getOnGoingTasks(
                                  userList[index]['id'],
                                ),
                                _getInReviewTasks(
                                  userList[index]['id'],
                                ),
                              ]),
                              builder: (context,
                                  AsyncSnapshot<List<dynamic>> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                          color: Themes.primaryColor));
                                } else if (snapshot.hasData) {
                                  return UserCard(
                                      completedTask: snapshot.data![0],
                                      onGoingTasks: snapshot.data![1],
                                      inReviewTasks: snapshot.data![2],
                                      user: MyUser(
                                          name: userList[index]["name"],
                                          department: userList[index]
                                              ["department"],
                                          email: userList[index]["email"],
                                          post: userList[index]["post"],
                                          id: userList[index]["id"],
                                          is_admin: userList[index]
                                              ["is_admin"]));
                                }
                                return EmptyWidget(message: "No Users Added!");
                              },
                            );
                          },
                          itemCount: userList.length);
                    }
                    return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
