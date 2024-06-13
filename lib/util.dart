import 'dart:math';
import 'package:flutter/material.dart';
import 'calculate.dart';
import 'playpage.dart';
import 'player.dart';
import 'inputname.dart';
import 'registerpage.dart';

int gameCount = 0;
int lastGameCount = 0;

//회원가입
void register(){
  for(int i = 0; i<4; i++){
    bool find = false;
    if(regi.isNotEmpty){
      for(int j = 0; j<regi.length; j++){
        if(regi[j].code==p[i]){
          playerList.add(Player(regi[j].name, regi[j].code));
          find = true;
          break;
        }
      }
    }
    if(!find){
      playerList.add(Player(p[i], ''));
    }
  }
}

//팀원의 리스트
List<Player> playerList = [];

TeamCalculate tc = Nothing();
List<String> result = [];

//팀 분류별 점수 계산 클래스 인터페이스 선택
void calc(){
  for(int i = 0; i<4; i++){
    int pt = playerList[i].team;
    List<Player> same = [];
    for(int j = 0; j<4; j++){
      if(pt==playerList[j].team){
        same.add(playerList[j]);
      }
    }
    switch(same.length){
      case 4: //4:0
        tc = Gain(playerList[0], playerList[1], playerList[2], playerList[3], true);
        return;
      case 3: //3:1
        tc = ThreeOne(playerList[0], playerList[1], playerList[2], playerList[3]);
        return;
      case 2: //2:2 or 2:1:1
        tc = TwoTwo(playerList[0], playerList[1], playerList[2], playerList[3], i, playerList.indexOf(same[1]));
        return;
      default:
    }
  } //1:1:1:1
  tc = Gain(playerList[0], playerList[1], playerList[2], playerList[3], false);
}

//팀의 스코어 받기
int calcTeamScore(int team){
  for(int i = 0; i<4; i++){
    if(team==playerList[i].team){
      if(tc is ThreeOne || tc is TwoTwo){
        return playerList[i].teamScore;
      }else{
        return playerList[i].score;
      }
    }
  }
  return 0;
}

//게임 결과 리스트 출력
//as == 캐스팅 is == instance of
String gameResultText(int index) {
  if(result.length>index){
    return result[index];
  }

  int winTeam = tc.insert();

  var text = '';

  for(int i=0; i<4; i++){ //플레이어 이름 점수, 팀의 점수 출력
    text += '${playerList[i].getName()} : ${playerList[i].getScore()} 팀${i+1}: ${calcTeamScore(i+1)}\n';
  }
  text += '팀 분류: ';
  for(int i=0; i<4; i++){ //내가 무슨 팀인지
    text += '${playerList[i].getName()} : 팀${playerList[i].getTeam()} ';
  }

  text += '\n결과 : ';
  if(winTeam == -1){
    text+='비겼습니다.';
  }else if(tc is Gain){
    bool dupe = (tc as Gain).dupe;
    List<Player> temp = tc.winTeam();
    for(int i = 0; i<temp.length; i++){
      if(dupe){
        text+='${temp[i].getName()}, ';
      }else{
        text+='팀${temp[i].team}, ';
      }
    }
    text = text.substring(0, text.length-2);
    text += ' 승리';
  }else if(tc is ThreeOne){
    text+='팀$winTeam 승리';
  }else{
    List<Player> win = tc.winTeam();
    if(win[0].team==win[1].team) {
      text += '팀$winTeam 승리';
    }else{
      text += '팀${win[0].team}, 팀${win[1].team} 승리';
    }
  }
  result.add(text);
  return text;
}

//현황 화면 출력
String winStatusText(int index){
  var result = '';
  for(int i = 0; i<4; i++) {
    result += '${playerList[i].getName()} : ${playerList[i].getWin()}승 ${playerList[i].getLose()}패 ${playerList[i].getDraw()}무\n';
  }
  return result;
}

//현황 버튼 출력
void showCurrentStatus(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('현황'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(winStatusText(gameCount))
            ],
          ),
        ),
        insetPadding: const EdgeInsets.all(10),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ok'),
          ),
        ],
      );
    },
  );
}

//18경기 종료후 화면 출력
void endCurrentStatus(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('경기 종료'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(winStatusText(gameCount))
            ],
          ),
        ),
        insetPadding: const EdgeInsets.all(10),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MyHome()),
                      (route) => false);
              for(int i = 0; i<playerList.length; i++){
                playerList[i].reset();
              }
              result = [];
              gameCount=0;
              lastGameCount=0;
            },
            child: const Text('초기화'),
          ),
        ],
      );
    },
  );
}


//팀 랜덤화
void randomTeam(){
  for (int i = 0; i < 4; i++){
    int teamNumber = Random().nextInt(4)+1;
    playerList[i].team = teamNumber;
  }
  calc();
}

//현재 팀 출력
String resultTitle() {
  if(gameCount!=0 && lastGameCount<gameCount){
    gameResultText(gameCount-1); //미리 출력 결과 계산
    randomTeam();
    lastGameCount = gameCount;
  }
  return '${playerList[0].getName()} : 팀${playerList[0].getTeam()},'
      ' ${playerList[1].getName()} : 팀${playerList[1].getTeam()},'
      ' ${playerList[2].getName()} : 팀${playerList[2].getTeam()},'
      ' ${playerList[3].getName()} : 팀${playerList[3].getTeam()}';
}