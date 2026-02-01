import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:stylish_ecommerce/models/order_model.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, required this.order});
  final OrderModel order;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orders Details")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("User Name: ${widget.order.userName}"),
                  Text("User ID: ${widget.order.userId}"),
                  Text("Total Items: ${widget.order.items}"),
                  Text("Total Amount: ${widget.order.total}"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.order.carts.length,
                itemBuilder: (context, index) {
                  final cart = widget.order.carts[index];
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 160,
                              width: 160,
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(12),
                                child: Image.network(
                                  cart.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(cart.name),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text("Variation: "),
                                    Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0.4),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text("Black"),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                RatingBar.builder(
                                  itemSize: 20,
                                  initialRating: cart.rating,

                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.amber),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0.4),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text("Rs. ${cart.price}"),
                                    ),
                                    SizedBox(width: 10),
                                    Text("Items: ${cart.itemCount}"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Order(${cart.itemCount}) :"),
                            Text("Rs. ${cart.itemCount * cart.price}"),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // ListView.builder(
            //   itemCount: widget.order.carts.length,
            //   itemBuilder: (context, index) {
            //     final item = widget.order.carts[index];
            //     return

            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
