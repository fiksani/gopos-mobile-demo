import 'package:flutter/material.dart';

import '../model/product.dart';

typedef void CartChangedCallback(Product product, bool inCart);

class ProductListItem extends StatelessWidget {
  ProductListItem({Product product, this.inCart, this.onCartChanged})
    : product = product,
      super(key: ObjectKey(product));
  
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black12 : Theme.of(context).accentColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      child: Card(
        color: _getColor(context),
        clipBehavior: Clip.antiAlias,
        child: Center(
          child: Text(product.name, style: _getTextStyle(context)),
        ),
      )
    );
  }
}