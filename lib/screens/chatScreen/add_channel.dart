import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/chatScreen/team_list.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/input_field.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/style_button.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/top_row.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class CreateChannelScreen extends StatelessWidget {
  const CreateChannelScreen(
      {Key? key,
      required this.client,
      required this.channel,
      required this.user})
      : super(key: key);
  final StreamChatClient client;
  final Channel channel;
  final MyUser user;

  @override
  Widget build(BuildContext context) {
    String channel_name = "";

    TextEditingController _channelController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Create Chat Group", style: title2Style),
        leading: IconButton(
          color: Colors.black,
          iconSize: 35,
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Get.offAll(TeamListScreen(
              user: user,
              channel: channel,
              client: client,
            ));
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyInputField(
                  title: "Group Name",
                  hint: "Enter the Group name",
                  controller: _channelController),
              SizedBox(
                height: 25,
              ),
              StyledButton(
                title: "Submit",
                onTap: () {
                  client.createChannel('messaging',
                      channelId: _channelController.text.split(" ").join("-"),
                      channelData: {
                        'name': _channelController.text.split(" ").join("-")
                      });
                  Get.offAll(TeamListScreen(
                    client: client,
                    channel: channel,
                    user: user,
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
