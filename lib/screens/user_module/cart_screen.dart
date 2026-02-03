import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stylish_ecommerce/bloc/cart/cart_bloc.dart';
import 'package:stylish_ecommerce/bloc/cart/cart_event.dart';
import 'package:stylish_ecommerce/bloc/cart/cart_state.dart';
import 'package:stylish_ecommerce/bloc/orders/order_bloc.dart';
import 'package:stylish_ecommerce/bloc/orders/order_event.dart';
import 'package:stylish_ecommerce/bloc/orders/order_state.dart';
import 'package:stylish_ecommerce/models/order_model.dart';
import 'package:stylish_ecommerce/screens/user_module/user_navigationbar.dart';
// import 'package:stylish_ecommerce/constant/Strings.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetCart());
  }

  double total = 0;
  OrderModel? orderData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("MyCart")),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderLoaded) {
            context.read<CartBloc>().add(DeleteAllMyCart());
            Navigator.push(
              context,
              (MaterialPageRoute(builder: (context) => UserNavigationbar())),
            );
          }
        },
        child: Stack(
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
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is CartError) {
                        return Center(child: Text(state.error));
                      } else if (state is CartLoaded) {
                        final carts = state.carts;

                        total = carts.fold<double>(
                          0.0,
                          (total, carts) =>
                              total + (carts.itemCount * carts.price),
                        );
                        print(total);
                        orderData = OrderModel(
                          userId: "iijksdk",
                          userName: "Prabesh",
                          items: carts.length,
                          total: total,
                          carts: carts,
                        );

                        return Expanded(
                          child: ListView.builder(
                            itemCount: carts.length,
                            itemBuilder: (context, index) {
                              final cart = carts[index];
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
                                          height: 160,
                                          width: 160,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  12,
                                                ),
                                            child: Image.network(
                                              cart.imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(cart.name),

                                                IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<CartBloc>()
                                                        .add(
                                                          DeleteParticularCart(
                                                            cart,
                                                          ),
                                                        );
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text("Variation: "),
                                                Container(
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 0.4,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                  ),
                                                  child: Text("Black"),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            RatingBar.builder(
                                              itemSize: 20,
                                              initialRating: cart.rating,

                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
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
                                                    border: Border.all(
                                                      width: 0.4,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    "Rs. ${cart.price}",
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  "Items: ${cart.itemCount}",
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Order(${cart.itemCount}) :",
                                        ),
                                        Text(
                                          "Rs. ${cart.itemCount * cart.price}",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  ),

                  // CartItemWidget(),
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
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is CartLoaded) {
                          final total = state.carts.fold<double>(
                            0.0,
                            (total, carts) =>
                                total + (carts.itemCount * carts.price),
                          );
                          return Text("Total: $total");
                        }
                        return Container();
                      },
                    ),
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
                      onPressed: () {
                        print(orderData);
                        if (orderData != null) {
                          context.read<OrderBloc>().add(AddOrder(orderData!));
                        } else {
                          print("no data");
                        }

                        // print(cart);
                      },
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
      ),
    );
  }
}
