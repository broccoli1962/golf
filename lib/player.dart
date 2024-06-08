class Player {
  String name = "";

  List<int> score = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0];
  List<int> team = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0];
  int win = 0;
  int lose = 0;
  int draw = 0;

  String getName() {
    return name;
  }

  int getTeam(num) {
    return team[num];
  }

  int getScore(num) {
    return score[num];
  }

  int getWin() {
    return win;
  }

  int getLose() {
    return lose;
  }

  int getDraw() {
    return draw;
  }

  Player(this.name);
}
