import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    //outer container to hold the navbar
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
          child: TabBar(
            unselectedLabelColor: Colors.white,
            //indicator package for the dot indication
            indicator: DotIndicator(
              color: Themes.primaryColor.withOpacity(0.9),
              distanceFromCenter: 22,
              radius: 3,
              paintingStyle: PaintingStyle.fill,
            ),
            // BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
            //inner padding for the icons of the navbar

            controller: _tabController,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.home,
                  color: Themes.primaryColor.withOpacity(0.9),
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.chat_bubble_2_fill,
                  color: Themes.primaryColor.withOpacity(0.9),
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.video_camera_solid,
                  color: Themes.primaryColor.withOpacity(0.9),
                  size: 35,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Themes.primaryColor.withOpacity(0.9),
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}