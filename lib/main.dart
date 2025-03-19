import 'package:flutter/cupertino.dart';
import 'dart:async'; // For delay function
import 'home_screen.dart';

void main() {
  runApp(CupertinoApp(
    theme: CupertinoThemeData(
      brightness: Brightness.light, // Use light theme for better alignment with blue colors
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
      backgroundColor: CupertinoColors.white, // Base background color
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0288D1), // Dark blue
              Color(0xFFB3E5FC), // Light blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo with Glow Effect
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF0288D1).withOpacity(0.7), // Blue glow
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/lgoo.webp',
                  width: 180,
                  height: 180,
                ),
              ),

              const SizedBox(height: 30),

              // Futuristic Text (Shadow Removed)
              Text(
                "Offline Mini Games",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.white, // White text for contrast
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              // Loading Indicator
              CupertinoActivityIndicator(
                radius: 20,
                color: CupertinoColors.white, // White loading indicator for visibility
              ),
            ],
          ),
        ),
      ),
    );
  }
}