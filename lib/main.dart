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
  final List<String> point = ['0', '1', '2', '3', '4'];
  List<String> _assignedTeams = ['Team.team1','Team.team2','Team.team3','Team.team4'];

  List<int> playersScore = [0, 0, 0, 0];  // 현황 및 18홀 결과를 위한 4명의 점수
  int player1 = 0;  // 타수 계산용 변수입니다.
  int player2 = 0;
  int player3 = 0;
  int player4 = 0;
  List<int> teamScore = [0, 0, 0, 0]; // 경기당 각 팀의 점수를 저장할 리스트입니다.
  List<String> record = []; // 전체 경기의 승리 팀을 저장할 리스트입니다.

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

  void scoreInput(){
    // 플레이어가 들어간 팀에 따라 타수를 계산합니다.
    // 계산된 타수는 teamScore 리스트에 들어갑니다.
    List<int> teamOneScore = [];
    List<int> teamTwoScore = [];
    List<int> teamThreeScore = [];
    List<int> teamFourScore = [];

    int? index = null;  // 2:1:1에서 1명인 팀 중 한개를 정해 그 팀 점수로 더함
    for(int i = 0; i < 4; i++){
      if(_assignedTeams[i] == 'Team.team1'){
        teamOneScore.add(i == 0 ? player1 : i == 1 ? player2 : i == 2 ? player3 : player4);
      }else if(_assignedTeams[i] == 'Team.team2'){
        teamTwoScore.add(i == 0 ? player1 : i == 1 ? player2 : i == 2 ? player3 : player4);
      }else if(_assignedTeams[i] == 'Team.team3'){
        teamThreeScore.add(i == 0 ? player1 : i == 1 ? player2 : i == 2 ? player3 : player4);
      }else if(_assignedTeams[i] == 'Team.team4'){
        teamFourScore.add(i == 0 ? player1 : i == 1 ? player2 : i == 2 ? player3 : player4);
      }
    }

    if(teamOneScore.length >= 2){ // 팀 인원이 2명 이상
      teamOneScore.sort();
      teamScore[0] = teamOneScore[0] + teamOneScore[1];
    }else if(
        teamOneScore.length == 1  // 각 팀에 한 명
        && teamTwoScore.length == 1
        && teamThreeScore.length == 1
        && teamFourScore.length == 1
    ){
      teamScore[0] = teamOneScore[0];
    }else if(teamOneScore.length == 1 &&
        !(teamTwoScore.length == 1
            || teamThreeScore.length == 1
            || teamFourScore.length == 1)){ // 팀 인원이 1명이고 나머지 팀 중 1명인 팀이 없을 때
      teamScore[0] = teamOneScore[0] * 2;
    }else if(teamOneScore.length == 1){  // 1명인 팀 2개를 더하기 위한 코드
      index ??= 0;
      teamScore[index] += teamOneScore[0];
    }

    if(teamTwoScore.length >= 2){ // 여기서 부터 아래는 위의 반복입니다.
      teamTwoScore.sort();
      teamScore[1] = teamTwoScore[0] + teamTwoScore[1];
    }else if(
    teamOneScore.length == 1
        && teamTwoScore.length == 1
        && teamThreeScore.length == 1
        && teamFourScore.length == 1
    ){
      teamScore[1] = teamTwoScore[0];
    }else if(teamTwoScore.length == 1 &&
        !(teamOneScore.length == 1
            || teamThreeScore.length == 1
            || teamFourScore.length == 1)){
      teamScore[1] = teamTwoScore[0] * 2;
    }else if(teamTwoScore.length == 1){
      index ??= 1;
      teamScore[index] += teamTwoScore[0];
    }

    if(teamThreeScore.length >= 2){
      teamThreeScore.sort();
      teamScore[2] = teamThreeScore[0] + teamThreeScore[1];
    }else if(
    teamOneScore.length == 1
        && teamTwoScore.length == 1
        && teamThreeScore.length == 1
        && teamFourScore.length == 1
    ){
      teamScore[2] = teamThreeScore[0];
    }else if(teamThreeScore.length == 1 &&
        !(teamTwoScore.length == 1
            || teamOneScore.length == 1
            || teamFourScore.length == 1)){
      teamScore[2] = teamThreeScore[0] * 2;
    }else if(teamThreeScore.length == 1){
      index ??= 2;
      teamScore[index] += teamThreeScore[0];
    }

    if(teamFourScore.length >= 2){
      teamFourScore.sort();
      teamScore[3] = teamFourScore[0] + teamFourScore[1];
    }else if(
    teamOneScore.length == 1
        && teamTwoScore.length == 1
        && teamThreeScore.length == 1
        && teamFourScore.length == 1
    ){
      teamScore[3] = teamFourScore[0];
    }else if(teamFourScore.length == 1 &&
        !(teamTwoScore.length == 1
            || teamThreeScore.length == 1
            || teamOneScore.length == 1)){
      teamScore[3] = teamFourScore[0] * 2;
    }else if(teamFourScore.length == 1){
      index ??= 3;
      teamScore[index] += teamFourScore[0];
    }
  }

  String winningTeam(int one, int two, int three, int four){
    // 각 팀의 타수로 이긴 팀 찾기
    Map scores =
      {
        'team1':one,
        'team2':two,
        'team3':three,
        'team4':four
      };
    int count = 0;
    int min = 11; // 5홀에서 더블파로 10타가 최소 타수입니다.
    String winningTeam = '';

    for(int i = 0; i < 4; i++){
      // 0타는 팀 분류시 플레이어가 1명도 들어가지 않은 팀입니다.
      if(scores['team${i + 1}'] == 0){
        continue; // 스킵
      }

      if(min > scores['team${i + 1}']){
        min = scores['team${i + 1}'];
        winningTeam = '팀${i == 0 ? '1' : i == 1 ? '2' : i == 2 ? '3' : '4'} 승리';
      }
    }

    for(int i = 0; i < 4; i++){
      if(min == scores['team${i + 1}']){
        count++;
      }
    }

    if(count > 1){
      winningTeam = '비겼습니다.';
    }

    return winningTeam;
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
                        player1 = int.parse(value);
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
                        player2 = int.parse(value);
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
                        player3 = int.parse(value);
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
                        player4 = int.parse(value);
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
                    subtitle: Text(
                        '플레이어1 : ${games[index].p1}             팀1 : ${games[index].scores[0]}             결과 : ${record[index]}\n'
                        '플레이어2 : ${games[index].p2}             팀2 : ${games[index].scores[1]}\n'
                        '플레이어3 : ${games[index].p3}             팀3 : ${games[index].scores[2]}\n'
                        '플레이어4 : ${games[index].p4}             팀4 : ${games[index].scores[3]}\n'
                    ),
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
                        games.add(Game(TeamOne, TeamTwo, TeamThree, TeamFour, teamScore));
                        playersScore[0] += int.parse(TeamOne);
                        playersScore[1] += int.parse(TeamTwo);
                        playersScore[2] += int.parse(TeamThree);
                        playersScore[3] += int.parse(TeamFour);
                        scoreInput();
                        record.add(winningTeam(teamScore[0], teamScore[1], teamScore[2], teamScore[3]));
                        teamScore = [0, 0, 0, 0];
                      }else{
                        games.add(Game('','','','', []));
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
  List<int> scores = [0, 0, 0, 0];  // 게임 별로 팀 타수 저장

  Game(this.p1, this.p2, this.p3, this.p4, this.scores);
}

List<Game> games = [];

enum Team {
  team1,
  team2,
  team3,
  team4,
}