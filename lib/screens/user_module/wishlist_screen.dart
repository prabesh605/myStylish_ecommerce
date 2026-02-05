import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stylish_ecommerce/bloc/cart/cart_bloc.dart';
import 'package:stylish_ecommerce/bloc/cart/cart_event.dart';

import 'package:stylish_ecommerce/bloc/wishlist/wishlist_bloc.dart';
import 'package:stylish_ecommerce/bloc/wishlist/wishlist_event.dart';
import 'package:stylish_ecommerce/bloc/wishlist/wishlist_state.dart';
import 'package:stylish_ecommerce/models/cart_model.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(GetWishList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My WishList"),
      ),
      body: Column(
        children: [
          BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              if (state is WishlistLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is WishlistError) {
                return Center(child: Text(state.error));
              } else if (state is WishlistLoaded) {
                final wish = state.wishlists;
                return Expanded(
                  child: ListView.builder(
                    itemCount: wish.length,
                    itemBuilder: (context, index) {
                      final wishlistss = wish[index];
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
                                    borderRadius: BorderRadiusGeometry.circular(
                                      12,
                                    ),
                                    child: Image.network(
                                      wishlistss.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(wishlistss.name),

                                        IconButton(
                                          onPressed: () {
                                            context.read<WishlistBloc>().add(
                                              DeleteWishlist(wishlistss),
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
                                            border: Border.all(width: 0.4),
                                            borderRadius: BorderRadius.circular(
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
                                      initialRating: wishlistss.rating,

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
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            "Rs. ${wishlistss.price}",
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        // Text("Items: ${wish.itemCount}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            SizedBox(height: 10),
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
                                final cart = CartModel(
                                  name: wishlistss.name,
                                  productDetail: wishlistss.description,
                                  price: wishlistss.price,
                                  itemCount: 1,
                                  rating: wishlistss.rating,
                                  categoryId: wishlistss.categoryId,
                                  categoryName: wishlistss.categoryName,
                                  imageUrl: wishlistss.imageUrl,
                                );
                                context.read<CartBloc>().add(AddCart(cart));
                                context.read<WishlistBloc>().add(
                                  DeleteWishlist(wishlistss),
                                );
                              },
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(color: Colors.white),
                              ),
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
        ],
      ),
    );
  }
}
