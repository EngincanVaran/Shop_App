import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../widgets/app_drawer.dart";
import "../providers/orders.dart";
import "../widgets/order_item.dart";

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  // var _isLoading = false;

  // @override
  // void initState() {
  //   //Future.delayed(Duration.zero).then((_) async {
  //   _isLoading = true;
  //   Provider.of<Orders>(context, listen: false).fecthAndSetOrders().then((_) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fecthAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                // do error handling
                return Center(child: Text("An Error Occured"));
              } else {
                return Consumer<Orders>(builder: (ctx, orderData, child) {
                  return ListView.builder(
                      itemCount: orderData.getOrders.length,
                      itemBuilder: (ctx, idx) {
                        return OrderListItem(
                          orderData.getOrders[idx],
                        );
                      });
                });
              }
            }
          },
        ));
  }
}
