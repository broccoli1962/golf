import 'package:flutter/material.dart';
import 'package:golf/util.dart';

class myhome extends StatefulWidget {
  const myhome({super.key});

  @override
  State<myhome> createState() => _myhomeState();
}

class _myhomeState extends State<myhome> {
  final List<String> dropDownList = ['0','1','2','3','4', '5', '6', '7', '8'];


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
                  setState(
                        () {
                      if (gameCount < 18) {
                        gameCount++;
                      } else {
                        endCurrentStatus(context);
                        return;
                      }
                      winStatus(gameCount);
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