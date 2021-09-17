import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';

class LoadScreen extends StatefulWidget {
  final String nextRoute;
  LoadScreen({required this.nextRoute});

  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(widget.nextRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
            child: Image(image: AssetImage('assets/logos/mainlogo.png'))),
      ),
    );
  }
}
