import 'package:flutter/material.dart';
import 'package:stylish_ecommerce/screens/user_module/khalti_page.dart';
import 'package:stylish_ecommerce/screens/user_module/my_order_screen.dart';
import 'package:stylish_ecommerce/service/khalti_service.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  KhaltiServicePidx khaltiService = KhaltiServicePidx();
  String? pidx;
  @override
  void initState() {
    super.initState();
    getPidx();
  }

  Future<void> getPidx() async {
    pidx = await khaltiService.getPidxFromKhalti();
  }

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
          ListTile(
            onTap: () {
              if (pidx != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KhaltiPage(pidx: pidx!),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error getting pidx number")),
                );
              }
            },
            leading: Icon(Icons.payment),
            title: Text("Khalti Page"),
          ),
        ],
      ),
    );
  }
}
