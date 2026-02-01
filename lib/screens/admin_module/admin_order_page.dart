import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/orders/order_bloc.dart';
import 'package:stylish_ecommerce/bloc/orders/order_event.dart';
import 'package:stylish_ecommerce/bloc/orders/order_state.dart';
import 'package:stylish_ecommerce/screens/admin_module/order_detail_page.dart';

class AdminOrderPage extends StatefulWidget {
  const AdminOrderPage({super.key});

  @override
  State<AdminOrderPage> createState() => _AdminOrderPageState();
}

class _AdminOrderPageState extends State<AdminOrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetOrder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orders List")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is OrderError) {
                  return Center(child: Text("Error"));
                } else if (state is OrderLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderDetailPage(order: order),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(order.userName),
                              subtitle: Text("${order.total}"),
                              trailing: Text("${order.items}"),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
