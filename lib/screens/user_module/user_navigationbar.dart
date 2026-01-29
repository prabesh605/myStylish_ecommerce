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

  final List<Widget> items = [
    DashboardPage(),
    Text("Wishlist"),
    CartScreen(),
    Center(child: Text("Search Screen")),
    Center(child: Text("Settings")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),

            label: 'WishList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
