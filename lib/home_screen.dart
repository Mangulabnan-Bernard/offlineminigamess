import 'package:flutter/cupertino.dart';
import 'games/tictactoe.dart';
import 'games/rockpaperscissors.dart';
import 'games/guessthenumber.dart';
import 'games/memorycardgame.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isLandscape = screenWidth > screenHeight;

    int crossAxisCount = isLandscape ? 3 : 2; // 3 columns in landscape
    double gridWidth = screenWidth * 0.85; // Grid takes 85% of width
    double buttonSize = gridWidth / crossAxisCount - 10; // Button size adjustment

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Offline Mini Games'),
      ),
      child: SafeArea(
        child: Center( // FULLY centers everything
          child: SizedBox(
            height: screenHeight * 0.6, // Keeps the grid in the center
            width: gridWidth, // Prevents it from touching edges
            child: GridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              shrinkWrap: true, // Prevents extra scrolling
              physics: NeverScrollableScrollPhysics(), // Stops unnecessary scroll
              children: [
                _buildGameButton(context, 'Tic-Tac-Toe', TicTacToe(), buttonSize),
                _buildGameButton(context, 'Rock-Paper-Scissors', RockPaperScissors(), buttonSize),
                _buildGameButton(context, 'Guess the Number', GuessTheNumber(), buttonSize),
                _buildGameButton(context, 'Memory Card', MemoryCardGame(), buttonSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(BuildContext context, String title, Widget screen, double size) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: CupertinoColors.systemIndigo,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
