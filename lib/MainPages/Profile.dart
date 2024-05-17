import 'package:flutter/material.dart';
import 'package:holo/custom/holo_appbar.dart';
import 'package:holo/custom/holo_navigationbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HoloAppBar(
        region: '감삼동',
        context: context,
        profile: false,
        search: false,
        setting: true,
        alarm: false, underbar: false,
      ),
    );
  }
}
