import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/cart.dart";
import '../widgets/cart_item.dart';
import "../providers/orders.dart";

class CartScreen extends StatelessWidget {
  static const routeName = "/cart-screen";
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Card",
        ),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total:",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cartData.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      "ORDER NOW!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cartData.getItems.values.toList(),
                        cartData.totalAmount,
                      );
                      cartData.clearCart();
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.itemCount,
              itemBuilder: (ctx, idx) => CartListItem(
                id: cartData.getItems.values.toList()[idx].id,
                price: cartData.getItems.values.toList()[idx].price,
                quantity: cartData.getItems.values.toList()[idx].quantity,
                title: cartData.getItems.values.toList()[idx].title,
                productId: cartData.getItems.keys.toList()[idx],
              ),
            ),
          )
        ],
      ),
    );
  }
}
