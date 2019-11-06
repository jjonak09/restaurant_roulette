//class Restaurants {
//  final List<Restaurant> restaurants;
//  Restaurants({this.restaurants});
//
//  factory Restaurants.fromJson(List<dynamic> json){
//    List<Restaurant> restaurants = List<Restaurant>();
//    restaurants = json.map((i) => Restaurant.fromJson(i)).toList();
//    return Restaurants(
//        restaurants: restaurants
//    );
//  }
//}

class Restaurants {
  final List<Restaurant> restaurants;
  Restaurants({this.restaurants});

  factory Restaurants.fromJson(Map<String, dynamic> json){

    var list = json['rest'] as List;
//    print(list.runtimeType);
    List<Restaurant> restaurantList = list.map((i) => Restaurant.fromJson(i)).toList();

    return Restaurants(
        restaurants: restaurantList
    );
  }
}

class Restaurant{
  final String name;
  final String category;
  final String address;
  final String openTime;
  final String urlMobile;
  Image images;
  PR prs;


  Restaurant({this.name,this.category,this.urlMobile,this.images,this.address,this.prs,this.openTime});

  factory Restaurant.fromJson(Map<String,dynamic> json){
    return Restaurant(
        name:json['name'],
        category:json['category'],
        urlMobile:json['url_mobile'],
        address:json['address'],
        openTime:json['opentime'],
        prs: PR.fromJson(json['pr']),
        images: Image.fromJson(json['image_url'])
    );
  }
}

class Image{
  final String shopImage1;
  final String shopImage2;

  Image({
    this.shopImage1,
    this.shopImage2
});

  factory Image.fromJson(Map<String,dynamic> json){
    return Image(
      shopImage1: json['shop_image1'],
      shopImage2: json['shop_image2']
    );
  }

}

class PR{
  final String prShort;
  final String prLong;

  PR({this.prShort,this.prLong});

  factory PR.fromJson(Map<String,dynamic> json){
    return PR(
      prShort: json['pr_short'],
      prLong: json['pr_long']
    );
  }
}

//class Restaurant{
//  final String name;
//  final String category;
//  final String urlMobile;
//
//  Restaurant({this.name,this.category,this.urlMobile});
//
//  factory Restaurant.fromJson(Map<String,dynamic> json){
//    return Restaurant(
//      name:json['name'],
//      category:json['category'],
//      urlMobile:json['url_mobile']
//    );
//  }
//}