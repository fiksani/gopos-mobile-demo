import 'package:flutter/foundation.dart';

class Product {
  const Product({
    @required this.categoryId,
    @required this.id,
    @required this.name,
    @required this.categoryName
  }): assert(categoryId != null),
      assert(id != null),
      assert(name != null),
      assert(categoryName != null);

  final int categoryId;
  final int id;
  final String name;
  final String categoryName;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      categoryId: json['category_id'],
      id: json['id'],
      name: json['name'],
      categoryName: json['category_name']
    );
  }
  
  @override
  String toString() {
    return "$name (id=$id)";
  }
}