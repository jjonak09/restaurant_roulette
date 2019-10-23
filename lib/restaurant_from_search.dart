import 'dart:convert';
import 'package:http/http.dart' as http;
import 'gurunabi_api.dart';
import 'package:flutter/material.dart';
import 'roulette.dart';

class ResultRestaurantPage extends StatefulWidget{
  final String keyword;
  String target;
  ResultRestaurantPage({@required this.keyword,@required this.target});

  @override
  _ResultRestaurantPageState createState() => _ResultRestaurantPageState(keyword: keyword,target: target);
}

class _ResultRestaurantPageState extends State<ResultRestaurantPage>{

  final String keyword;
  String target;

  double checkCount = 0;
  List<bool> _check = List<bool>();

  _ResultRestaurantPageState({@required this.keyword,@required this.target});

  Restaurants restaurants;

  Future<void> _refresh() async{
    await Future.sync((){
      requestAPI(keyword,target);
    });
  }

  void requestAPI(String keyword,String target){
    var url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=02757f7670819b9c3cb0d89b36c65775&address=';
    url = url + keyword;
    if (target != '1'){
      url = url + '&category_s=' + target;
    }
    http.get(url).then((response){
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

                FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: Colors.blueAccent,
                  padding: EdgeInsets.only(left: 130.0,top: 10.0,right: 140.0,bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search,color: Colors.white),

                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                      ),
                      Text(
                        "別の条件で検索",
                        style: TextStyle(fontSize: 13.0,color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {

                  },
                ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
              ),

              Text(
              'お店を選択してください',
                style: TextStyle(fontSize: 20.0),
              ),

              Text(
                  '${checkCount.toInt()}/8',
                style: TextStyle(fontSize: 16.0),
              ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                ),

                RaisedButton(
                  padding: EdgeInsets.only(left: 130.0,top: 10.0,right: 130.0,bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.create),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                      ),
                      Text("ルーレット作成"),
                    ],
                  ),
                  color: Colors.redAccent,
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
//                    top: BorderSide(color: Colors.black38),
//                    right: BorderSide(color: Colors.black38),
//                    bottom: BorderSide(color: Colors.black38),
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
                        if(checkCount < 8) {
                          _check[index] = value;
                        }else if(checkCount >= 8){
                          _check[index] = false;
                        }
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
//                  right: BorderSide(color: Colors.black38),
//                  bottom: BorderSide(color: Colors.black38),
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
                        if(checkCount < 8){
                          _check[index] = value;
                        }else if(checkCount >= 8){
                          _check[index] = false;
                        }
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
      appBar: AppBar(title: Text('レストラン一覧')),
      body: RefreshIndicator(
        child: _getCardChild(),
        onRefresh: _refresh,
      ),
    );
  }
}