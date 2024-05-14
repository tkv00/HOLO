import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:holo/SignUp/SignUpPage1.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:holo/theme/color.dart'; // color.dart에서 적절한 색상 정보를 가져오는 것으로 가정합니다.
import 'package:geolocator/geolocator.dart';
import 'package:holo/controller/apiKeyManager.dart';

class SetLocationPage extends StatefulWidget {
  const SetLocationPage({super.key});

  @override
  State<SetLocationPage> createState() => _SetLocationPageState();
}

class _SetLocationPageState extends State<SetLocationPage> {
  double lat = 0.0;
  double lng = 0.0;
  final String _googleApiKey =
      'AIzaSyBL_cYaMI6JGTvO4tYclHfIgnXgS31wFjA'; // API 키를 안전하게 관리
  bool addressFetched = false;

// 현재 위치 정보 가져오기
  Future<void> getLocation() async {
    if (!addressFetched) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          lat = position.latitude;
          lng = position.longitude;
          currentAddress = await getPlaceAddress(lat, lng);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: const Text('현재 위치를 확인해주세요.'),
                content: Text(currentAddress),
                actions: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignUpPage1(selectedCity: currentAddress)));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                      ),
                      child: const Text(
                        '네',
                        style: TextStyle(color: Colors.white),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: const Text(
                        '아니요',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              );
            },
          );
        } catch (e) {
          print('위치를 가져오는 데 실패했습니다: $e');
        }
      } else {
        print('위치 권한이 허용되지 않았습니다.');
      }
    }
  }

// 위도와 경도를 기반으로 주소를 가져오는 함수

  Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&language=ko&key=AIzaSyBL_cYaMI6JGTvO4tYclHfIgnXgS31wFjA';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      if (decodedResponse['results'].isEmpty) {
        return 'No address found for the given coordinates.';
      }
      String fullAddress = decodedResponse['results'][0]['formatted_address'];
      return fullAddress.replaceFirst('대한민국 ', ''); // "대한민국" 제거
    } else {
      throw Exception(
          'Failed to load address with status code: ${response.statusCode}');
    }
  }

  List<dynamic> majorCities = [];
  List<dynamic> filteredCities = [];
  List<dynamic> minorCities = [];
  String selectedMajorCity = '';
  String searchText = '';
  String currentAddress = ''; //현재위치 찾기로 찾은 주소

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
                    borderSide: BorderSide(color: blue, width: 2.0)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: getLocation,
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
                        MaterialPageRoute(
                            builder: (context) => SignUpPage1(
                                selectedCity: filteredCities[index]
                                    ['addr_name'])));
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
