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
  final String urlMobile;
  Image images;


  Restaurant({this.name,this.category,this.urlMobile,this.images});

  factory Restaurant.fromJson(Map<String,dynamic> json){
    return Restaurant(
        name:json['name'],
        category:json['category'],
        urlMobile:json['url_mobile'],
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