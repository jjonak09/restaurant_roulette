import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatefulWidget{
  final String name;
  final String address;
  final String openTime;
  final String urlMobile;
  final String prLong;
  final String image;

  RestaurantDetailPage({@required this.name,@required this.address,@required this.openTime,@required this.urlMobile,@required this.prLong,@required this.image});
  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState(name: name,address: address,openTime: openTime,urlMobile: urlMobile,prLong: prLong,image: image);
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage>{
  final String name;
  final String address;
  final String openTime;
  final String urlMobile;
  final String prLong;
  final String image;

  _RestaurantDetailPageState({@required this.name,@required this.address,@required this.openTime,@required this.urlMobile,@required this.prLong,@required this.image});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.red[400],
          child: Stack(
            children: <Widget>[
              _getBackground(),
              _getToolbar(context),
              _getGradient(),
              _getCard()
//              _getContent()
            ],
          ),
        )
    );
  }

    Container _getBackground(){
      return Container(
        child: Image.network(image,fit: BoxFit.cover,height: 300.0,),
        constraints: BoxConstraints.expand(height: 300.0),
      );
    }

  Container _getToolbar(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top),
      child: BackButton(color: Colors.red[400]),
    );
  }

  Container _getGradient() {
    return  Container(
      margin:  EdgeInsets.only(top: 190.0),
      height: 115.0,
      decoration:  BoxDecoration(
        gradient:  LinearGradient(
          colors: <Color>[
            Color(0x00736AB7),
            Color(0xFFEF5350)
          ],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent() {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 15,
    );

    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 320.0, 0.0, 32.0),
        children: <Widget>[
          new Container(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name,style: textStyle,),
                Text(address,style: textStyle,),
                Text(openTime,style: textStyle,),
                Text(prLong,style: textStyle,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _getCard(){

    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Center(
          child: Form(
            //key: _formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 300.0, bottom: 5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 4.0,
                    child:  Padding(
                      padding:  EdgeInsets.all(25.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 400,
                            child: Text(name,style:TextStyle(color: Colors.black,fontSize: 13),),
                      ),
                          Text(address,style: TextStyle(color: Colors.grey[500],fontSize: 11),),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 4.0,
                    child:  Padding(
                      padding:  EdgeInsets.all(25.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 400,
                            child: Text('[営業時間]',style: TextStyle(color: Colors.red[400],fontSize: 15),)
                      ),
                          Text(openTime,style:TextStyle(color: Colors.black,fontSize: 13),),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 4.0,
                    child:  Padding(
                      padding:  EdgeInsets.all(25.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(prLong,style:TextStyle(color: Colors.black,fontSize: 13),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

}