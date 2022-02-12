import 'package:flutter/material.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/style_button.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';


class ChatInitScreen extends StatelessWidget {
  const ChatInitScreen({Key? key, required this.client, required this.channel})
      : super(key: key);
  final StreamChatClient client;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // TopRow( 
              // ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(25.0),
                child: Image.asset("assets/meet-logo.png"),
              ),
              StyledButton(
                title: "Join Live Chat",
                onTap: () {
                  // Get.to(
                  //   // TeamListScreen(
                  //   //   client: client,
                  //   //   channel: channel,
                  //   // ),
                  // );
                },
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}