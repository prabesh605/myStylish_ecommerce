import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stylish_ecommerce/bloc/orders/order_bloc.dart';
import 'package:stylish_ecommerce/bloc/orders/order_event.dart';
import 'package:stylish_ecommerce/bloc/orders/order_state.dart';
import 'package:stylish_ecommerce/models/order_model.dart';
import 'package:stylish_ecommerce/screens/user_module/order_stepper.dart';
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
    // getMyCart();
    context.read<OrderBloc>().add(GetMyOrder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My orders")),
      body: Column(
        children: [
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is OrderError) {
                return Center(child: Text("Error"));
              } else if (state is OrderLoaded) {
                final List<OrderModel> myorders = state.orders;
                return Expanded(
                  child: ListView.builder(
                    itemCount: myorders.length,
                    itemBuilder: (context, index) {
                      final myorder = myorders[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.all(12),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderStepper(order: myorder),
                                  ),
                                ),
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(myorder.status.name),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total: ${myorder.total}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Items: ${myorder.items}"),
                              ],
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                itemCount: myorder.carts.length,
                                itemBuilder: (context, index) {
                                  final item = myorder.carts[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 0.5,
                                          blurRadius: 2,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 60,
                                              width: 60,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadiusGeometry.circular(
                                                      12,
                                                    ),
                                                child: Image.network(
                                                  item.imageUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(item.name),

                                                RatingBar.builder(
                                                  itemSize: 20,
                                                  initialRating: item.rating,

                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),

                                                Text(
                                                  "Count: ${item.itemCount}",
                                                ),

                                                Text("Rs. ${item.price}"),
                                                Text(
                                                  "Total: Rs. ${item.itemCount * item.price}",
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                      // return ListTile(
                      //   title: Text("Total: ${myorder.total}"),
                      //   trailing: Text("Items: ${myorder.items}"),
                      //   subtitle: ListView.builder(
                      //     itemCount: myorder.carts.length,
                      //     itemBuilder: (context, index) {
                      //       final item = myorder.carts[index];
                      //       return Text("${item.categoryName}");
                      //     },
                      //   ),
                      // );
                    },
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
