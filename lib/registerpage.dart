import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf/playpage.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
              height: 100,
              child: Text('골프 점수\n보조 프로그램', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
              height: 30,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => myhome(),));
                }, child: Text('시작하기'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
