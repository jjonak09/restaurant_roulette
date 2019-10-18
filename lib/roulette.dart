import 'package:flutter/material.dart';
import 'dart:math';


//class Roulette extends StatelessWidget{
//  final double num;
//  Roulette({@required this.num});
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(title: Text('ルーレット'),),
//      body:Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//
//            CustomPaint(
//              child: Container(
//                height: 400,
//                width: 360,
//              ),
//              painter: CirclePainter(nbnum:this.num),
//            ),
//
//          ],
//        ),
//      )
//    );
//  }
//}

//class Roulette extends StatefulWidget {
//  @override
//  final double num;
//  Roulette({@required this.num});
//  _RouletteState createState() => _RouletteState(num:num);
//}

//class _RouletteState extends State<Roulette> with SingleTickerProviderStateMixin{
//  final double num;
//  double rotateRadius = 0.3925;
//  double rotateGap = 10.0;
//  int count = 0;
//  double sumRotateRadius = 0.0;
//
//  Animation<double> _animation;
//  AnimationController controller;
//  _RouletteState({@required this.num});
//
//  @override
//  void initState(){
//    super.initState();
//    controller = AnimationController(
//      duration: Duration(milliseconds: 5000),vsync: this
//    );
//    controller.forward();
//    controller.addStatusListener((status){
//      if(status == AnimationStatus.completed){
//        controller.reset();
//      } else if(status == AnimationStatus.dismissed){
//        controller.forward();
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    _animation = Tween(begin: 0.0,end: rotateGap).animate(controller)
//      ..addListener((){
//        setState(() {
//          count ++;
////          print(count);
//          sumRotateRadius += rotateRadius;
//          print(sumRotateRadius);
//          if(sumRotateRadius == 6.28){
//            sumRotateRadius = 0.0;
//          }
//        });
//      });
//
//    return Scaffold(
//        body:Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              CustomPaint(
//                child: Container(
//                  height: 400,
//                  width: 360,
//                ),
//                painter: CirclePainter(nbnum: num,sumRotateRadius:sumRotateRadius),
//              ),
//            ],
//          )
//        )
//    );
//  }
//
//  @override
//  void dispose() {
//    controller.dispose();
//    super.dispose();
//  }
//
//}


class Roulette extends StatefulWidget {
  @override
  final double num;
  final List restaurantList;

  Roulette({@required this.num,@required this.restaurantList});
  _RouletteState createState() => _RouletteState(num:num,restaurantList: restaurantList);
}

class _RouletteState extends State<Roulette> with SingleTickerProviderStateMixin{
  final double num;
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
          count ++;
//          print(count);
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

                RaisedButton(
                  child: Text('start'),
                  onPressed: () => startAnimation(),
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


    canvas.drawPath(getWheelPath(wheelSize, 0 + sumRotateRadius, radius), getColoredPaint(Colors.red));
    canvas.drawPath(getWheelPath(wheelSize, radius + sumRotateRadius, radius), getColoredPaint(Colors.purple));
    canvas.drawPath(getWheelPath(wheelSize, radius * 2 + sumRotateRadius, radius), getColoredPaint(Colors.blue));
    canvas.drawPath(getWheelPath(wheelSize, radius * 3 + sumRotateRadius, radius), getColoredPaint(Colors.green));
    canvas.drawPath(getWheelPath(wheelSize, radius * 4 + sumRotateRadius, radius), getColoredPaint(Colors.yellow));
    canvas.drawPath(getWheelPath(wheelSize, radius * 5 + sumRotateRadius, radius), getColoredPaint(Colors.orange));
    canvas.drawPath(getWheelPath(wheelSize, radius * 6 + sumRotateRadius, radius), getColoredPaint(Colors.brown));
    canvas.drawPath(getWheelPath(wheelSize, radius * 7 + sumRotateRadius, radius), getColoredPaint(Colors.pink));

    double radian = (radius/2);
//    print(radian);
//    print(nbElem);

    for(int i = 0; i < nbElem; i++){
      if(i == 0){
        radian = - radian + sumRotateRadius;
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