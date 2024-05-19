import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:holo/Switch/buyPage.dart';
import 'package:holo/Switch/switchPage.dart';
import 'package:holo/custom/holo_appbar.dart';
import 'package:holo/custom/holo_navigationbar.dart';

class Switching extends StatefulWidget {
  const Switching({super.key});

  @override
  State<Switching> createState() => _SwitchState();
}

class _SwitchState extends State<Switching> {
  bool switching = true, buying = false;

  void SelectSwitching() {
    setState(() {
      switching = true;
      buying = false;
    });
  }

  void SelectBuying() {
    setState(() {
      switching = false;
      buying = true;
    });
  }

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
        underbar: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: SelectSwitching,
                child: Container(
                  decoration: BoxDecoration(
                    border: switching
                        ? Border(
                            bottom: BorderSide(
                              color: Color(0xFF0077FF), // 밑줄 색상
                              width: 3, // 밑줄 두께
                            ),
                          )
                        : null,
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  child: Center(
                    child: Text(
                      "물물교환",
                      style: TextStyle(
                        color: switching ? Color(0xFF0077FF) : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: SelectBuying,
                child: Container(
                  decoration: BoxDecoration(
                    border: buying
                        ? Border(
                            bottom: BorderSide(
                              color: Color(0xFF0077FF), // 밑줄 색상
                              width: 3, // 밑줄 두께
                            ),
                          )
                        : null,
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  child: Center(
                    child: Text(
                      "공동구매",
                      style: TextStyle(
                        color: buying ? Color(0xFF0077FF) : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //아래로 스크롤 가능
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // 밑줄 색상
                      width: 1, // 밑줄 두께
                    ),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SwitchingCategory(url: '1', name: '생활가전'),
                            SwitchingCategory(url: '5', name: '의류'),
                          ],
                        ),
                        Column(
                          children: [
                            SwitchingCategory(url: '2', name: '디지털기기'),
                            SwitchingCategory(url: '6', name: '도서'),
                          ],
                        ),
                        Column(
                          children: [
                            SwitchingCategory(url: '3', name: '가구/인테리어'),
                            SwitchingCategory(url: '7', name: '식품'),
                          ],
                        ),
                        Column(
                          children: [
                            SwitchingCategory(url: '4', name: '생활/주방'),
                            SwitchingCategory(url: '8', name: '뷰티/미용'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  child: switching ? SwitchPage() : BuyPage(),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

//그림이랑 label 위젯화 시켜놓음
class SwitchingCategory extends StatelessWidget {
  final String url, name;

  const SwitchingCategory({
    super.key,
    required this.url,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          Image.asset(
            'assets/images/$url.png',
            width: 47,
            height: 62,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
