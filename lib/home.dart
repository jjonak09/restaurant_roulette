import 'package:flutter/material.dart';
import 'package:flutter_app/address_search.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body:
        Center(
            child:
            Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 70.0),
                ),
                OutlineButton(
                  padding: EdgeInsets.only(left: 140.0,top: 15.0,right: 140.0,bottom: 15.0),
                  child: Text(
                    "現在地から検索",
                    style: TextStyle(fontSize: 13.0),

                  ),
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                OutlineButton(
                  padding: EdgeInsets.only(left: 130.0,top: 15.0,right: 130.0,bottom: 15.0),
                  child: Text(
                    "住所/カテゴリから",
                    style: TextStyle(fontSize: 13.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddressSearchPage())
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 70.0),
                ),
                RaisedButton(
                  padding: EdgeInsets.only(left: 70.0,top: 15.0,right: 70.0,bottom: 15.0),
                  child: Text("ログイン"),
                  color: Colors.white,
                  shape: StadiumBorder(
                    side: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  onPressed: () {},
                ),
              ],
            )
        )
    );
  }
}