import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/chatScreen/chat_init_screen.dart';
import 'package:project_manager_hackathon/screens/profileScreen/profile_screen.dart';
import 'package:project_manager_hackathon/screens/projectScreen/project_screen.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/nav_widget.dart';

class MyCustomBottomNavbar extends StatefulWidget {
  MyCustomBottomNavbar({Key? key, required this.initailIndex, required this.user})
      : super(key: key);
  final initailIndex;
  final MyUser user;
  @override
  State<MyCustomBottomNavbar> createState() => _MyCustomBottomNavbarState();
}

class _MyCustomBottomNavbarState extends State<MyCustomBottomNavbar>
    with SingleTickerProviderStateMixin {
  //controller to manage different tabs of the navbar
  late TabController _tabController;

  
    @override
  void initState() {
    super.initState();
    
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initailIndex);
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //custom made tabview used as bottom navbar
        bottomNavigationBar: CustomNavBarWidget(tabController: _tabController),
        body: TabBarView(
          controller: _tabController,
          //tab pages in correspondence to the navbar
          children: [
            ProjectScreen(user: widget.user,),
            ChatInitScreen(user: widget.user,),
            Container(),
            ProfileScreen(user: widget.user,)
          ],
        ));
  }
}