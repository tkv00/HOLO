import 'package:flutter/material.dart';
import 'package:holo/custom/holo_appbar.dart';
import 'package:holo/custom/holo_navigationbar.dart';

class Switching extends StatefulWidget {
  const Switching({super.key});

  @override
  State<Switching> createState() => _SwitchState();
}

class _SwitchState extends State<Switching> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HoloAppBar(
        region: '감삼동',
        context: context,
        profile: true,
        search: true,
        setting: false,
        alarm: true,
      ),
    );
  }
}
