import 'package:flutter/material.dart';
import 'util.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}


class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    register();
    randomTeam();
  }

  final List<String> dropDownList = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8'
  ];

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
                    value: playerList[0].score.toString(),
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
                        playerList[0].score = int.parse(value!);
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: playerList[1].score.toString(),
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
                        playerList[1].score = int.parse(value!);
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: playerList[2].score.toString(),
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
                        playerList[2].score = int.parse(value!);
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: playerList[3].score.toString(),
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
                        playerList[3].score = int.parse(value!);
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
            SizedBox(
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
                    },
                  );
                },
                child: const Text('입력')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCurrentStatus(context);
        },
        child: const Text('현황'),
      ),
    );
  }
}
