import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holo/theme/color.dart';
import 'package:holo/SignUp/SignUpPage2.dart';
import 'package:holo/controller/API_KEY.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage1 extends StatefulWidget {
  final String selectedCity;

  const SignUpPage1({Key? key, required this.selectedCity}) : super(key: key);

  @override
  _SignUpPage1State createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
  final _formKey = GlobalKey<FormState>();

  bool _isButtonEnabled = false;
  String userName = '';
  String userBirthDay = '';
  String userPhoneNumber = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _birthDayFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkFormValidity);
    _birthDayController.addListener(_checkFormValidity);
    _phoneNumberController.addListener(_checkFormValidity);
    _nameFocus.addListener(() => _onFocusChange(_nameFocus));
    _birthDayFocus.addListener(() => _onFocusChange(_birthDayFocus));
    _phoneFocus.addListener(() => _onFocusChange(_phoneFocus));
  }

  void _checkFormValidity() {
    bool isValid = _nameController.text.isNotEmpty &&
        _birthDayController.text.isNotEmpty &&
        _phoneNumberController.text.length == 11 &&
        _phoneNumberController.text.startsWith('010');

    if (isValid != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isValid;
      });
    }
  }

  void _onFocusChange(FocusNode focusNode) {
    if (!focusNode.hasFocus) {
      setState(() {
        _formKey.currentState?.validate();
      });
    }
  }

  Future<void> _sendPhoneNumberToServer(String number) async {
    var response = await http.post(
      Uri.parse('$HTTP_KEY/message/send'), // 서버의 주소와 엔드포인트를 정확히 입력하세요.
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'phoneNumber': '$number',
      }),
    );

    //userInfo전송
    Map<String, String> userInfo = {
      'name': _nameController.text,
      'birthday': _birthDayController.text,
      'phone': _phoneNumberController.text,
      'city': widget.selectedCity,
    };
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('인증번호가 성공적으로 전송되었습니다.')));

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SignUpPage2(userInfo: userInfo)));

  }

  void _trySubmit() {
    if (_isButtonEnabled && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _sendPhoneNumberToServer(_phoneNumberController.text);
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('휴대폰 번호를 다시 확인해 주세요.')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDayController.dispose();
    _phoneNumberController.dispose();
    _nameFocus.dispose();
    _birthDayFocus.dispose();
    _phoneFocus.dispose();
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
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
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
                '휴대폰 번호로 가입해주세요.',
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
                controller: _nameController,
                focusNode: _nameFocus,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: blue, width: 2.0)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  border: InputBorder.none,
                  labelText: '이름',
                  fillColor: gray10,
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'^[가-힣]+$').hasMatch(value)) {
                    return '한글 이름을 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (value) {
                  userName = value!;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: _birthDayController,
                      focusNode: _birthDayFocus,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: blue, width: 2.0)),
                        labelText: '주민등록번호 앞 6자리',
                        fillColor: gray10,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6)
                      ],
                      validator: (value) {
                        if (value == null || value.length != 6) {
                          return '6자리 숫자를 입력해주세요.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userBirthDay = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: blue, width: 2.0)),
                        fillColor: gray10,
                        filled: true,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1)
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Text(
                        '● ● ● ● ● ●',
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                cursorColor: Colors.black,
                controller: _phoneNumberController,
                focusNode: _phoneFocus,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  border: InputBorder.none,
                  labelText: '휴대폰 번호(-없이 숫자만 입력)',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: blue, width: 2.0)),
                  fillColor: gray10,
                  filled: true,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11)
                ],
                validator: (value) {
                  if (value == null) {
                    return '휴대폰 번호를 입력해주세요.';
                  }
                  if (!RegExp(r'^010[1-9]\d{7}$').hasMatch(value)) {
                    return '유효한 휴대폰 번호를 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (value) {
                  userPhoneNumber = value!;
                },
              ),
              SizedBox(height: 20),
              // 마지막 버튼
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
            ],
          ),
        ),
      ),
    );
  }
}
