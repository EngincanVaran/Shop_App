import "package:flutter/material.dart";
import "package:provider/provider.dart";

import 'product_item.dart';
import "../providers/products_provider.dart";

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    //provider
    final productsData = Provider.of<Products>(context);
    final products =
        showFavs ? productsData.getFavItemList : productsData.getItemList;

    return products.isEmpty
        ? Center(
            child: Text(
              "There are no Favorites, how about adding one?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: products.length,
            itemBuilder: (ctx, idx) => ChangeNotifierProvider.value(
              // Alternate & Naive Way
              // ChangeNotifierProvider(
              //  create: (ctx) => Product[idx]
              // )
              child: ProductItem(),
              value: products[
                  idx], //use this when you use part list element view to eliminate errors
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
  }
}
