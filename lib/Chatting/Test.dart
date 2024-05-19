import 'package:flutter/material.dart';
import 'package:holo/Chatting/ChatController.dart';
import 'dart:convert';

class Test extends StatelessWidget {
  final String phoneNumber;
  const Test({Key?key,required this.phoneNumber}):super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Row(

        children: [
          SizedBox(height:400,),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChatController()));
              },
              child: Text(
                '상대 이름 :$phoneNumber',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ))
        ],
      ),
    );
  }
}
