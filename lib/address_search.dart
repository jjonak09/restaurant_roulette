import 'package:flutter/material.dart';
import 'package:flutter_app/restaurant_from_search.dart';

class AddressSearchPage extends StatefulWidget{
  @override
  _AddressSearchPageState createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends State<AddressSearchPage>{

  final controller = TextEditingController();
  String _selected = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('住所/カテゴリから検索')
      ),
      body:
        Center(
          child:
          Column(
            children: <Widget>[

              Padding(
              padding: EdgeInsets.symmetric(vertical: 70.0),
          ),

              Text(
                  '住所を入力してください',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),

              TextField(
                controller: controller,
                style: TextStyle(
                    fontSize: 12.0
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: '福島県会津若松市...'
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
              ),

              DropdownButton<String>(
                onChanged: (String value) => popupSelected(value),
                value: _selected,
                items: <DropdownMenuItem<String>>[
                  const DropdownMenuItem<String>(
                    value: '1',
                      child: Text('One'),
                  ),
                  const DropdownMenuItem<String>(
                    value: '2',
                    child: Text('Two'),
                  ),
                  const DropdownMenuItem<String>(
                    value: '3',
                    child: Text('Three'),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 4.0,
          icon: Icon(Icons.search),
          label: Text('       検索              '),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultRestaurantPage(keyword: controller.text)),
            );
          },
        ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
    );
  }

  void popupSelected(String value){
    setState(() {
      _selected = value;
//      print(_selected);
//      print(controller.text);
    });
  }
}
