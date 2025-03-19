import 'package:flutter/cupertino.dart';
import 'dart:math';

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, '');
  bool isPlayerX = true;
  bool isAiMode = false;
  bool gameOver = false;

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      isPlayerX = true;
      gameOver = false;
    });
  }

  void _makeMove(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = isPlayerX ? 'X' : 'O';
        if (_checkWinner(board[index])) {
          _showWinnerDialog(board[index]);
          gameOver = true;
          return;
        }
        isPlayerX = !isPlayerX;
      });

      if (isAiMode && !isPlayerX && !gameOver) {
        _aiMove();
      }
    }
  }

  void _aiMove() {
    List<int> availableMoves = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') availableMoves.add(i);
    }

    if (availableMoves.isNotEmpty) {
      int randomIndex = Random().nextInt(availableMoves.length);
      int aiMove = availableMoves[randomIndex];

      Future.delayed(Duration(milliseconds: 500), () {
        if (!gameOver) {
          setState(() {
            board[aiMove] = 'O';
            if (_checkWinner('O')) {
              _showWinnerDialog('O');
              gameOver = true;
              return;
            }
            isPlayerX = true;
          });
        }
      });
    }
  }

  bool _checkWinner(String player) {
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] == player &&
          board[pattern[1]] == player &&
          board[pattern[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void _showWinnerDialog(String winner) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text("Game Over"),
        content: Text(winner == 'X' ? "Player X Wins!" : "Player O Wins!"),
        actions: [
          CupertinoDialogAction(
            child: Text("Restart"),
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double boardSize = screenWidth * 0.6; // 60% of screen width

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Tic-Tac-Toe"),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Turn: ${isPlayerX ? 'X' : 'O'}", style: TextStyle(fontSize: 22)),

            SizedBox(height: 20),

            Container(
              width: boardSize,
              height: boardSize,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _makeMove(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          board[index],
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black, // X and O are black
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton.filled(
                  child: Text("Restart"),
                  onPressed: _resetGame,
                ),
                SizedBox(width: 10),
                CupertinoButton.filled(
                  child: Text(isAiMode ? "Play vs Player" : "Play vs AI"),
                  onPressed: () {
                    setState(() {
                      _resetGame();
                      isAiMode = !isAiMode;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
