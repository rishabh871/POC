import 'package:jai_poc/core/realm/item.dart';

class Product {
  final String title;
  final String description;
  final String imageUrl;
  final String price;
  final List<String> images;

  Product(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      required this.images});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      description: json['description'],
      imageUrl: json['thumbnail'],
      price: json['price'].toString(),
      images: List<String>.from(json['images']),
    );
  }

  factory Product.fromItem(Item item) {
    return Product(
      title: item.title,
      description: item.description,
      imageUrl: item.imageUrl,
      price: item.price,
      images: item.images,
    );
  }

  Item toItem() {
    return Item(
      title,
      description,
      imageUrl,
      price,
      images: images,
    );
  }
}
