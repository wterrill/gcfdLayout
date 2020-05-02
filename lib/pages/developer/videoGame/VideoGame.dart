import 'dart:html';

import 'package:flutter/services.dart';

import 'GameDefs.dart';
import 'Snake.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class VideoGame extends StatefulWidget {
  VideoGame({Key key}) : super(key: key);

  @override
  _VideoGameState createState() => _VideoGameState();
}

class _VideoGameState extends State<VideoGame> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      // getKeystroke();
      if (kill) {
        timer.cancel();
      }
      updateSnake();
      setState(() {});
    });
  }

  bool kill = false;
  FocusNode focusNode = FocusNode();
  String direction = "right";
  Snake snake = Snake();
  GameDefs gameDefs = GameDefs();
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return WillPopScope(
      onWillPop: () {
        print(
            'Backbutton pressed (device or appbar button), do whatever you want.');
        kill = true;
        //trigger leaving and use own data
        Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: RawKeyboardListener(
          focusNode: focusNode,
          onKey: (RawKeyEvent event) {
            getKeystroke(event.data.logicalKey);
          },
          child: GridView.builder(
            itemCount: gameDefs.itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gameDefs.crossAxisCount),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.grey,
                  child: getPixels(index));
            },
          ),
        ),
      ),
    );
  }

  Widget getPixels(int index) {
    Widget finalPixel;
    List<int> snakeBody = snake.getSnake();
    if (snakeBody.contains(index)) {
      finalPixel = Container(color: snake.getColor());
    }
    return finalPixel;
  }

  void updateSnake() {
    // print("updating snake");
    if (direction == "right") {
      snake.snakeTick(1);
    }
    if (direction == "left") {
      snake.snakeTick(-1);
    }
    if (direction == "up") {
      snake.snakeTick(-1 * gameDefs.crossAxisCount);
    }
    if (direction == "down") {
      snake.snakeTick(gameDefs.crossAxisCount);
    }
  }

  void getKeystroke(LogicalKeyboardKey keypress) {
    if (keypress == LogicalKeyboardKey.arrowDown) {
      direction = "down";
    }
    if (keypress == LogicalKeyboardKey.arrowLeft) {
      direction = "left";
    }
    if (keypress == LogicalKeyboardKey.arrowRight) {
      direction = "right";
    }
    if (keypress == LogicalKeyboardKey.arrowUp) {
      direction = "up";
    }
  }
}
