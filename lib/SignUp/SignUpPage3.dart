import 'package:flutter/material.dart';
import 'package:holo/theme/color.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:holo/SignUp/SignUpPage2.dart';
import 'dart:convert';

class SignUpPage3 extends StatefulWidget {
  final Map<String, String> userInfo;

  const SignUpPage3({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {
    TextEditingController emailController=TextEditingController();
    TextEditingController nickNameController=TextEditingController();

  Future<void> sendUserInfo() async {
    widget.userInfo['nickName']=nickNameController.text;
    widget.userInfo['email']=emailController.text;


    var response = await http.post(
      Uri.parse('http://165.229.110.162:8080/api/signup'), // 서버의 주소와 엔드포인트를 정확히 입력하세요.
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'phoneNumber':widget.userInfo['phone'],
        'userName':widget.userInfo['name'],
        'birthDate':widget.userInfo['birthday'],
        'nickName':widget.userInfo['nickName'],
        'email':widget.userInfo['email']
      }),
    );
    if (response.statusCode == 200) {
      print('회원 가입이 성공적으로 완료되었습니다.');
      // 성공 처리 로직, 예를 들어 다음 페이지로 네비게이션 하기
    } else {
      print('회원 가입 실패: ${response.body}');
      // 실패 처리 로직, 예를 들어 에러 메시지 표시
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.pop(context),
          color: Colors.grey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이웃들에게 보여줄',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '닉네임을 설정해 주세요.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '이메일 주소는 안전하게 보관되며 이웃들에게 공개되지 않아요.',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.black,
                controller: emailController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: blue, width: 2.0)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  border: InputBorder.none,
                  labelText: '이메일 주소',
                  filled: true,
                  fillColor: gray10,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nickNameController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: blue, width: 2.0)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  border: InputBorder.none,
                  labelText: '닉네임',
                  filled: true,
                  fillColor: gray10,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: sendUserInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gray30, // 버튼 활성화 시 색상 변경
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '가입 완료',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
