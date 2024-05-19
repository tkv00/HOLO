import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendCityToServer(String cityName, String userId) async {
  var url = Uri.parse('http://your-backend-server.com/api/save-city');
  try {
    var response = await http.post(url, body: json.encode({
      'cityName': cityName,
      'userId': userId,
    }), headers: {
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      // 성공적으로 데이터를 전송하고 응답을 받았을 때의 처리
      print('City saved successfully');
    } else {
      // 서버 에러 처리
      print('Failed to save city');
    }
  } catch (e) {
    // 네트워크 에러 처리
    print('Error sending data to the server: $e');
  }
}
