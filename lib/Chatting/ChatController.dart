import 'package:flutter/material.dart';
import 'package:holo/theme/color.dart';
import 'package:holo/Chatting/ChatBubble.dart';
import 'package:holo/controller/API_KEY.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController extends StatefulWidget {
  const ChatController({super.key});

  @override
  State<ChatController> createState() => _ChatControllerState();
}

class _ChatControllerState extends State<ChatController> {
  late final WebSocketChannel channel;
  List<String> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 웹소켓 서버 연결 설정
    channel = IOWebSocketChannel.connect(
        Uri.parse(''));//여기다가 서버 주소넣어라


    // 웹소켓에서 메시지 수신 리스닝
    channel.stream.listen((message) {
      setState(() {
        _messages.add(message);
      });
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    }, onDone: () {
      // 연결 종료 처리
    }, onError: (error) {
      print('WebSocket error: $error');
    });
  }

  void _sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      // 웹소켓 서버로 메시지 전송
      channel.sink.add(_textEditingController.text);
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: gray30, width: 1)),
        title: Text('상대방 이름',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.pop(context),
          color: Colors.grey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset("assets/images/images.png",
                      width: 50, height: 50),
                ),
                const SizedBox(width: 20), // 이미지와 텍스트 사이의 간격
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽으로 정렬
                  children: [
                    Row(
                      children: [
                        Text('교환중 ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 12)),
                        Text('미니 청소기 어쩌구',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 10), // 텍스트 줄 간격
                    Row(
                      children: [
                        Text('교환 희망 물품 ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 12)),
                        Text('면도기 어쩌구',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(height: 1, color: gray30),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(left: 10),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  bool isMe = index % 2 == 0;
                  return ChatBubble(message: _messages[index], isMe: isMe);
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              decoration: BoxDecoration(
                  color: gray10,
                  border: Border(top: BorderSide(color: gray30, width: 1.0))),
              child: Row(
                children: <Widget>[
                  IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: '메시지 보내기',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                      onSubmitted: (text)=>_sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send_sharp),
                    onPressed: _sendMessage,
                    color: Colors.black.withOpacity(1.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
