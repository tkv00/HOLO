import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holo/Search/search.dart';
import 'package:holo/custom/holo_appbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _MainPageState();
}

class _MainPageState extends State<Home> {
  TextEditingController _searchController = TextEditingController();
  bool showModal = false;

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Better Life,",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Barter",
                  style: TextStyle(
                    color: Color(0xFF0077FF),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '어떤 생활 팁을 찾으시나요?',
                      // suffixIcon: SvgPicture.asset("assets/icons/search.svg",height: 5,width: 5,),
                      suffixIcon: Icon(Icons.search),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFF0077FF)),
                      ),
                    ),
                    onChanged: (value) {
                      // 검색어 변경 시 동작할 코드
                    },
                    onSubmitted: (value) {Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                      // 검색 버튼을 눌렀을 때 동작할 코드
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 80),
          Expanded(
            child: Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 13),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Text(
                      "오늘의 생활정보",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //Center(child: TodaysInformation()),
                  Center(
                    child: SizedBox(
                      height: 234,
                      width: MediaQuery.of(context).size.width,
                      child: PageView(
                        controller: PageController(viewportFraction: 0.91),
                        scrollDirection: Axis.horizontal,
                        physics: PageScrollPhysics().parent,
                        children: [
                          TodaysInformation(num: "1"),
                          TodaysInformation(num: "2"),
                          TodaysInformation(num: "3"),
                          TodaysInformation(num: "4"),
                          TodaysInformation(num: "5"),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Color(0xFF0077FF),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodaysInformation extends StatelessWidget {
  final String num;

  const TodaysInformation({
    super.key,
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 0,
              blurRadius: 5.0,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Center(child: Text('$num')),
      ),
    );
  }
}
