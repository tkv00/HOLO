import 'package:flutter/material.dart';
import 'package:holo/theme/color.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMe)
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/images.png", // Assume this is the default image for the opponent
                width: 40,
                height: 40,
              ),
            ),
          ),

        Container(
          margin: EdgeInsets.only(
            left: isMe ? 10: 1, // Add space before the bubble when isMe is true
            right: !isMe ? 10 : 10, // Add space after the bubble when isMe is false
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
            minHeight: 50,
          ),
          decoration: BoxDecoration(
            color: isMe ? blue : gray10,
            borderRadius: isMe
                ? BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(35),
            )
                : BorderRadius.only(
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(24),
            ),
          ),

          child: Text(

            message,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
