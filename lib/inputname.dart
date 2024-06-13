import 'package:flutter/material.dart';
import 'package:golf/playpage.dart';

class InputName extends StatefulWidget {
  const InputName({super.key});

  @override
  State<InputName> createState() => _InputNameState();
}

List<String> p = [];

class _InputNameState extends State<InputName> {
  TextEditingController p1 = TextEditingController();
  TextEditingController p2 = TextEditingController();
  TextEditingController p3 = TextEditingController();
  TextEditingController p4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이름 또는 코드 입력'),
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    controller: p1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: '플레이어1',
                    ),
                  ),
                  TextField(
                    controller: p2,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: '플레이어2',
                    ),
                  ),
                  TextField(
                    controller: p3,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: '플레이어3',
                    ),
                  ),
                  TextField(
                    controller: p4,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: '플레이어4',
                    ),
                  ),
                ],
              )),
          OutlinedButton(
            onPressed: () {
              setState(() {
                p.add(p1.text);
                p.add(p2.text);
                p.add(p3.text);
                p.add(p4.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHome(),
                  ),
                );
              });
            },
            child: const Text('선택 완료'),
          ),
        ],
      ),
    );
  }
}
