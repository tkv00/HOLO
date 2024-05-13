import 'package:flutter/material.dart';
import 'package:holo/theme/color.dart';
import 'package:flutter/services.dart';
import 'package:holo/SignUp/LoginPage2.dart';
import 'package:holo/SignUp/FindAccountByEmail2.dart';

class FindAccountByEmail1 extends StatefulWidget {
  const FindAccountByEmail1({super.key});

  @override
  State<FindAccountByEmail1> createState() => _FindAccountByEmail1State();
}

class _FindAccountByEmail1State extends State<FindAccountByEmail1> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final emailText = _emailController.text;
    setState(() {
      _isButtonEnabled =
          emailText.isNotEmpty; // 버튼 활성화 조건을 텍스트 길이가 1 이상인 경우로 변경
    });
  }

  bool _validateEmail() {
    final emailText = _emailController.text;
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(
        emailText)) {
      setState(() {
        _errorMessage = '유효한 이메일 주소를 입력해주세요.';
      });
      return false;
    }
    setState(() {
      _errorMessage = null;
    });
    return true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_outlined),
          color: Colors.grey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '이메일로 계정 찾기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(

                controller: _emailController,
                cursorColor: Colors.black,
                decoration: InputDecoration(


                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: blue,
                          width: 2.0
                      )
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  border: InputBorder.none,
                  labelText: '이메일 주소',
                  fillColor: gray10,
                  filled: true,
                  errorText: _errorMessage,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
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
                    if (_validateEmail()) {
                      Navigator.push(

                          context,
                          MaterialPageRoute(builder: (context) =>
                              FindAccountByEmail2(
                                  email: _emailController.text)));
                    }
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled ? blue : gray10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '인증메일 받기',
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
