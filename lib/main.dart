import 'package:flutter/material.dart';

import "./screens/products_overview_screen.dart";
import "./screens/product_detail_screen.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ShopIt!",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.lightGreenAccent,
        fontFamily: "Lato",
      ),
      home: ProductsOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
