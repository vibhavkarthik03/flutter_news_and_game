import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:
            selected ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedContainer(
              child: Image.asset(
                'assets/t&j.jpg',
              ),
              onEnd: () {
                setState(() {
                  selected = false;
                });
              },
              width: 300,
              height: 300,
              alignment: selected ? Alignment.topCenter : Alignment.center,
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Text('Jump'),
        onPressed: () {
          setState(() {
            selected = true;
          });
        },
      ),
    );
  }
}
