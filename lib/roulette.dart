import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';



class Basic extends StatelessWidget {
  final StreamController _dividerController = StreamController<int>();

  dispose() {
    _dividerController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ルーレット'),),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/yajirushi.png',
              width: 40,
              height: 30
            ),
            SpinningWheel(
              Image.asset('images/wheel-6-300.png'),
              width: 310,
              height: 310,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.2,
              dividers: 6,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),

            StreamBuilder(
              stream: _dividerController.stream,
              builder: (context, snapshot) =>
              snapshot.hasData ? BasicScore(snapshot.data) : Container(),
            )
          ],
        ),
      ),
    );
  }

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class BasicScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: 'Purple',
    2: 'Magenta',
    3: 'Red',
    4: 'Dark Orange',
    5: 'Light Orange',
    6: 'Yellow',
  };

  BasicScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(color: Colors.black));
  }
}