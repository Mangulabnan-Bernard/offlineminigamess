import 'package:flutter/cupertino.dart';
import 'dart:async'; // For delay function
import 'home_screen.dart';

void main() {
  runApp(CupertinoApp(
    theme: CupertinoThemeData(
      brightness: Brightness.dark,
    ),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(), // Show SplashScreen first
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay before moving to HomeScreen
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black, // Dark background
      child: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF000000), // Black
                  Color(0xFF1E1E1E), // Dark Gray
                  Color(0xFF3B3B3B), // Lighter Gray
                ],
              ),
            ),
          ),

          // Centered Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/lgoo.webp',
                  width: 150,
                  height: 150,
                ),

                const SizedBox(height: 20),

                // Futuristic Text
                Text(
                  "Welcome to Offline Mini Games",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: CupertinoColors.systemBlue.withOpacity(0.8),
                        offset: Offset(0, 0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Loading Indicator
                CupertinoActivityIndicator(
                  radius: 15,
                  color: CupertinoColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
