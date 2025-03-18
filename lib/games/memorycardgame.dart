import 'package:flutter/cupertino.dart';
import 'dart:math';

class MemoryCardGame extends StatefulWidget {
  @override
  _MemoryCardGameState createState() => _MemoryCardGameState();
}

class _MemoryCardGameState extends State<MemoryCardGame> {
  final int gridSize = 6; // Set 6x6 grid
  List<String> emojis = [
    "🍎", "🍌", "🍇", "🍒", "🥑", "🍉", "🥕", "🌽", "🍕", "🍩",
    "🎸", "🎧", "🎯", "🎳", "🏀", "⚽", "🎲", "🕹", "🎵", "🚀",
    "🦄", "🎭", "🎨", "🎤", "🎻", "🎮",
    "🍎", "🍌", "🍇", "🍒", "🥑", "🍉", "🥕", "🌽", "🍕", "🍩",
    "🎸", "🎧", "🎯", "🎳", "🏀", "⚽", "🎲", "🕹", "🎵", "🚀",
    "🦄", "🎭", "🎨", "🎤", "🎻", "🎮"
  ]; // 18 unique pairs (36 total for 6x6)

  late List<bool> flipped;
  late List<int> selectedCards;
  late List<int> matchedCards;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    emojis.shuffle(); // Randomize cards
    flipped = List<bool>.filled(gridSize * gridSize, false);
    selectedCards = [];
    matchedCards = [];
    setState(() {});
  }

  void _flipCard(int index) {
    if (selectedCards.length < 2 && !flipped[index] && !matchedCards.contains(index)) {
      setState(() {
        flipped[index] = true;
        selectedCards.add(index);
      });

      if (selectedCards.length == 2) {
        _checkMatch();
      }
    }
  }

  void _checkMatch() {
    int first = selectedCards[0];
    int second = selectedCards[1];

    if (emojis[first] == emojis[second]) {
      matchedCards.addAll(selectedCards);
      if (matchedCards.length == gridSize * gridSize) {
        _showWinDialog();
      }
    } else {
      Future.delayed(Duration(milliseconds: 700), () {
        setState(() {
          flipped[first] = false;
          flipped[second] = false;
        });
      });
    }

    selectedCards.clear();
  }

  void _showWinDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text("Congratulations! 🎉"),
        content: Text("You matched all pairs!"),
        actions: [
          CupertinoDialogAction(
            child: Text("Play Again"),
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
    double gridWidth = screenWidth * 0.9; // Grid width 90% of screen width
    double boxSize = gridWidth / gridSize; // Box size based on grid width

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Memory Card Game"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text("Match the pairs! 🃏", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),

            Expanded(
              child: Center(
                child: Container(
                  width: gridWidth, // Ensure grid stays centered
                  padding: EdgeInsets.all(5),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridSize,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: gridSize * gridSize,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _flipCard(index),
                        child: Container(
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                            color: matchedCards.contains(index)
                                ? CupertinoColors.systemGreen.withOpacity(0.7)
                                : CupertinoColors.systemGrey5,
                            borderRadius: BorderRadius.circular(😎,
                            boxShadow: [
                              BoxShadow(
                                color: CupertinoColors.black.withOpacity(0.2),
                                blurRadius: 3,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              flipped[index] || matchedCards.contains(index)
                                  ? emojis[index]
                                  : "❓",
                              style: TextStyle(fontSize: boxSize * 0.5),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            CupertinoButton.filled(
              child: Text("Restart"),
              onPressed: _resetGame,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
