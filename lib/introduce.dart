import 'package:flutter/material.dart';
import 'inputname.dart';
import 'registerpage.dart';

class Introduce extends StatefulWidget {
  const Introduce({super.key});

  @override
  State<Introduce> createState() => _IntroduceState();
}

class _IntroduceState extends State<Introduce> {
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
                        builder: (context) => InputName(),
                      ));
                },
                child: const Text('시작하기'),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              height: 30,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Register(),
                      ));
                },
                child: const Text('회원가입'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
