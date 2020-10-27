import 'package:Shop_App/providers/auth.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import '../providers/product.dart';
import "../providers/cart.dart";
import "../screens/product_detail_screen.dart";

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // most used way of provider:
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
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
          child: FadeInImage(
            placeholder: AssetImage('assets/images/product-placeholder.png'),
            image: NetworkImage(
              product.imageUrl,
            ),
            fit: BoxFit.cover,
            // child: Image.network(
            //   product.imageUrl,
            //   fit: BoxFit.cover,
            // ),
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
                onPressed: () => {
                  product.toggleFavoriteStatus(authData.token, authData.userId)
                },
              ),
              //child: Text("Never Changes"), the (child) parameter in the Consumer
            ),
            trailing: IconButton(
                color: Theme.of(context).accentColor,
                icon: const Icon(
                  Icons.add_shopping_cart,
                ),
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Added item to cart!"),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                    duration: Duration(seconds: 2),
                  ));
                }),
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
