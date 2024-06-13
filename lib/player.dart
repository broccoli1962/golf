class Player {
  String name = "";
  String code = "";

  int teamScore = 0;
  int score = 0;
  int team = 0;
  int win = 0;
  int lose = 0;
  int draw = 0;

  void reset() {
    teamScore = 0;
    score = 0;
    team = 0;
    win = 0;
    lose = 0;
    draw = 0;
  }

  String getName() {
    return name;
  }

  int getTeam() {
    return team;
  }

  int getScore() {
    return score;
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

  Player(this.name, this.code);
}
