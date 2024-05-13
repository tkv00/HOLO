import 'dart:async';
import 'package:flutter/material.dart';
import 'package:holo/theme/color.dart';
import 'package:flutter/services.dart';
import 'package:holo/SignUp/SignUpPage1.dart';
import 'package:holo/SignUp/SignUpPage3.dart';


class SignUpPage2 extends StatefulWidget {
  final Map<String, String> userInfo;

  const SignUpPage2({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {

  int _seconds = 300;
  bool _isRunning = false;
  bool _isButtonEnabled = false;
  Timer? _timer;
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
    _codeController.addListener(_onCodeChanged);
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


  void _resetTimer() {
    setState(() {
      _seconds = 300;
      _startTimer();
    });
  }

  void _onCodeChanged() {
    if (_codeController.text.length == 4) {
      setState(() {
        _isButtonEnabled = true;
      });
    } else {
      setState(() {
        _isButtonEnabled = false;
      });
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
    String phoneNumber = widget.userInfo['phone'] ?? '번호 잘못 입력';
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
                  phoneNumber,
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
                  onPressed: _isButtonEnabled ? () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            SignUpPage3(userInfo: widget.userInfo))
                    );
                  } : null,
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
