import 'package:flutter/material.dart';
import 'dart:math';

class Roulette extends StatefulWidget {
  @override
  final double num;
  final List restaurantList;

  Roulette({@required this.num,@required this.restaurantList});
  _RouletteState createState() => _RouletteState(num:num,restaurantList: restaurantList);
}

class _RouletteState extends State<Roulette> with SingleTickerProviderStateMixin{
  final double num;
  bool value = true;
  final List restaurantList;

  double rotateRadius = 0.3925;
  double rotateGap = 10.0;
  int count = 0;
  double sumRotateRadius = 0.0;

  Animation<double> _animation;
  AnimationController controller;
  final tween = Tween(begin: 0.0,end: 100.0);

  _RouletteState({@required this.num,@required this.restaurantList});

  @override
  void initState(){
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 50000),vsync: this
    );

    _animation = tween.animate(controller)
      ..addListener((){
        setState(() {
          sumRotateRadius += rotateRadius;
          print(sumRotateRadius);
          if(sumRotateRadius == 6.28){
            sumRotateRadius = 0.0;
          }
        });
      });
    }

 void startAnimation(){
   switch (_animation.status) {
     case AnimationStatus.dismissed:
     case AnimationStatus.reverse:
       controller.forward();
       break;
     case AnimationStatus.completed:
     case AnimationStatus.forward:
       controller.reset();
       print('stop');
       break;
   }
 }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                Image.asset('images/y.png',
                width: 40,
                height: 40
                  ),

                CustomPaint(
                  child: Container(
                    height: 400,
                    width: 360,
                  ),
                  painter: CirclePainter(nbnum: num,sumRotateRadius:sumRotateRadius,restaurantList: restaurantList),
                ),

                if(value)RaisedButton(
                  child: Text('start'),
                  onPressed: (){
                    value = false;
                    startAnimation();
                  }
                ),

                if(!value)RaisedButton(
                    child: Text('stop'),
                    onPressed: (){
                      value = true;
                      startAnimation();
                    }
                ),
              ],
            )
        )
    );
  }
}


class CirclePainter extends CustomPainter {

  final double nbnum;
  final List restaurantList;
  double sumRotateRadius;


  CirclePainter({@required this.nbnum, @required this.sumRotateRadius,@required this.restaurantList});
  Path getWheelPath(double wheelSize, double fromRadius, double toRadius) {
    return new Path()
      ..moveTo(wheelSize, wheelSize)
      ..arcTo(Rect.fromCircle(radius: wheelSize, center: Offset(wheelSize, wheelSize)), fromRadius, toRadius, false)
      ..close();
  }

  Paint getColoredPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  void rotate(Canvas canvas, double cx, double cy, double angle) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }

  void rouletteText(Canvas canvas,String name,Size size){
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );
    final textSpan = TextSpan(
      text: name,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 2,
      ellipsis: '..'
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width/3,
    );
    final offset = Offset(230, 160);
    textPainter.paint(canvas, offset);
  }


  @override
  void paint(Canvas canvas, Size size) {

    double wheelSize = 180;
    double nbElem = this.nbnum;
    double radius = (2 * pi) / nbElem;

//    print(sumRotateRadius);


    canvas.drawPath(getWheelPath(wheelSize, 1 + sumRotateRadius, radius), getColoredPaint(Colors.red));
    canvas.drawPath(getWheelPath(wheelSize, radius + (1 + sumRotateRadius), radius), getColoredPaint(Colors.purple));
    canvas.drawPath(getWheelPath(wheelSize, (radius) * 2 + (1 + sumRotateRadius), radius), getColoredPaint(Colors.blue));
    canvas.drawPath(getWheelPath(wheelSize, (radius) * 3 + (1 +sumRotateRadius), radius), getColoredPaint(Colors.green));
    canvas.drawPath(getWheelPath(wheelSize, (radius) * 4 + (1+sumRotateRadius), radius), getColoredPaint(Colors.yellow));
    canvas.drawPath(getWheelPath(wheelSize, (radius) * 5 + (1+sumRotateRadius), radius), getColoredPaint(Colors.orange));
    canvas.drawPath(getWheelPath(wheelSize, (radius) * 6 + (1+sumRotateRadius), radius), getColoredPaint(Colors.brown));
    canvas.drawPath(getWheelPath(wheelSize, (radius) * 7 + (1+sumRotateRadius), radius), getColoredPaint(Colors.pink));

    double radian = (radius/2);
//    print(radian);
//    print(nbElem);

    for(int i = 0; i < nbElem; i++){
      if(i == 0){
        radian = - radian + (1+ sumRotateRadius);
      }else{
        radian = - radius;
      }
      rotate(canvas,180,180,radian);
      rouletteText(canvas, restaurantList[i], size);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}