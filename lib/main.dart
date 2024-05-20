import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'golf',
      home: myhome(),
    );
  }
}

class myhome extends StatefulWidget {
  const myhome({super.key});

  @override
  State<myhome> createState() => _myhomeState();
}

class _myhomeState extends State<myhome> {
  var TeamOne = '0';
  var TeamTwo = '0';
  var TeamThree = '0';
  var TeamFour = '0';
  final List<String> point = ['0', '1', '2'];
  List<String> _assignedTeams = ['Team1','Team2','Team3','Team4'];

  void _assignTeams() {
    // 팀 분류
    List<Team> assignedTeams = []; //enum Team 형식의 리스트 생성
    //names에 길이만큼 반복하고 랜덤으로 enum value를 삽입
    for (int i = 0; i < 4; i++) {
      assignedTeams.add(Team.values[Random().nextInt(Team.values.length)]);
    }

    setState(() {
      _assignedTeams = assignedTeams.map((team) => team.toString()).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Text('플레이어1 : ${_assignedTeams[0]}, 플레이어2 : ${_assignedTeams[1]}, 플레이어3 : ${_assignedTeams[2]}, 플레이어4 : ${_assignedTeams[3]}'),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: TeamOne,
                    items: point.map(
                          (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        TeamOne = value!;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: TeamTwo,
                    items: point.map(
                          (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        TeamTwo = value!;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: TeamThree,
                    items: point.map(
                          (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        TeamThree = value!;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: TeamFour,
                    items: point.map(
                          (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        TeamFour = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
              thickness: 1,
            ),
            const SizedBox(
              width: double.infinity,
              height: 30,
              child: Text('지금까지의 경기 전적'),
            ),
            const Divider(
              height: 2,
              thickness: 1,
            ),
            Container(
              width: double.infinity,
              height: 500,
              child: ListView.separated(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('경기 결과'),
                    subtitle: Text('${games[index].p1}\n${games[index].p2}\n${games[index].p3}\n${games[index].p4}\n'),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 2,
                    color: Colors.red,
                    indent: 20,
                    endIndent: 20,
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _assignTeams();
                  setState(
                        () {
                      if(games.length!=18){
                        games.add(Game(TeamOne, TeamTwo, TeamThree, TeamFour));
                      }else{
                        games.add(Game('','','',''));
                      }
                    },

                  );
                },
                child: Text('입력')),
          ],
        ),
      ),
    );
  }
}

class Game {
  String p1;
  String p2;
  String p3;
  String p4;

  Game(this.p1, this.p2, this.p3, this.p4);
}

List<Game> games = [];

enum Team {
  team1,
  team2,
  team3,
  team4,
}