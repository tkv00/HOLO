import 'package:flutter/material.dart';

class SwitchPage extends StatelessWidget {
  const SwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(

      ),
    );
  }
}

class SwitchingItems extends StatelessWidget {
  final String url, title, region, time;

  const SwitchingItems({
    super.key,
    required this.title,
    required this.region,
    required this.url,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 0,
            blurRadius: 5.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            // 이미지의 윗쪽 모서리를 둥글게 만듦
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              url,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width / 1.2,
              height: 130,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 7),
                Text(
                  title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text('$region · $time분 전',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                  child: Text(
                    '물물교환',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
