import 'package:flutter/material.dart';
import 'playpage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1)),
              height: 100,
              child: const Text(
                '골프 점수\n보조 프로그램',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              height: 30,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHome(),
                      ));
                },
                child: const Text('시작하기'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
