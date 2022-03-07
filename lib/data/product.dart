import 'dart:convert';

class Product {
  int id;
  String name;
  String description;
  double price;
  String imageUrl;

  Product({
    this.id = 0,
    this.name,
    this.description,
    this.price = 0,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'img': imageUrl
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) => Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['img']);

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl)';
  }
}
