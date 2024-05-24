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
                Navigator.of(context).push(

                    MaterialPageRoute(
                        builder: (context) =>
                            ChatController(userPhoneNumber: phoneNumber,opponentUserPhoneNumber:"01066361710"),
                    ));
              },
              child: Text(
                '상대 번호 :01066361710',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
          ),

        ],
      ),
    );
  }
}
