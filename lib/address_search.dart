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
        title: Text('住所/カテゴリから検索',style: TextStyle(color: Colors.redAccent),),
        backgroundColor: Colors.white,
        centerTitle: true,
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

              Text('カテゴリを選択してください'),

              DropdownButton<String>(
                onChanged: (String value) => popupSelected(value),
                value: _selected,

                items: <DropdownMenuItem<String>>[
                  const DropdownMenuItem<String>(
                    value: '1',
                      child: Text('指定なし'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST09004',
                    child: Text('居酒屋'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST02006',
                    child: Text('郷土料理'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST03000',
                    child: Text('寿司'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST04001',
                    child: Text('鍋'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST05001',
                    child: Text('焼肉'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST06009',
                    child: Text('ステーキ'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST01001',
                    child: Text('定食'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST01015',
                    child: Text('和食'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST08008',
                    child: Text('ラーメン'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST14007',
                    child: Text('中華'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST11001',
                    child: Text('フレンチ'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST11002',
                    child: Text('イタリアン'),
                  ),
                  const DropdownMenuItem<String>(
                    value: 'RSFST15001',
                    child: Text('韓国料理'),
                  ),

                ],
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          elevation: 4.0,
          backgroundColor: Colors.red,
          icon: Icon(Icons.search),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: Text('                 検索                       '),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultRestaurantPage(keyword: controller.text,target: _selected)),
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
      print(_selected);
//      print(controller.text);
    });
  }
}
