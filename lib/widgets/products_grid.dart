import "package:flutter/material.dart";
import "package:provider/provider.dart";

import 'product_item.dart';
import "../providers/products_provider.dart";

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //provider
    final productsData = Provider.of<Products>(context);
    final products = productsData.getItemList;

    return GridView.builder(
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
