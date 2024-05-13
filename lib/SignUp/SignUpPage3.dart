import 'package:flutter/material.dart';
import 'package:holo/theme/color.dart';
import 'package:flutter/services.dart';
import 'package:holo/SignUp/SignUpPage2.dart';

class SignUpPage3 extends StatefulWidget {
  final Map<String, String> userInfo;

  const SignUpPage3({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {
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
                  onPressed: (){},
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
