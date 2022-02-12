import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/api.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/screens/chatScreen/team_list.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/style_button.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/top_row.dart';
import 'package:sizer/sizer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatInitScreen extends StatefulWidget {
  const ChatInitScreen({Key? key}) : super(key: key);

  @override
  State<ChatInitScreen> createState() => _ChatInitScreenState();
}

class _ChatInitScreenState extends State<ChatInitScreen> {
  late Channel channel;
  late StreamChatClient client;

  void connect() async {
    await client.connectUser(
        User(id: "bhaveshs012"), client.devToken("bhaveshs012").rawValue);
    await channel.watch();
  }

  @override
  void initState() {
    // TODO: implement initState
    client = StreamChatClient(Api.apiKey, logLevel: Level.INFO);
    channel = client
        .channel("messaging", id: "team-01", extraData: {"name": "Team-01"});
    connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopRow(
                  title: 'Live Chat',
                  style: title2Style,
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Image.asset("assets/images/chat-logo.gif"),
                ),
                SizedBox(height: 3.h),
                StyledButton(
                  title: "Join Live Chat",
                  onTap: () {
                    Get.to(() => TeamListScreen(
                          client: client,
                          channel: channel,
                        ));
                  },
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
