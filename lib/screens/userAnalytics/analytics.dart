import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/screens/userAnalytics/widgets/task_analytics.dart';
import 'package:project_manager_hackathon/screens/userAnalytics/widgets/user_analytics.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Themes.primaryColor,
          bottom: TabBar(
            tabs: [
              Tab(text: "Users"),
              Tab(text: "Tasks"),
            ],
          ),
        ),
        body: TabBarView(children: [
          UserAnalytics(),
          TaskAnalysis()
        ]),
      ),
    );
  }
}
