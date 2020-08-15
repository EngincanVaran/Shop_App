import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/products_provider.dart";

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final String productID =
        ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productID); // listen: false -> listen once

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct.title,
        ),
      ),
    );
  }
}
