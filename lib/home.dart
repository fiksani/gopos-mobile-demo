import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'widget/product_list.dart';
import 'model/product.dart';

class HomePage extends StatefulWidget {

  HomePage({this.name, this.table});

  final String name;
  final String table;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  List<Product> _products = [];
  Set<Product> _shoppingListCart = Set<Product>();

  void _handleCartChanged(cart) {
    _shoppingListCart = cart;
  }

  Future<List <Product>> _fetchProduct() async {
    final response = await http.get('http://localhost:8000/api/products');
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      _products = list.map((model) => Product.fromJson(model)).toList();
      return _products;
    }
    return [];
  }

  Future<void> createOrder(String url, {Map<String, dynamic> body}) async {
    http.post(url, body: json.encode(body), headers: {"content-type":"application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
  
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table ${widget.table}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
            },
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _fetchProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error);

          return snapshot.hasData
            ? ProductsList(products: snapshot.data, onCartChanged: _handleCartChanged)
            : Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.0),
        child: RaisedButton.icon(
          onPressed: () {
            createOrder(
              'http://localhost:8000/api/orders',
              body: {
                'name': widget.name,
                'table_number': widget.table,
                'items': _shoppingListCart.map((product) => {'product': product.id.toString()}).toList()
                ,
              }
            );
          },
          elevation: 2.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
          ),
          color: const Color(0xFFFFB822),
          icon: Icon(Icons.shopping_basket),
          label: Text("Order",
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}