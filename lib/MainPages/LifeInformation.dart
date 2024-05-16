import 'package:flutter/material.dart';
import 'package:holo/custom/holo_appbar.dart';
import 'package:holo/custom/holo_navigationbar.dart';

class LifeInformation extends StatefulWidget {
  const LifeInformation({super.key});

  @override
  State<LifeInformation> createState() => _LifeInformationState();
}

class _LifeInformationState extends State<LifeInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HoloAppBar(
        region: '감삼동',
        context: context,
        profile: false,
        search: false,
        setting: false,
        alarm: true,
      ),
    );
  }
}
