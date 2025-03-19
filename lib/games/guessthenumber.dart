import 'package:flutter/cupertino.dart';
import 'dart:math';

class GuessTheNumber extends StatefulWidget {
  @override
  _GuessTheNumberState createState() => _GuessTheNumberState();
}

class _GuessTheNumberState extends State<GuessTheNumber> {
  int target = Random().nextInt(100) + 1;
  String message = "Enter a number (1-100)";
  TextEditingController controller = TextEditingController();
  int attempts = 0;

  void _checkGuess() {
    int guess = int.tryParse(controller.text) ?? 0;
    if (guess < 1 || guess > 100) return;

    setState(() {
      attempts++;
      if (guess == target) {
        message = "🎉 Correct! You got it in $attempts tries!";
        _showRestartDialog();
      } else if (guess < target) {
        message = "Too low! Try again.";
      } else {
        message = "Too high! Try again.";
      }
    });

    controller.clear();
  }

  void _restartGame() {
    setState(() {
      target = Random().nextInt(100) + 1;
      message = "Enter a number (1-100)";
      attempts = 0;
      controller.clear();
    });
  }

  void _showRestartDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text("Congratulations!"),
        content: Text("You guessed the number in $attempts tries."),
        actions: [
          CupertinoDialogAction(
            child: Text("Restart"),
            onPressed: () {
              Navigator.pop(context);
              _restartGame();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Guess the Number")),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            CupertinoTextField(
              controller: controller,
              keyboardType: TextInputType.number,
              placeholder: "Enter your guess",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            CupertinoButton.filled(child: Text("Guess"), onPressed: _checkGuess),
            SizedBox(height: 10),
            Text("Attempts: $attempts", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            CupertinoButton(
              child: Text("Restart"),
              onPressed: _restartGame,
            ),
          ],
        ),
      ),
    );
  }
}
