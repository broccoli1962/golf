import 'package:flutter/material.dart';
import 'package:golf/introduce.dart';
import 'player.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

List<Player> regi = [];

class _RegisterState extends State<Register> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  void showRegisterComplete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('가입완료'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('환영합니다.'),
              ],
            ),
          ),
          insetPadding: const EdgeInsets.all(10),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Introduce(),
                    ));
              },
              child: const Text('ok'),
            ),
          ],
        );
      },
    );
  }

  void _addTextToList() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        regi.add(Player(_controller.text, _controller2.text));
      });
      _controller.clear();
      _controller2.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입 페이지'),),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              labelText: 'Input your Name',
            ),
          ),),
          Padding(padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _controller2,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Input your Code',
              ),
            ),),
          OutlinedButton(onPressed: () {
            _addTextToList();
            showRegisterComplete(context);
          },child: const Text('가입하기'),),
        ],
      ),
    );
  }
}
