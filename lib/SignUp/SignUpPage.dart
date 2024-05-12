import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _ssnFrontFocusNode = FocusNode();
  final FocusNode _ssnBackFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _isButtonEnabled = false;

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
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical:5),
                  border: InputBorder.none,
                  labelText: '이름',
                  fillColor: Color.fromRGBO(248, 248, 248, 1),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^[가-힣]+$').hasMatch(value)) {
                    return '한글 이름을 입력해주세요.';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: '주민등록번호 앞 6자리',
                        fillColor: Color.fromRGBO(248, 248, 248, 1),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical:5),
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

                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical:5),
                        labelText: '',
                        fillColor: Color.fromRGBO(248, 248, 248, 1),
                        filled: true,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1)
                      ],
                      validator: (value) {
                        if (value == null || value.length != 1) {
                          return '1자리 숫자를 입력해주세요.';
                        }
                        return null;
                      },
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
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical:5),
                  border: InputBorder.none,
                  labelText: '휴대폰 번호(-없이 숫자만 입력)',
                  fillColor: Color.fromRGBO(248, 248, 248, 1),
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
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')));
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled
                        ? Colors.blue
                        : Color.fromRGBO(248, 248, 248, 1), // 버튼 활성화 시 색상 변경
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
                      color: _isButtonEnabled
                          ? Colors.white
                          : Color.fromRGBO(168, 168, 168, 1),
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
