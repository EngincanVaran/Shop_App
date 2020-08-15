import "package:flutter/material.dart";

import "../models/product.dart";
import "../screens/product_detail_screen.dart";

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          header: Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              "\$ " + product.price.toString(),
              style: TextStyle(
                color: Colors.red,
                backgroundColor: Colors.lime[50],
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              color: Theme.of(context).accentColor,
              icon: const Icon(
                Icons.favorite_border,
              ),
              onPressed: () => {},
            ),
            trailing: IconButton(
              color: Theme.of(context).accentColor,
              icon: const Icon(
                Icons.add_shopping_cart,
              ),
              onPressed: () => {},
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
