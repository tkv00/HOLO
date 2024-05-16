import 'package:flutter/material.dart';
import 'package:holo/custom/holo_appbar.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("채팅"),
    );
  }
}
