import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holo/theme/color.dart';
import 'package:holo/SignUp/SignUpPage2.dart';

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
  String userEmail = '';
  String userBirthDay = '';
  String userPhoneNumber = '';

  //유저 정보 SignUpPage2페이지로 넘기기.
  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      Map<String, String> userInfo = {
        'name': userName,
        'birthday': userBirthDay,
        'email': userEmail,
        'phone': userPhoneNumber,
        'city': widget.selectedCity
      };
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => SignUpPage2(userInfo: userInfo))
      );
    }
  }

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
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
          onChanged: _updateButtonState, // 폼이 변경될 때마다 버튼 상태 업데이트
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
                onSaved: (value) {
                  userName = value!;
                },
                key: ValueKey(1),
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
                  if (value!.isEmpty ||
                      !RegExp(r'^[가-힣]+$').hasMatch(value)) {
                    return '한글 이름을 입력해주세요.';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.disabled,
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      key: ValueKey(2),
                      onSaved: (value) {
                        userBirthDay = value!;
                      },
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
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      key: ValueKey(3),
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
                onSaved: (value) {
                  userPhoneNumber = value!;
                },
                key: ValueKey(4),
                cursorColor: Colors.black,
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
                  if (value == null || value.length != 11) {
                    return '11자리 휴대폰 번호를 입력해주세요.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // 마지막 버튼
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
                  onPressed: _isButtonEnabled
                      ? _trySubmit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _isButtonEnabled ? blue : gray10, // 버튼 활성화 시 색상 변경
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
