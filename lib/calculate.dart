import 'player.dart';

abstract class TeamCalculate {
  int insert();
  List<Player> winTeam();
}

//nothing
class Nothing implements TeamCalculate{
  @override
  int insert() {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  List<Player> winTeam() {
    // TODO: implement winTeam
    throw UnimplementedError();
  }
}

//3:1
class ThreeOne implements TeamCalculate{
  late List<Player> p;
  late List<Player> threeMan;
  late Player oneMan;

  ThreeOne(Player p1, Player p2, Player p3, Player p4) {
    p = [p1, p2, p3, p4];
    List<Player> t1 = List.from(p);
    t1.removeWhere((element) => p[0].team != element.team);
    List<Player> t2 = List.from(p);
    t2.removeWhere((element) => t1.contains(element));

    threeMan = t1.length == 3 ? t1 : t2;
    oneMan = t1.length == 1 ? t1[0] : t2[0];
  }

  @override
  int insert() {
    List<int> mScore = [threeMan[0].score,threeMan[1].score,threeMan[2].score];
    mScore.sort();
    int threeScore = mScore[0] + mScore[1]; //3명팀의 스코어
    int oneScore = oneMan.score*2; //1명팀의 스코어

    threeMan[0].teamScore = threeScore;
    threeMan[0].teamScore = threeScore;
    threeMan[0].teamScore = threeScore;
    oneMan.teamScore = oneScore;

    if(threeScore==oneScore) {
      p[0].draw++;
      p[1].draw++;
      p[2].draw++;
      p[3].draw++;
      return -1;
    }else if(threeScore<oneScore){
      threeMan[0].win++;
      threeMan[1].win++;
      threeMan[2].win++;
      oneMan.lose++;
      return threeMan[0].team;
    }else{
      oneMan.win++;
      threeMan[0].lose++;
      threeMan[1].lose++;
      threeMan[2].lose++;
      return oneMan.team;
    }
  }

  @override
  List<Player> winTeam() {
    // TODO: implement winTeam
    throw UnimplementedError();
  }
}

//2:2, 1:1:2
class TwoTwo implements TeamCalculate{
  late List<Player> p;
  late List<Player> t1;
  late List<Player> t2;
  List<Player> win = [];

  TwoTwo(Player p1, Player p2, Player p3, Player p4, int index, int index2) {
    p = [p1, p2, p3, p4];
    t1 = [p[index],p[index2]];
    t2 = List.from(p);
    t2.removeWhere((element) => t1.contains(element));
  }

  @override
  int insert() {
    int t1score = t1[0].score+t1[1].score;
    int t2score = t2[0].score+t2[1].score;

    t1[0].teamScore = t1score;
    t1[1].teamScore = t1score;
    if(t2[0].team != t2[1].team){
      t2[0].teamScore = t2[0].score;
      t2[1].teamScore = t2[1].score;
    }else{
      t2[0].teamScore = t2score;
      t2[1].teamScore = t2score;
    }

    if(t1score == t2score){
      t1[0].draw++;
      t1[1].draw++;
      t2[0].draw++;
      t2[1].draw++;
      return -1;
    }else if(t1score<t2score){
      t1[0].win++;
      t1[1].win++;
      t2[0].lose++;
      t2[1].lose++;
      win=t1;
      return t1[0].team;
    }else{
      t2[0].win++;
      t2[1].win++;
      t1[0].lose++;
      t1[1].lose++;
      win=t2;
      return t2[0].team;
    }
  }

  @override
  List<Player> winTeam() {
    return win;
  }
}

//1:1:1:1 or 4:0
class Gain implements TeamCalculate{
  late List<Player> p;
  bool dupe;
  List<Player> win = [];

  Gain(Player p1, Player p2, Player p3, Player p4, this.dupe) {
    p = [p1, p2, p3, p4];
  }

  @override
  int insert() {
    List<int> pScore = [p[0].score,p[1].score,p[2].score,p[3].score];
    List<int> insert = List.from(pScore);
    insert.sort();

    int min = insert[0];
    int same = 1;

    for (int i = 1; i < 4; i++) {
      if (min == insert[i]) {
        same++;
      }
    }

    if (same == 4) {
      for (int i = 0; i < 4; i++) {
        p[i].draw++;
      }
      return -1;
    }

    for (int i = 0; i < 4; i++) {
      if (min == pScore[i]) {
        p[i].win++;
        win.add(p[i]);
      } else {
        p[i].lose++;
      }
    }
    return 0;
  }

  @override
  List<Player> winTeam() {
    return win;
  }
}
