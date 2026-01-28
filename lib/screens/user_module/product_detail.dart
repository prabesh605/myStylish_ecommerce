import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stylish_ecommerce/bloc/cart/cart_bloc.dart';
import 'package:stylish_ecommerce/bloc/cart/cart_event.dart';
import 'package:stylish_ecommerce/bloc/product/product_bloc.dart';
import 'package:stylish_ecommerce/bloc/product/product_event.dart';
import 'package:stylish_ecommerce/bloc/product/product_state.dart';
import 'package:stylish_ecommerce/constant/Strings.dart';
import 'package:stylish_ecommerce/models/cart_model.dart';
import 'package:stylish_ecommerce/models/product_model.dart';
import 'package:stylish_ecommerce/screens/user_module/cart_screen.dart';
import 'package:stylish_ecommerce/screens/user_module/checkout_screen.dart';
import 'package:stylish_ecommerce/widgets/item_container_widget.dart';
import 'package:stylish_ecommerce/widgets/sort_widget.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProduct());
  }

  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Here is sub Title",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 20),
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: widget.product.rating,

                        itemBuilder: (context, _) =>
                            Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                        ),
                        onPressed: () {
                          if (count > 1) {
                            setState(() {
                              count--;
                            });
                          }
                        },
                        icon: Icon(Icons.remove, color: Colors.white),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text("$count"),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            if (count < 10) {
                              count++;
                            }
                          });
                        },
                        icon: Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),
              Text("Rs. ${widget.product.price}"),
              SizedBox(height: 10),
              RichText(
                selectionColor: Colors.black,

                text: TextSpan(
                  text: "Rs. ${widget.product.initialPrice}",
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
              SizedBox(height: 20),
              Text(
                "Product Details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(widget.product.description),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      final cart = CartModel(
                        name: widget.product.name,
                        productDetail: widget.product.description,
                        price: widget.product.price,
                        itemCount: count,
                        rating: widget.product.rating,
                        categoryId: widget.product.categoryId,
                        categoryName: widget.product.categoryName,
                        imageUrl: widget.product.imageUrl,
                      );
                      context.read<CartBloc>().add(AddCart(cart));
                      Navigator.pop(context);
                    },
                    label: Text(
                      "Add to cart",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(),
                        ),
                      );
                    },
                    label: Text(
                      "Buy Now",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(Icons.ads_click, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.pink.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,

                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery in "),
                    Text(
                      "1 with hour",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(),
                    ),
                    onPressed: () {},
                    label: Text("View Similar"),
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(),
                    ),
                    onPressed: () {},
                    label: Text("Add to Compare"),
                    icon: Icon(Icons.compare_rounded),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Similar To",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("2087+ items"),
                  Spacer(),
                  SortWidget(name: 'Sort', icon: Icon(Icons.unfold_more_sharp)),
                  SizedBox(width: 10),
                  SortWidget(
                    name: 'Filter',
                    icon: Icon(Icons.filter_alt_outlined),
                  ),
                ],
              ),
              SizedBox(height: 20),

              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProductError) {
                    return Center(child: Text("Error"));
                  } else if (state is ProductLoaded) {
                    return SizedBox(
                      height: 400,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ItemContainerWidget(
                            visibleDescription: false,
                            imageUrl: product.imageUrl,
                            name: product.name,
                            description: product.description,
                            price: product.price,
                            initialPrice: product.initialPrice,
                            rating: product.rating,
                            onTap: () {},
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
        ),
      ),
    );
  }
}
