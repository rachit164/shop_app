import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/widgets/orderitems.dart';

import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  //var _isLoading = false;
  // @override
  // void initState() {
  //  Future.delayed(Duration.zero).then((_) async {

  // _isLoading = true;
  // Provider.of<Orders>(context, listen: false)
  //     .fetchAndSetOrders()
  //     .then((_) => setState(() {
  //           _isLoading = false;
  //         }));

  //  });
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('Building orders');
    //final ordersData = Provider.of<Orders>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return const Center(
                  child: Text('An error occured.'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, ordersData, child) => ListView.builder(
                    itemBuilder: (ctx, index) {
                      return OrderItem(ordersData.orders[index]);
                    },
                    itemCount: ordersData.orders.length,
                  ),
                );
              }
            }
          },
        )

        // _isLoading
        //        ? const Center(child: CircularProgressIndicator())
        //        : ListView.builder(
        //            itemBuilder: (ctx, index) {
        //              return OrderItem(ordersData.orders[index]);
        //            },
        //            itemCount: ordersData.orders.length,
        //          ),
        );
  }
}
