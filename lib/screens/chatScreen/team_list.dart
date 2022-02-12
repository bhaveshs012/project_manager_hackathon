import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager_hackathon/config/themes.dart';
import 'package:project_manager_hackathon/models/users.dart';
import 'package:project_manager_hackathon/screens/chatScreen/add_channel.dart';
import 'package:project_manager_hackathon/screens/chatScreen/chat_screen.dart';
import 'package:project_manager_hackathon/screens/sharedWidget/bottom_navbar.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen(
      {Key? key,
      required this.client,
      required this.channel,
      required this.user})
      : super(key: key);
  final StreamChatClient client;
  final Channel channel;
  final MyUser user;

  @override
  State<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: ((context, child) {
        return StreamChat(client: widget.client, child: child);
      }),
      home: StreamChannel(
        channel: widget.channel,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Themes.primaryColor,
            elevation: 0,
            title: Text('Team List'),
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                Get.offAll(MyCustomBottomNavbar(
                  initailIndex: 1,
                  user: widget.user,
                ));
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (() {
              Get.to(
                CreateChannelScreen(
                  user: widget.user,
                  client: widget.client,
                  channel: widget.channel,
                ),
              );
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
