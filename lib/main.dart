import 'dart:math';
import 'package:flutter/material.dart';
import 'player.dart';

void main() => runApp(const myApp());

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Golf',
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
  final List<String> dropDownList = ['-4','-3','-2','-1','0', '1', '2', '3', '4'];
  int gameCount = 0;
  List<Player> playerList = [
    Player('홍길동'),
    Player('일지매'),
    Player('동해물'),
    Player('백두산')
  ];
  List<int> teamCount = [0, 0, 0, 0];

  countTeamMember(int index){
    teamCount = [0, 0, 0, 0];
    for(int i = 0; i < 4; i++){
      teamCount[playerList[i].team[index] - 1] += 1;
    }
  }

  int calcTeamScore(int teamNumber, int index) {
    int sum = 0;
    int count = 0;
    List<int> teamScore = [];

    for (int i = 0; i < 4; i++) {
      //한팀에 2명 이상일때
      if (teamNumber == playerList[i].team[index]) {
        teamScore.add(playerList[i].score[index]);
        sum += playerList[i].score[index];
      }
    }

    if(teamCount[teamNumber - 1] == 1){ // 팀이 한명일 때
      for(int i = 0; i < 4; i++){
        if(i == (teamNumber - 1)){
          continue;
        }
        if(teamCount[i] == 1){
          count += 1;
          sum += playerList[i].score[index];  // 한쪽에 점수 몰아주기
          print('$i $index $sum');
        }
        if(count > 2){
          return 0; // 1:1:1:1 인 경우 모든 팀 점수를 0으로 하고 개인 점수를 비교
        }
      }
      if(count == 0){
        sum *= 2;
      }

      for(int i = 0; i < 4; i++){
        if(i == (teamNumber - 1)){
          continue;
        }
        if(teamCount[i] == 1){
          if(i < (teamNumber - 1)){
            return 0; // 2:1:1일 경우 1명인 팀 2개 중 하나로 몰아주기 위해 한쪽 점수를 0으로 함.
          }
        }
      }
    }
    if(teamCount[teamNumber - 1] == 3){ // 팀이 3명일 때
      teamScore.sort();
      sum = teamScore[0] + teamScore[1];
    }

    return sum;
  }


  String winningTeam(int one, int two, int three, int four, int index){
    // 각 팀의 타수로 이긴 팀 찾기
    Map scores =
    {
      'team1':one,
      'team2':two,
      'team3':three,
      'team4':four
    };
    int singleTeamCheck = 0;
    int count = 0;
    int min = 11; // 5홀에서 더블파로 10타가 최소 타수입니다.
    String winningPlayer = '';  // 개인전의 승자

    for(int i = 0; i < 4; i++){ // 하나의 팀만 점수가 있을 때 또는 모든 팀에 점수가 없을 때(4:0 or 1:1:1:1)
      if(scores['team$i'] == 0){
        singleTeamCheck++;
      }
    }

    if(singleTeamCheck == 3){
      for(int i = 0; i < 4; i++){
        if(min > playerList[i].score[index]){
          min = playerList[i].score[index];
          winningPlayer = '${playerList[i].name} 승리';
        }
      }

      for(int i = 0; i < 4; i++){
        if(min == playerList[i].score[index]){
          count++;
        }
      }

      if(count > 1){
        winningPlayer = '비겼습니다.';
      }

      return winningPlayer;
    }

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

  String gameResultText(int index) {
    var result = '';
    countTeamMember(index);
    for (int i = 0; i < 4; i++) {
      result +=
          '${playerList[i].getName()} : ${playerList[i].score[index]}  팀${i+1}: ${calcTeamScore(i+1, index)}\n';
    }
    result += '팀 분류: ${playerList[0].getName()} : 팀${playerList[0].team[index]} ${playerList[1].getName()}: 팀${playerList[1].team[index]} ${playerList[2].getName()}: 팀${playerList[2].team[index]} ${playerList[3].getName()}: 팀${playerList[3].team[index]}\n';
    result += '결과 : ${winningTeam(calcTeamScore(1, index), calcTeamScore(2, index), calcTeamScore(3, index), calcTeamScore(4, index), index)}\n';
    return result;
  }

  void showCurrentStatus(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('현황'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${playerList[0].getName()}: ${playerList[0].getWin()}승 ${playerList[0].getWin()}패 ${playerList[0].getWin()}무'),
                Text('${playerList[1].getName()}: ${playerList[1].getWin()}승 ${playerList[1].getWin()}패 ${playerList[1].getWin()}무'),
                Text('${playerList[2].getName()}: ${playerList[2].getWin()}승 ${playerList[2].getWin()}패 ${playerList[2].getWin()}무'),
                Text('${playerList[3].getName()}: ${playerList[3].getWin()}승 ${playerList[3].getWin()}패 ${playerList[3].getWin()}무'),
              ],
            ),
          ),
          insetPadding: const EdgeInsets.all(10),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ok'),
            ),
          ],
        );
      },
    );
  }


  void randomTeam(){
    for (int i = 0; i < 4; i++){
      int teamNumber = Random().nextInt(4)+1;
      playerList[i].team[gameCount] = teamNumber;
    }
  }

  int first = -1;
  String resultTitle() {
    if (first != gameCount) {
      randomTeam();
      first = gameCount;
    }
    return '${playerList[0].getName()} : 팀${playerList[0].getTeam(gameCount)}, ${playerList[1].getName()} : 팀${playerList[1].getTeam(gameCount)}, ${playerList[2].getName()} : 팀${playerList[2].getTeam(gameCount)}, ${playerList[3].getName()} : 팀${playerList[3].getTeam(gameCount)}';
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
              child: Center(child: Text(resultTitle())),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: playerList[0].score[gameCount].toString(),
                    items: dropDownList.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        playerList[0].score[gameCount] = int.parse(value!);
                        print(playerList[0].score[gameCount]);
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: playerList[1].score[gameCount].toString(),
                    items: dropDownList.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        playerList[1].score[gameCount] = int.parse(value!);
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: playerList[2].score[gameCount].toString(),
                    items: dropDownList.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        playerList[2].score[gameCount] = int.parse(value!);
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: playerList[3].score[gameCount].toString(),
                    items: dropDownList.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        playerList[3].score[gameCount] = int.parse(value!);
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
                itemCount: gameCount,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text('경기 결과 ${index + 1}'),
                      subtitle: Text(gameResultText(index)));
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
                  randomTeam();
                  setState(
                    () {
                      if (gameCount != 18) {
                        gameCount++;
                        print(playerList[0].team);
                        print(playerList[0].score);
                      } else {
                        return;
                      }
                    },
                  );
                },
                child: Text('입력')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCurrentStatus(context);
        },
        child: Text('현황'),
      ),
    );
  }
}
