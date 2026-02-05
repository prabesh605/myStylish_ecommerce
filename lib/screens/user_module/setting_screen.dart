import 'package:flutter/material.dart';
import 'package:stylish_ecommerce/screens/user_module/my_order_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text("Settings")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(leading: Icon(Icons.person), title: Text("Profile")),
          ListTile(leading: Icon(Icons.shopping_cart), title: Text("Cart")),
          ListTile(leading: Icon(Icons.favorite), title: Text("WishList")),
          ListTile(
            leading: Icon(Icons.production_quantity_limits_rounded),
            title: Text("Products"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyOrderScreen()),
              );
            },
            leading: Icon(Icons.reorder),
            title: Text("My Orders"),
          ),
        ],
      ),
    );
  }
}
