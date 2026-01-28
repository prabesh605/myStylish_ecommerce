import 'package:flutter/material.dart';
import 'package:stylish_ecommerce/screens/user_module/cart_screen.dart';
import 'package:stylish_ecommerce/screens/user_module/dashboard_page.dart';

class UserNavigationbar extends StatefulWidget {
  const UserNavigationbar({super.key});

  @override
  State<UserNavigationbar> createState() => _UserNavigationbarState();
}

class _UserNavigationbarState extends State<UserNavigationbar> {
  int selectIndex = 0;
  List items = [
    DashboardPage(),

    CartScreen(),

    Container(child: Text("Setting")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items.elementAt(selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(icon: Icon(Icons.settings)),
        ],
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
      ),
    );
  }
}
