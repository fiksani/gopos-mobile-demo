import 'package:flutter/material.dart';

import '../model/product.dart';
import 'product_list_item.dart';

class ProductsList extends StatefulWidget {
  ProductsList({Key key, this.products}): super(key: key);

  final List<Product> products;

  @override
  State<StatefulWidget> createState() {
    return _ProductsListState();
  }
}

class _ProductsListState extends State<ProductsList> {

  Set<Product> _shoppingListCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _shoppingListCart.add(product);
      } else {
        _shoppingListCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(16.0),
      childAspectRatio: 8.0 / 8.0,
      children: widget.products.map((product) {
        return ProductListItem(
          product:product,
          inCart: _shoppingListCart.contains(product),
          onCartChanged: _handleCartChanged,
        );
      }).toList(),
    );
  }
}