import 'package:flutter/material.dart';
import 'package:holo/StartPage.dart';
import 'package:holo/MainPage.dart';

void main(){ runApp(MyApp());}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOLO',
      debugShowCheckedModeBanner: false,
      home:MainPage(),
    );
  }
}


