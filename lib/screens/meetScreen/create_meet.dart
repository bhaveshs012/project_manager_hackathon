import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/input_field.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/top_row.dart';
import 'package:random_string/random_string.dart';

class CreateMeet extends StatefulWidget {
  const CreateMeet({Key? key}) : super(key: key);

  @override
  _CreateMeetState createState() => _CreateMeetState();
}

class _CreateMeetState extends State<CreateMeet> {
  final serverText = TextEditingController();
  String roomText = "";
  final subjectText = TextEditingController();
  final nameText = TextEditingController();
  final emailText = TextEditingController();
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: padding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopRow(title: "Create a Meet", style: title1Style),
                  Container(
                    padding: padding,
                    child: kIsWeb
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.30,
                                child: meetConfig(),
                              ),
                              SizedBox(
                                  width: width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                        color: Colors.white54,
                                        child: SizedBox(
                                          width: width * 0.60 * 0.70,
                                          height: width * 0.60 * 0.70,
                                          child: JitsiMeetConferencing(
                                            extraJS: [
                                              // extraJs setup example
                                              '<script>function echo(){console.log("echo!!!")};</script>',
                                              '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                                            ],
                                          ),
                                        )),
                                  ))
                            ],
                          )
                        : meetConfig(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget meetConfig() {
    String meetCode() {
      String part1 = randomAlpha(3);
      String part2 = randomAlpha(3);
      String part3 = randomAlpha(3);
      return part1 + "-" + part2 + "-" + part3.toLowerCase();
    }

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: padding,
          child: Column(
            children: <Widget>[
              MyInputField(
                  title: "Subject Text",
                  hint: "Enter the subject of dicussion",
                  controller: subjectText),
              const SizedBox(
                height: 25.0,
              ),
              MyInputField(
                title: "Name",
                hint: "Enter your name",
                controller: nameText,
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    roomText = meetCode();
                  });

                  _joinMeeting();
                },
                child: Text("Create Meeting",
                    style: subtitlestyle.copyWith(color: Colors.white)),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20)),
                  backgroundColor: MaterialStateProperty.all(
                      Themes.primaryColor), // <-- Button color
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.blueAccent; // <-- Splash color
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room: roomText)
      ..serverURL = serverUrl
      ..subject = subjectText.text
      ..userDisplayName = nameText.text
      ..userEmail = emailText.text
      ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomText,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText.text}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
