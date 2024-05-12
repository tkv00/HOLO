import 'package:flutter/material.dart';
import 'package:holo/SignUp/SignUpPage.dart';

class SetLocationPage extends StatelessWidget {
  const SetLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder:
                    (context) => const SignUpPage())
            );
          }, child: Text(
            '가입ㄱㄱ',
          ))
        ]
        ,
      )
      ,
    );
  }
}
