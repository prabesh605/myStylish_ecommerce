import 'package:flutter/material.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  FirebaseService service = FirebaseService();
  @override
  void initState() {
    super.initState();
    getMyCart();
  }

  Future<void> getMyCart() async {
    final data = await service.getMyOrder("DveI5aFIv9XfGQjZZontx6K54dt1");
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My orders")),
      body: Column(children: [Text("Orders")]),
    );
  }
}
