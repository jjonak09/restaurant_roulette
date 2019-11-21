import 'package:flutter/material.dart';
import 'package:flutter_app/signup.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  final controllerId = TextEditingController();
  final controllerPd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン',style: TextStyle(color: Colors.redAccent),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Container(
        child: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),


            TextField(
              controller: controllerId,
              decoration: InputDecoration(
                labelText: 'メール'
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
            ),

            TextField(
              controller: controllerPd,
              decoration: InputDecoration(
                  labelText: 'パスワード',
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
            ),

            RaisedButton(
              padding: EdgeInsets.only(left: 120.0,top: 15.0,right: 120.0,bottom: 15.0),
              child: Text("ログイン",style: TextStyle(color: Colors.white),),
              color: Colors.red,
              shape: StadiumBorder(
                side: BorderSide(color: Colors.red),
              ),
              onPressed: () {
                print(controllerId);
                print(controllerPd);
              },
            ),

            FlatButton(
              child: Text("登録"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}