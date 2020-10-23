import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import "cart.dart";

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.amount,
    @required this.dateTime,
    @required this.id,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;

  Orders(this.authToken, this._orders);

  List<OrderItem> get getOrders {
    return [..._orders];
  }

  Future<void> fecthAndSetOrders() async {
    final url =
        'https://shop-app-e534a.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final body = json.decode(response.body) as Map<String, dynamic>;
    if (body == null) return;
    body.forEach((id, orderData) {
      loadedOrders.add(OrderItem(
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        id: id,
        products: (orderData['products'] as List<dynamic>)
            .map(
              (e) => CartItem(
                id: e['id'],
                price: e['price'],
                quantity: e['quantity'],
                title: e['title'],
              ),
            )
            .toList(),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://shop-app-e534a.firebaseio.com/orders.json?auth=$authToken';
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((e) => {
                  'id': e.id,
                  'title': e.title,
                  'quantity': e.quantity,
                  'price': e.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
          amount: total,
          dateTime: timestamp,
          id: json.decode(response.body)['name'],
          products: cartProducts),
    );
    notifyListeners();
  }
}
