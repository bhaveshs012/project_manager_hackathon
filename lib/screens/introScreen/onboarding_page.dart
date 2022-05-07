import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/screens/introScreen/widgets/button_widgets.dart';
import 'package:project_manager_hackathon/screens/loginScreen/login_screen.dart';
import 'package:sizer/sizer.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              titleWidget: Text(
                'A better way to manage your projects',
                style: title1Style,
                textAlign: TextAlign.center,
              ),
              bodyWidget: Text(
                'With Project Manager, you can easily manage your projects and tasks. You can also create your own projects and tasks',
                style: subtitlestyle.copyWith(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              image: buildImage('assets/images/on_board/onboard_1.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              titleWidget: Text(
                'Simple and easy to use',
                style: title1Style,
                textAlign: TextAlign.center,
              ),
              bodyWidget: Text(
                'We have designed a very simple and easy to use interface. You can create your projects and tasks in a few clicks',
                style: subtitlestyle.copyWith(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              image: buildImage('assets/images/on_board/onboard_2.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              titleWidget: Text(
                'Inetgrated Video Conferencing',
                style: title1Style,
                textAlign: TextAlign.center,
              ),
              bodyWidget: Text(
                'We have integrated video conferencing with our application. You can easily share your screen with your team members',
                style: subtitlestyle.copyWith(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              image: buildImage('assets/images/on_board/onboard_3.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              titleWidget: Text(
                'Live Status Tracker',
                style: title1Style,
                textAlign: TextAlign.center,
              ),
              bodyWidget: Text(
                'We have integrated live status tracker with our application. You can see the status of your tasks and projects',
                style: subtitlestyle.copyWith(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              footer: ButtonWidget(
                text: 'Get Started',
                onClicked: () {
                  Get.to(LoginScreen());
                },
              ),
              image: buildImage('assets/images/on_board/onboard_4.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done:
              Text('Done', style: subtitlestyle.copyWith(color: Colors.black)),
          onDone: () => Get.to(LoginScreen()),
          showSkipButton: true,
          skip: Center(
              child: Text('Skip',
                  style: subtitlestyle.copyWith(color: Colors.black))),
          onSkip: () => Get.to(LoginScreen()),
          next: Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Colors.white,
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );
  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        activeColor: Themes.primaryColor,
        color: Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
