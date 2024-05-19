import 'package:flutter/material.dart';
import 'package:holo/theme/color.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController=TextEditingController();
  final FocusNode _phoneFocusNode=FocusNode();
  bool _isButtonEnabled=false;
  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhoneNumber);
  }
  void _validatePhoneNumber() {
    final phoneText = _phoneController.text;
    setState(() {
      _isButtonEnabled = RegExp(r'^\d{11}$').hasMatch(phoneText);
    });
  }
  void _handleFocusChange() {
    if (!_phoneFocusNode.hasFocus) {
      // 포커스가 필드에서 벗어날 때 유효성 검사를 수행합니다.
      _validatePhoneNumber();
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

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('안녕하세요!', style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                ),
                const Text('휴대폰 번호로 로그인해주세요.', style: TextStyle(
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
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    border: InputBorder.none,
                    labelText: '휴대폰 번호(-없이 숫자만 입력)',
                    fillColor: gray10,
                    filled: true,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11)
                  ],
                  validator: (value) {
                    if (value != null && value.length == 11 && !RegExp(r'^\d{11}$').hasMatch(value)) {
                      return '유효한 11자리 휴대폰 번호를 입력해주세요.';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    // 텍스트 입력이 완료되면 폼 필드의 유효성을 강제로 검사합니다.
                    Form.of(context)?.validate();
                  },
                ),
                SizedBox(height: 20,),
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
                    onPressed: _isButtonEnabled ? () {} : null,
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
                          color: _isButtonEnabled? Colors.white:gray10,
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
