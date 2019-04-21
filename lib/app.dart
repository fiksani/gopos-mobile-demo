import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

class GoPosApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoPOS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.green
      ),
      home: LoginPage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (_) => new LoginPage(),
              settings: settings,
            );

          case '/home':
            return new MyCustomRoute(
              builder: (_) => new HomePage(),
              settings: settings,
            );
        }
      },
    );
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}