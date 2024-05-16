import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:holo/MainPages/Chat.dart';
import 'package:holo/MainPages/Home.dart';
import 'package:holo/MainPages/LifeInformation.dart';
import 'package:holo/MainPages/Profile.dart';
import 'package:holo/MainPages/Switching.dart';

class HoloNavigationBar extends StatefulWidget {
  const HoloNavigationBar({super.key});

  @override
  State<HoloNavigationBar> createState() => _HoloNavigationBarState();
}

class _HoloNavigationBarState extends State<HoloNavigationBar> {
  int selectedIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      label: '홈',
      icon: IconButton(
        onPressed: () {
          Get.offAll(Home());
        },
        icon: SvgPicture.asset('assets/icons/home-05.svg'),
      ),
    ),
    BottomNavigationBarItem(
      label: '생활정보',
      icon: IconButton(
        onPressed: () {
          Get.offAll(LifeInformation());
        },
        icon: SvgPicture.asset('assets/icons/annotation-info.svg'),
      ),
    ),
    BottomNavigationBarItem(
      label: '공구/교환',
      icon: IconButton(
        onPressed: () {
          Get.offAll(Switching());
        },
        icon: SvgPicture.asset('assets/icons/package.svg'),
      ),
    ),
    BottomNavigationBarItem(
      label: '채팅',
      icon: IconButton(
        onPressed: () {
          Get.offAll(Chat());
        },
        icon: SvgPicture.asset('assets/icons/message-chat.svg'),
      ),
    ),
    BottomNavigationBarItem(
      label: '나의 당근',
      icon: IconButton(
        onPressed: () {
          Get.offAll(Profile());
        },
        icon: SvgPicture.asset('assets/icons/user-02.svg'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey.withOpacity(0.8),
      selectedFontSize: 14,
      unselectedFontSize: 10,
      currentIndex: selectedIndex,
      onTap: (int index) {
        setState(() {
          selectedIndex = index;
        });
      },
      items: bottomItems,
    );
  }
}
