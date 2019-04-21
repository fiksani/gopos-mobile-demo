import 'package:flutter/material.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _tableController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 80.0),
              Column(
                children: <Widget>[
                  Text(
                    'GoPOS',
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Text(
                    'Self Service',
                    style: Theme.of(context).textTheme.headline,
                  )
                ],
              ),
              SizedBox(height: 120),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Fill your name'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _tableController,
                decoration: InputDecoration(
                  labelText: 'Fill in your table number'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter table number';
                  }
                },
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      _nameController.clear();
                      _tableController.clear();
                    },
                  ),
                  RaisedButton(
                    child: Text('NEXT'),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                            settings: const RouteSettings(name: '/home'), 
                            builder: (context) => new HomePage(
                              name: _nameController.text,
                              table: _tableController.text,
                            )
                          )
                        );
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}