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
  bool _isHovered = false; // State for hover animation

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isLandscape = screenWidth > screenHeight;

    int crossAxisCount = isLandscape ? 3 : 2; // 3 columns in landscape
    double gridWidth = screenWidth * 0.85; // Grid takes 85% of width
    double buttonSize = gridWidth / crossAxisCount - 10; // Button size adjustment

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white, // Light background
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Offline Mini Games',
          style: TextStyle(
            color: CupertinoColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFFB3E5FC), // Light blue for the navbar
      ),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFB3E5FC), // Light blue
                CupertinoColors.white, // White
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SizedBox(
              height: screenHeight * 0.6,
              width: gridWidth,
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
      onTapDown: (_) => setState(() => _isHovered = true), // Hover effect on tap down
      onTapUp: (_) => setState(() => _isHovered = false), // Reset hover effect
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isHovered
                ? [Color(0xFF0277BD), Color(0xFF0097A7)] // Darker shades on hover
                : [Color(0xFF4FC3F7), Color(0xFF81D4FA)], // Light shades by default
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Color(0xFF0277BD).withOpacity(0.3)
                  : Color(0xFF4FC3F7).withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
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
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}