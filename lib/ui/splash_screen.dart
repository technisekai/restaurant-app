import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, '/restaurant'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFc80064),
      /* logo and title */
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.restaurant_menu,
            color: Colors.white,
            size: 100,
          ),
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'DM Sans',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            child: Text('Restaurant'),
          ),
        ],
      ),
    );
  }
}
