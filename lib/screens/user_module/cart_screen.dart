import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stylish_ecommerce/constant/Strings.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("MyCart")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cart List",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 20),

                CartItemWidget(),
              ],
            ),
          ),
          Positioned(
            // width: MediaQuery.of(context).size.width * .9,
            bottom: 0,
            child: Container(
              // width: MediaQuery.of(context).size.width * .9,
              // width: double.infinity,
              decoration: BoxDecoration(
                // color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Total: 7000"),
                  SizedBox(width: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * .6,
                        40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: Color(0xffF83758),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Proceed to payment",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    products.first.imageUrl,
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
                  Text("Women's Casual Wear"),
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
                    initialRating: 4,

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
                        child: Text("Rs. 34.00"),
                      ),
                      SizedBox(width: 10),
                      Text("Items: 5"),
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
            children: [Text("Total Order(5) :"), Text("Rs. 5 x 34.00")],
          ),
        ],
      ),
    );
  }
}
