import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_bloc.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_event.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_state.dart';
import 'package:stylish_ecommerce/screens/admin_module/add_category_screen.dart';
import 'package:stylish_ecommerce/screens/admin_module/add_product_screen.dart';
import 'package:stylish_ecommerce/screens/admin_module/admin_order_page.dart';
import 'package:stylish_ecommerce/screens/login_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Pannel")),
      drawer: Drawer(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          },
          child: Column(
            children: [
              DrawerHeader(child: Container()),
              ListTile(
                onTap: () {
                  context.read<AuthBloc>().add(Logout());
                },
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategoryScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text("Add Category")),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text("Add Product")),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminOrderPage()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text("View Order")),
              ),
            ),
            //Product
            //Category
            //order
          ],
        ),
      ),
    );
  }
}
