import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stylish_ecommerce/bloc/wishlist/wishlist_bloc.dart';
import 'package:stylish_ecommerce/bloc/wishlist/wishlist_event.dart';
import 'package:stylish_ecommerce/models/wishlist_model.dart';

class ItemContainerWidget extends StatelessWidget {
  const ItemContainerWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.initialPrice,
    required this.rating,
    required this.visibleDescription,
    required this.onTap,
  });
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final double initialPrice;
  final double rating;
  final bool visibleDescription;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          // padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    child: Image.network(
                      imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: IconButton(
                      onPressed: () {
                        final wishlist = WishlistModel(
                          imageUrl: imageUrl,
                          name: name,
                          description: description,
                          categoryId: "",
                          categoryName: "",
                          price: price,
                          initialPrice: initialPrice,
                          rating: rating,
                        );
                        context.read<WishlistBloc>().add(
                          AddToWishList(wishlist),
                        );
                      },
                      icon: Icon(Icons.favorite_border, color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: visibleDescription,
                      child: Text(
                        description,
                        maxLines: 4,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Rs. $price"),
                    SizedBox(height: 10),
                    RichText(
                      selectionColor: Colors.black,

                      text: TextSpan(
                        text: "Rs. $initialPrice",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " 40% Off",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    RatingBar.builder(
                      itemSize: 20,
                      initialRating: rating,

                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
