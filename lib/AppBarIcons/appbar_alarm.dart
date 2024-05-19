import 'package:flutter/material.dart';

class AppBarAlarm extends StatelessWidget {
  const AppBarAlarm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.grey,
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: Center(
        child: Text('알람 설정 페이지'),
      ),
    );
  }
}
