import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/screens/chatScreen/chat_screen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen({Key? key, required this.client, required this.channel})
      : super(key: key);

  final StreamChatClient client;
  final Channel channel;

  @override
  State<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: ((context, child) {
        return StreamChat(client: widget.client, child: child);
      }),
      home: StreamChannel(
        channel: widget.channel,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (() {
              // Get.to(CreateChannelScreen(
              //     client: widget.client, channel: widget.channel));
            }),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: ChannelsBloc(
            child: ChannelListView(
              channelWidget: ChatScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
