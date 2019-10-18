import 'dart:convert';
import 'package:http/http.dart' as http;
import 'gurunabi_api.dart';
import 'package:flutter/material.dart';
import 'roulette.dart';

class ResultRestaurantPage extends StatefulWidget{
  final String keyword;
  ResultRestaurantPage({@required this.keyword});

  @override
  _ResultRestaurantPageState createState() => _ResultRestaurantPageState(keyword: keyword);
}

class _ResultRestaurantPageState extends State<ResultRestaurantPage>{

  final String keyword;
  double checkCount = 0;
  List<bool> _check = List<bool>();

  _ResultRestaurantPageState({@required this.keyword});

  Restaurants restaurants;

  Future<void> _refresh() async{
    await Future.sync((){
      requestAPI(keyword);
    });
  }

  void requestAPI(String keyword){
    var url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=02757f7670819b9c3cb0d89b36c65775&address=';

    http.get(url + keyword).then((response){
      var body = response.body;
      var result = jsonDecode(body);
      setState((){
        restaurants = Restaurants.fromJson(result);
        for(int i = 0; i < restaurants.restaurants.length; i++) {
          _check.add(false);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Widget _getCardChild() {
    if(restaurants == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {

          if (index == 0){
            checkCount = 0;
            var restaurantList = [];

            for(int i = 0; i < restaurants.restaurants.length; i++){
              if(_check[i]){
                print(restaurants.restaurants[i].name);
                checkCount++;
                restaurantList.add(restaurants.restaurants[i].name);
            }
          }
            print(checkCount);
            print(restaurantList);
            return Column(
              children: <Widget>[

              RaisedButton(
                padding: EdgeInsets.only(left: 150.0,top: 5.0,right: 150.0,bottom: 5.0),
                child: Text("ルーレット作成"),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Roulette(num:checkCount,restaurantList:restaurantList))
                );
              },
            ),

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.black38),
                    bottom: BorderSide(color: Colors.black38),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(restaurants.restaurants[index].images.shopImage1),
                  ),
                  title: Text(restaurants.restaurants[index].name),
                  subtitle: Text(restaurants.restaurants[index].category),
                  trailing: Checkbox(
                    value:_check[index],
                      onChanged: (bool value){
                      setState(() {
                        _check[index] = value;
                    });
              }),
              ),
              )
            ],
          );
//
          } else{
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black38),
                  bottom: BorderSide(color: Colors.black38),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(restaurants.restaurants[index].images.shopImage1),
                ),
                title: Text(restaurants.restaurants[index].name),
                subtitle: Text(restaurants.restaurants[index].category),
                trailing: Checkbox(
                    value:_check[index],
                    onChanged: (bool value){
                      setState(() {
                        _check[index] = value;
                      });
                    }),
              ),
            );
          }
         },
        itemCount: restaurants.restaurants.length,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('一覧')),
      body: RefreshIndicator(
        child: _getCardChild(),
        onRefresh: _refresh,
      ),
    );
  }
}