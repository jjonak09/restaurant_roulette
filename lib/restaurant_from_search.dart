import 'dart:convert';
import 'package:http/http.dart' as http;
import 'gurunabi_api.dart';
import 'package:flutter/material.dart';
import 'roulette.dart';
import 'another_search.dart';
import 'restaurant_detail.dart';

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
  var restaurantList = [];

  double checkCount = 0;
  List<bool> _check = List<bool>();

  _ResultRestaurantPageState({@required this.keyword,@required this.target});

  Restaurants restaurants;

  Widget appBarTitle = Text("別の住所で検索", style: TextStyle(color: Colors.red),);
  Icon actionIcon = Icon(Icons.search, color: Colors.red,);

  final TextEditingController _searchQuery = new TextEditingController();

  Future<void> _refresh() async{
    await Future.sync((){
      requestAPI(keyword,target);
    });
  }

  void requestAPI(String keyword,String target){
    var url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=02757f7670819b9c3cb0d89b36c65775&hit_per_page=50&address=';
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

    if (restaurants == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {

      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {

          if(index == 0){
            checkCount = 0;
            restaurantList =[];

            for(int i = 0; i < restaurants.restaurants.length; i++){
              if(_check[i]){
                checkCount++;
                restaurantList.add(restaurants.restaurants[i].name);
              }
            }
            print(restaurantList);
            print(checkCount);
            return Column(
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        for(var restaurant in restaurantList) Chip(
                          label: Text(restaurant, style: TextStyle(fontSize: 8.0)),
                          onDeleted: (){
                            for(int i = 0; i < restaurants.restaurants.length; i++){
                              if(restaurant == restaurants.restaurants[i].name){
                                setState(() {
                                  _check[i] = false;
                                  checkCount -= 1;
                                });
                              }
                            }
                          },)
                      ],
                    )
                  ],
                ),

                Text(
                  'レストランを選んでください。${checkCount.toInt()}/8',
                  style: TextStyle(fontSize: 16.0),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                ),

                Card(
                  elevation: 8.0,
                  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white60),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                        border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.white24))),
                        child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(restaurants.restaurants[index].images.shopImage1)
                        )
                      ),

                      title: Text(
                      restaurants.restaurants[index].name,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 14),
                      ),

                      subtitle: Text(restaurants.restaurants[index].category,style: TextStyle(color: Colors.grey[500]),),

                      trailing: Checkbox(
                          value:_check[index],
                          onChanged: (bool value){
                            setState(() {
                              if(checkCount < 8){
                                _check[index] = value;
                              }else if(checkCount >= 8){
                                _check[index] = false;
                                if(value){
                                  showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          title: Text('選択超過'),
                                          content: Text('選択できるのは８個までです'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('OK'),
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      }
                                  );
                                }

                              }
                            });
                          }),

                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RestaurantDetailPage(
                                name:restaurants.restaurants[index].name,
                                address:restaurants.restaurants[index].address,
                                openTime:restaurants.restaurants[index].openTime,
                                urlMobile:restaurants.restaurants[index].urlMobile,
                                prLong:restaurants.restaurants[index].prs.prLong,
                                image:restaurants.restaurants[index].images.shopImage1
                            ))
                        );
                      },

                    ),
                ),
                )

              ],
            );

          } else{
            checkCount = 0;
            restaurantList =[];

            for(int i = 0; i < restaurants.restaurants.length; i++){
              if(_check[i]){
                checkCount++;
                restaurantList.add(restaurants.restaurants[i].name);
              }
            }
            print(restaurantList);
            print(checkCount);
            return  Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white54),
                child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(width: 1.0, color: Colors.white24))),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(restaurants.restaurants[index].images.shopImage1)
                      )
                    ),

                  title: Text(
                    restaurants.restaurants[index].name,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 14),
                  ),

                  subtitle: Text(restaurants.restaurants[index].category,style: TextStyle(color: Colors.grey[500]),),

                  trailing: Checkbox(
                      value:_check[index],
                      onChanged: (bool value){
                        setState(() {
                          if(checkCount < 8){
                            _check[index] = value;
                          }else if(checkCount >= 8){
                            _check[index] = false;
                            if (value){
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      title: Text('選択超過'),
                                      content: Text('選択できるのは８個までです'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  }
                              );
                            }

                          }
                        });
                      }),

                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RestaurantDetailPage(
                            name:restaurants.restaurants[index].name,
                            address:restaurants.restaurants[index].address,
                            openTime:restaurants.restaurants[index].openTime,
                            urlMobile:restaurants.restaurants[index].urlMobile,
                            prLong:restaurants.restaurants[index].prs.prLong,
                            image:restaurants.restaurants[index].images.shopImage1
                        ))
                    );
                  },
                ),
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

    Widget _makeRouletteDialog(){
      return AlertDialog(
        title: Text("ルーレット作成"),
        content: Text('この内容で作成します'),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Roulette(num:checkCount,restaurantList:restaurantList))
            );
            },
          )
        ],
      );
    }

    Widget _cancelDialog(){
      return AlertDialog(
        title: Text("注意"),
        content: Text('レストランを1つ以上選択してください'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      );
    }


    return Scaffold(
//      appBar: AppBar(
//        title: Text('レストラン一覧',style: TextStyle(color: Colors.redAccent),),
//        backgroundColor: Colors.white,
//        centerTitle: true,
//      ),
      appBar: buildBar(context),
      persistentFooterButtons: <Widget>[
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
            StatelessWidget dialog;
            if(restaurantList.length > 1){
              dialog = _makeRouletteDialog();
            }else{
              dialog = _cancelDialog();
            }
            showDialog(
              context: context,
              builder: (context){
                return dialog;
              }
            );
          },
        ),
      ],
      body: RefreshIndicator(
        child:_getCardChild(),
        onRefresh: _refresh,
      ),
    );
  }
  Widget buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: appBarTitle,
        actions: <Widget>[
        _searchButton(),
          new IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close, color: Colors.red,);
                this.appBarTitle = new TextField(
                  controller: _searchQuery,
                  style: new TextStyle(
                    color: Colors.red,
                    fontSize: 13.0

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.red),
                      hintText: "会津若松...",
                      hintStyle: new TextStyle(color: Colors.red,fontSize: 11.0)
                  ),
                );
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
        ]
    );
  }


  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.red,);
      this.appBarTitle =
      new Text("別の住所で検索", style: new TextStyle(color: Colors.red),);
//      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  Widget _searchButton(){
    if(this.actionIcon.icon == Icons.close){
      return FlatButton(
        child: Text("検索",style: TextStyle(color: Colors.red),),
        onPressed: () {
          print(_searchQuery);
        },
      );
    }else{
      return Container();
    }
  }
}