import 'dart:math';
import 'package:flutter/material.dart';


class choice extends StatefulWidget {
  @override
  _choiceState createState() => _choiceState();
}

class _choiceState extends State<choice> {
  final _nameControllers = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];
  final _teamNames = ['팀 1', '팀 2', '팀 3', '팀 4'];
  List<String> _assignedTeams = [];

  void _assignTeams() {
    // 팀 분류 알고리즘 구현
    //names list 에다가 _nameControllers의 textfield로 받은 내용들을 공백을 제거해서 삽입
    List<String> names = [];
    for (var controller in _nameControllers) {
      String name = controller.text.trim();
      if (name.isNotEmpty) {
        names.add(name);
      }
    }

    if (names.isEmpty) {
      return;
    }

    // 팀 분류
    List<Team> assignedTeams = []; //enum Team 형식의 리스트 생성
    //names에 길이만큼 반복하고 랜덤으로 enum value를 삽입
    for (int i = 0; i < names.length; i++) {
      assignedTeams.add(Team.values[Random().nextInt(Team.values.length)]);
    }

    setState(() {
      _assignedTeams = assignedTeams.map((team) => team.toString()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('팀 분류 화면'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (int i = 0; i < _nameControllers.length; i++)
              TextField(
                controller: _nameControllers[i],
                decoration: InputDecoration(labelText: '이름 ${i + 1}'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _assignTeams,
              child: Text('팀 분류'),
            ),
            SizedBox(height: 20),
            for (int i = 0; i < _assignedTeams.length; i++)
              Text('${_assignedTeams[i]}: ${_nameControllers[i].text}')
          ],
        ),
      ),
    );
  }
}

enum Team {
  team1,
  team2,
  team3,
  team4,
}