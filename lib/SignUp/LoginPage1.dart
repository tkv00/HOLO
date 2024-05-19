import 'package:flutter/material.dart';
import 'package:holo/theme/color.dart';
import 'package:flutter/services.dart';
import 'package:holo/SignUp/LoginPage2.dart';
import 'package:holo/controller/API_KEY.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage1 extends StatefulWidget {
  const LoginPage1({super.key});

  @override
  State<LoginPage1> createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final phoneText = _phoneController.text;
    setState(() {
      _isButtonEnabled = phoneText.length == 11;
    });
  }

  bool _validatePhoneNumber() {
    final phoneText = _phoneController.text;
    if (!RegExp(r'^010\d{8}$').hasMatch(phoneText)) {
      setState(() {
        _errorMessage = '유효한 11자리 휴대폰 번호를 입력해주세요.';
      });
      return false;
    }
    setState(() {
      _errorMessage = null;
    });
    return true;
  }

  Future<void> _LoginToPhoneNumber(String number) async {
    var checkResponse = await http.get(
        Uri.parse('$HTTP_KEY/users/check?phoneNumber=$number'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (checkResponse.statusCode == 200) {
      // 서버에서 사용자 존재 여부를 확인
      bool userExists = jsonDecode(checkResponse.body)['exists'];
      if (userExists) {
        // 사용자가 존재하면 인증번호 전송
        var sendResponse = await http.post(Uri.parse('$HTTP_KEY/message/send'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'phoneNumber': '$number'}));

        if (sendResponse.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('인증번호가 성공적으로 전송되었습니다.')));

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginPage2(phoneNumber: number)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('인증번호 전송 실패, 서버 에러입니다.')));
        }
      } else {
        // 사용자가 존재하지 않으면 오류 메시지 표시
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('등록되지 않은 번호입니다.')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('사용자 확인 실패, 서버 에러입니다.')));
    }
  }

  void _trySubmit() {
    if (_isButtonEnabled && _formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      _LoginToPhoneNumber(_phoneController.text);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('휴대폰 번호를 다시 확인해 주세요.')));
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '안녕하세요!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                '휴대폰 번호로 로그인해주세요.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                '휴대폰 번호는 안전하게 보관되며 이웃들에게 공개되지 않아요.',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: blue, width: 2.0)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  border: InputBorder.none,
                  labelText: '휴대폰 번호(-없이 숫자만 입력)',
                  fillColor: gray10,
                  filled: true,
                  errorText: _errorMessage,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11)
                ],
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _trySubmit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled ? blue : gray10,
                    // 버튼 활성화 시 색상 변경
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '인증문자 받기',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: _isButtonEnabled ? Colors.white : gray10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       '휴대폰 번호가 변경되었나요?',
              //       style: TextStyle(color: Colors.black, fontSize: 12),
              //     ),
              //     TextButton(
              //         onPressed: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(builder: (context) =>
              //                   FindAccountByEmail1())
              //           );
              //         },
              //
              //         child: Text(
              //           '이메일로 계정 찾기',
              //           style: TextStyle(
              //               fontSize: 12,
              //               color: Colors.black,
              //               decoration: TextDecoration.underline),
              //         ))
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
