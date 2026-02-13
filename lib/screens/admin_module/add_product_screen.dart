import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stylish_ecommerce/bloc/category/category_bloc.dart';
import 'package:stylish_ecommerce/bloc/category/category_event.dart';
import 'package:stylish_ecommerce/bloc/category/category_state.dart';
import 'package:stylish_ecommerce/bloc/product/product_bloc.dart';
import 'package:stylish_ecommerce/bloc/product/product_event.dart';
import 'package:stylish_ecommerce/bloc/product/product_state.dart';
import 'package:stylish_ecommerce/bloc/uploadImage/upload_bloc.dart';
import 'package:stylish_ecommerce/bloc/uploadImage/upload_event.dart';
import 'package:stylish_ecommerce/bloc/uploadImage/upload_state.dart';
import 'package:stylish_ecommerce/models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategories());
    context.read<ProductBloc>().add(GetProduct());
  }

  Future<bool> handleCameraPermission() async {
    ///permission
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    }
    if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted;
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return false;
  }

  void updateAddProductBottomSheet(ProductModel? product) {
    final imageUrlController = TextEditingController(text: product?.imageUrl);
    final categoryController = TextEditingController(text: product?.categoryId);
    final nameController = TextEditingController(text: product?.name);
    final descriptionController = TextEditingController(
      text: product?.description,
    );
    final priceController = TextEditingController(
      text: "${product?.price ?? "0"}",
    );
    final initialPriceController = TextEditingController(
      text: "${product?.initialPrice ?? "0"}",
    );
    final ratingController = TextEditingController(
      text: "${product?.rating ?? "0"}",
    );

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: BlocListener<UploadBloc, UploadState>(
            listener: (context, state) {
              if (state is UploadLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 20),
                            Text("Loading..."),
                          ],
                        ),
                      ),
                    );
                  },
                );
                // CircularProgressIndicator();
              }
              if (state is UploadLoaded) {
                Navigator.pop(context);
                imageUrlController.text = state.imageURl;
              }
            },
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(product == null ? "Add Product" : "Update Product"),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        label: Text("Product Name"),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        label: Text("Product Description"),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter Description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text("Product Price"),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: initialPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text("Product initialPrice"),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please enter initial price';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // DropdownButtonFormField(

                    //   items: items,
                    //   onChanged: onChanged
                    //   )
                    BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        if (state is CategoryLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is CategoryLoaded) {
                          final categories = state.categories;
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            initialValue: product == null
                                ? state.categories.first.id
                                : product.categoryId,
                            items: categories
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              print(value);
                              categoryController.text = value ?? "";
                              // categoryController.text = value ?? "";
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return 'select the field';
                              }
                              return null;
                            },
                          );

                          // TextFormField(
                          //   controller: categoryController,
                          //   decoration: InputDecoration(
                          //     label: Text("Product Category"),
                          //     border: OutlineInputBorder(),
                          //   ),
                          // );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: imageUrlController,
                            decoration: InputDecoration(
                              label: Text("Product Image"),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return 'Please upload image';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            handleCameraPermission();
                            // await Permission.camera.request();
                            context.read<UploadBloc>().add(UploadImage());
                          },
                          child: Text("Upload"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // print("Validate");
                          final productData = ProductModel(
                            id: product?.id ?? "",
                            imageUrl: imageUrlController.text,
                            name: nameController.text,
                            description: descriptionController.text,
                            categoryId: categoryController.text,
                            categoryName: "",
                            price: double.parse(priceController.text),
                            initialPrice: double.parse(
                              initialPriceController.text,
                            ),
                            rating: double.parse(ratingController.text),
                          );
                          product == null
                              ? context.read<ProductBloc>().add(
                                  AddProduct(productData),
                                )
                              : context.read<ProductBloc>().add(
                                  UpdateProduct(productData),
                                );
                          Navigator.pop(context);
                        } else {
                          print("enter");
                        }
                        // print(product);
                      },
                      child: Text(
                        product == null ? "Add Product" : "Update Product",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateAddProductBottomSheet(null);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          context.read<ProductBloc>().add(GetProduct());
          return Future.delayed(Duration(seconds: 1));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProductError) {
                    return Center(child: Text("Error"));
                  } else if (state is ProductLoaded) {
                    final products = state.products;
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.5,
                            ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: double.infinity,
                                  // width: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(Icons.image);
                                          },
                                    ),
                                  ),
                                ),

                                Text(product.name),
                                SizedBox(height: 20),
                                Text("Price: Rs.${product.price}"),
                                SizedBox(height: 20),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    updateAddProductBottomSheet(product);
                                  },
                                  label: Text("Update"),
                                ),
                              ],
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
      ),
    );
  }
}
