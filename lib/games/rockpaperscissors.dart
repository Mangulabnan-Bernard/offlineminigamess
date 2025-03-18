import 'package:flutter/cupertino.dart';
import 'dart:math';

class RockPaperScissors extends StatefulWidget {
  @override
  _RockPaperScissorsState createState() => _RockPaperScissorsState();
}

class _RockPaperScissorsState extends State<RockPaperScissors> {
  final List<String> choices = ["Rock", "Paper", "Scissors"];
  String userChoice = "";
  String aiChoice = "";
  String result = "";

  void _playGame(String choice) {
    setState(() {
      userChoice = choice;
      aiChoice = choices[Random().nextInt(3)];

      if (userChoice == aiChoice) {
        result = "It's a Draw!";
      } else if ((userChoice == "Rock" && aiChoice == "Scissors") ||
          (userChoice == "Scissors" && aiChoice == "Paper") ||
          (userChoice == "Paper" && aiChoice == "Rock")) {
        result = "You Win!";
      } else {
        result = "You Lose!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Rock-Paper-Scissors")),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Your Choice: $userChoice", style: TextStyle(fontSize: 20)),
          Text("AI's Choice: $aiChoice", style: TextStyle(fontSize: 20)),
          Text(result, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: choices.map((choice) {
              return CupertinoButton.filled(
                child: Text(choice),
                onPressed: () => _playGame(choice),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
