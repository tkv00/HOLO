import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:holo/SignUp/SignUpPage1.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:holo/theme/color.dart'; // color.dart에서 적절한 색상 정보를 가져오는 것으로 가정합니다.

class SetLocationPage extends StatefulWidget {
  const SetLocationPage({super.key});

  @override
  State<SetLocationPage> createState() => _SetLocationPageState();
}

class _SetLocationPageState extends State<SetLocationPage> {
  List<dynamic> majorCities = [];
  List<dynamic> filteredCities = [];
  List<dynamic> minorCities = [];
  String selectedMajorCity = '';
  String searchText = '';

  @override
  void initState() {
    super.initState();
    loadMajorCities();
  }

  Future<void> loadMajorCities() async {
    try {
      String data =
      await rootBundle.loadString('data/address_data/address_major.json');
      var jsonData = json.decode(data)['result'] as List;
      setState(() {
        majorCities = jsonData;
        filteredCities = jsonData; // 초기 리스트 설정
      });
    } catch (e) {
      print("Failed to load major cities: $e");
    }
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCities = majorCities;
      });
    } else {
      List<dynamic> dummyListData = majorCities.where((city) {
        return city['addr_name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
      setState(() {
        filteredCities = dummyListData;
      });
    }
  }

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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (value) => filterSearchResults(value),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: blue,
                        width: 2.0
                    )
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                border: InputBorder.none,
                hintText: '동명(읍,면)으로 검색(ex.삼성동)',
                filled: true,
                fillColor: gray10,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {},
              child: Text(
                '현재위치로 찾기',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(20.0),
            child: Text(
              '근처 동네',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${filteredCities[index]['addr_name']}'),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            SignUpPage1(
                                selectedCity: filteredCities[index]['addr_name']))
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
