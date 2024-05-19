import 'dart:async';
import 'package:flutter/material.dart';
import 'package:holo/theme/color.dart';
import 'package:flutter/services.dart';
import 'package:holo/SignUp/LoginPage1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:holo/controller/API_KEY.dart';
import 'package:holo/Chatting/Test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage2 extends StatefulWidget {
  final String phoneNumber;

  const LoginPage2({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {

  int _seconds = 180;
  bool _isRunning = false;
  bool _isButtonEnabled = false;
  Timer? _timer;
  final TextEditingController _codeController = TextEditingController();

  //자동로그인 구현 로직
  static final storage = FlutterSecureStorage();

  //초기화 메소드
  @override
  void initState() {
    super.initState();
    _startTimer();
    _codeController.addListener(_onCodeChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    })
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    String ? phoneNumber = await storage.read(key: 'phoneNumber');

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (phoneNumber != null) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Test(phoneNumber: phoneNumber)));
    } else {
      print('로그인이 필요합니다');
    }
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel(); // Ensure no multiple timers run simultaneously
    }
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isRunning = false;
        });
      }
    });
    _isRunning = true;
  }

  void _trySubmit() {
    if (_isButtonEnabled) {
      _sendVerificationCodeToServer(_codeController.text);
    }
  }

  void _resetTimer() {
    setState(() {
      _seconds = 180;
      _startTimer();
    });
  }

  void _onCodeChanged() {
    if (_codeController.text.length == 6) {
      setState(() {
        _isButtonEnabled = true;
      });
    } else {
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  Future<void> _sendVerificationCodeToServer(String code) async {
    var response = await http.post(
        Uri.parse('$HTTP_KEY/message/check'),
        headers: <String, String>{
          'Content-Type': 'application/json; charsett=UTF-8',
        },
        body: jsonEncode({
          'phoneNumber': widget.phoneNumber,
          'verificationCode': code,
        })
    );
    if (response.statusCode == 200) {
      //인증 성공 후 스토리지에 유저번호 저장(자동 로그인)
      await storage.write(key: 'phoneNumber', value: widget.phoneNumber);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('인증이 완료되었습니다.')));
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
              Test(phoneNumber: widget.phoneNumber))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('인증 번호를 다시 확인해 주세요.')));
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Properly dispose the timer to avoid memory leaks
    _codeController.dispose();
    super.dispose();
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
              Container(
                color: gray10,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  widget.phoneNumber,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                      backgroundColor: gray10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: _resetTimer,
                    child: Text(
                      '인증번호 다시 받기 (${(_seconds / 60).floor()}분 ${_seconds %
                          60}초)',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                      ),
                    )
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _codeController,
                style: const TextStyle(fontSize: 16),
                // More visible font size
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: blue,
                          width: 2.0
                      )
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10),
                  border: InputBorder.none,
                  fillColor: gray10,
                  filled: true,
                  labelText: '인증번호 입력',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4)
                ],
              ),
              const Text(
                '어떤 경우에도 타인에게 공유하지 마세요!',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
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
                  onPressed: _isButtonEnabled ? _trySubmit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled ? blue : gray30,
                    // 버튼 활성화 시 색상 변경
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '인증번호 확인',
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
