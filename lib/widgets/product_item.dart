import "package:flutter/material.dart";
import "package:provider/provider.dart";

import '../providers/product.dart';
import "../screens/product_detail_screen.dart";

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // most used way of provider:
    final Product product = Provider.of<Product>(context, listen: false);
    // alternative way is using return Consumer<type> widget
    // here we combine them to reduce the changing area look favorite icon part for consumer
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
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                color: Theme.of(context).accentColor,
                icon: product.isFavorite
                    ? Icon(Icons.favorite) // favorite
                    : Icon(Icons.favorite_border), // not favorite
                onPressed: () => {product.toggleFavoriteStatus()},
              ),
              //child: Text("Never Changes"), the (child) parameter in the Consumer
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
