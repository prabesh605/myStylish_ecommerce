import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/product/product_bloc.dart';
import 'package:stylish_ecommerce/bloc/product/product_event.dart';
import 'package:stylish_ecommerce/bloc/product/product_state.dart';
import 'package:stylish_ecommerce/screens/user_model/product_detail.dart';
import 'package:stylish_ecommerce/widgets/item_container_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProduct());
  }

  String searchItem = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hint: Text("Search any Product"),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchItem = value;
                });
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductError) {
                  return Center(child: Text("Error"));
                } else if (state is ProductLoaded) {
                  final filterProduct = (searchItem == '' && searchItem.isEmpty)
                      ? state.products
                      : state.products.where((product) {
                          return product.name.toLowerCase().contains(
                            searchItem.toLowerCase(),
                          );
                        }).toList();
                  return Expanded(
                    child: GridView.builder(
                      itemCount: filterProduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.5,
                          ),
                      itemBuilder: (context, index) {
                        final product = filterProduct[index];
                        return ItemContainerWidget(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetail(product: product),
                              ),
                            );
                          },
                          visibleDescription: true,
                          imageUrl: product.imageUrl,
                          name: product.name,
                          description: product.description,
                          price: product.price,
                          initialPrice: product.initialPrice,
                          rating: product.rating,
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
    );
  }
}
