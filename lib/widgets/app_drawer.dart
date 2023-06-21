import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:shopapp/screens/user_products_screen.dart';

// ignore: must_be_immutable
class AppDrawer extends StatelessWidget {
  bool logout = false;

  AppDrawer({super.key});
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('HELLO FRIEND!'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.shop),
            title: Text('SHOP'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('ORDERS'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.edit),
            title: Text('MANAGE YOUR PRODUCTS'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            }),
        Divider(),
        Divider(),
        ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('LOG OUT'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('LOGGING OUT USER'),
                        content: Text('Are u sure to Logout?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed('/');
                                Provider.of<Auth>(context, listen: false)
                                    .logout();
                              },
                              child: Text('Yes')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No')),
                        ],
                      ));
            }),
      ]),
    );
  }
}
