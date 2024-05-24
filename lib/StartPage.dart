import 'package:flutter/material.dart';
import 'package:holo/SignUp/SetLocationPage.dart';
import 'package:holo/SignUp/LoginPage1.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
            ),
            Image.asset(
              "assets/images/images.png",
              width: 300,
              height: 200,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '일상 그리고 BARTER',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '이웃과 함께하는 새로운 시작',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              '지금 내 동네를 선택하고 시작해보세요!',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SetLocationPage()),
                );
              },
              child: Text(
                '시작하기',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      MediaQuery
                          .of(context)
                          .size
                          .width *
                          0.9, //다른 디바이스에서의 사용 고려-> 디바이스 크기비율로 버튼 크기조정
                      MediaQuery
                          .of(context)
                          .size
                          .height * 0.07),
                  //다른 디바이스에서의 사용 고려-> 디바이스 크기비율로 버튼 크기조정
                  backgroundColor: Color(0xFF0077FF),
                  // 버튼 배경색 설정
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '이미 계정이 있나요?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const LoginPage1()),
                        );

                      },
                      child: Text(
                        '로그인',
                        style: TextStyle(color: const Color(0xFF0077FF)),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
