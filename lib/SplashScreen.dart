import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trueworthfinance/custom/colors.dart';
import 'package:trueworthfinance/emailpassword/LoginScreen2.dart';
import 'package:trueworthfinance/pages/MainActivity.dart';
import 'package:trueworthfinance/screens/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Variables to hold user data
  String fullName = '';
  String mobile = '';
  String pan = '';

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  // This method is used to delay the navigation after the splash screen for 3 seconds.
  void _startSplashScreen() async {
    // Fetch user details while waiting
    await _checkAuthentication();

    // Wait for 3 seconds before navigating to the next screen
    Timer(Duration(seconds: 3), () {
      // Navigate to the next screen based on user authentication and data
      if (FirebaseAuth.instance.currentUser != null) {
        // If the user is logged in, navigate to MainActivity with user details
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainActivity(
            fullName: fullName,
            mobile: mobile,
            pan: pan,
          )),
        );
      } else {
        // If the user is not logged in, navigate to LoginScreen2
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen2()),
        );
      }
    });
  }

  // Fetch user details from Firebase if the user is logged in
  Future<void> _checkAuthentication() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          var userData = userSnapshot.data() as Map<String, dynamic>;
          setState(() {
            fullName = userData['fullName'] ?? '';
            mobile = userData['mobile'] ?? '';
            pan = userData['pan'] ?? '';
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white, // Primary background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            const Text(
              'Trueworth.Finance',
              style: TextStyle(
                  fontSize: 32, color: secondary,fontWeight: FontWeight.w600), // Use headline1 text style from theme
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle, // Secondary color (brown)
              ),
              child: Center(
                child: Image.asset(
                  width: 300,
                  height: 300,
                  'assets/main_logo_transparent.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Spacer(),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle, // Secondary color (brown)
              ),
              child: const Center(
                child: Text(
                  'Made in India ️🇮🇳 with love ❤️',
                  style: TextStyle(
                      fontSize: 16, color: secondary,fontWeight: FontWeight.w600), // Use headline1 text style from theme
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
