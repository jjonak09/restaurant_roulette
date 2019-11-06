import 'package:flutter/material.dart';
import 'package:flutter_app/address_search.dart';
import 'package:flutter_app/location_search.dart';

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
          title: Text('検索画面',style: TextStyle(color: Colors.redAccent),),
          backgroundColor: Colors.white,
          centerTitle: true,
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
                FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 130.0,top: 15.0,right: 140.0,bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.home,color: Colors.white),

                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                      ),
                      Text(
                        "現在地から検索",
                        style: TextStyle(fontSize: 13.0,color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LocationSearchPage())
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 130.0,top: 15.0,right: 130.0,bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search,color: Colors.white),

                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),

                      Text(
                        "住所/カテゴリから",
                        style: TextStyle(fontSize: 13.0,color: Colors.white),
                      ),
                    ],
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