import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "./screens/products_overview_screen.dart";
import "./screens/product_detail_screen.dart";
import "./providers/products_provider.dart";
import "./providers/cart.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        )
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
