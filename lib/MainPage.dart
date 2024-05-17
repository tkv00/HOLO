import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:holo/MainPages/Chat.dart';
import 'package:holo/MainPages/Home.dart';
import 'package:holo/MainPages/LifeInformation.dart';
import 'package:holo/MainPages/Profile.dart';
import 'package:holo/MainPages/Switching.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    Home(),
    LifeInformation(),
    Switching(),
    Chat(),
    Profile(),
  ];

  final List<SvgPicture> _icons = [
    SvgPicture.asset('assets/icons/home-05.svg', color: Color(0xFF0077FF)),
    SvgPicture.asset('assets/icons/annotation-info.svg', color: Colors.black),
    SvgPicture.asset('assets/icons/package-search.svg', color: Colors.black),
    SvgPicture.asset('assets/icons/message-chat-square.svg',
        color: Colors.black),
    SvgPicture.asset('assets/icons/user-02.svg', color: Colors.black),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // 선택된 아이콘의 색상을 변경
      for (int i = 0; i < _icons.length; i++) {
        _icons[i] = SvgPicture.asset(
          'assets/icons/icon-$i.svg',
          color: index == i ? Color(0xFF0077FF) : Colors.black,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF0077FF),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: _icons[0], label: '홈'),
          BottomNavigationBarItem(icon: _icons[1], label: '생활정보'),
          BottomNavigationBarItem(icon: _icons[2], label: '공구/교환'),
          BottomNavigationBarItem(icon: _icons[3], label: '채팅'),
          BottomNavigationBarItem(icon: _icons[4], label: '나의 당근'),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}
