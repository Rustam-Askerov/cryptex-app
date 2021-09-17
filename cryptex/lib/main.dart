import 'package:cryptex/data/user.dart';
import 'package:cryptex/pages/home_page.dart';
import 'package:cryptex/pages/loadscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/HomePage': (BuildContext context) => HomePage(),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoadScreen(
          nextRoute: '/HomePage',
        ),
        routes: routes,
      ),
    );
  }
}
