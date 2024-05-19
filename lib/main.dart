import 'package:flutter/material.dart';
import 'package:holo/StartPage.dart';


void main(){ runApp(MyApp());}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOLO',
      debugShowCheckedModeBanner: false,
      home:StartPage(),
    );
  }
}


