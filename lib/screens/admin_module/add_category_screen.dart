import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/category/category_bloc.dart';
import 'package:stylish_ecommerce/bloc/category/category_event.dart';
import 'package:stylish_ecommerce/bloc/category/category_state.dart';
import 'package:stylish_ecommerce/bloc/uploadImage/upload_bloc.dart';
import 'package:stylish_ecommerce/bloc/uploadImage/upload_event.dart';
import 'package:stylish_ecommerce/bloc/uploadImage/upload_state.dart';
import 'package:stylish_ecommerce/models/category_model.dart';
import 'package:stylish_ecommerce/service/image_service.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final formkey = GlobalKey<FormState>();
  ImageService imageService = ImageService();
  File? imageFile;
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategories());
  }

  void chooseImageUploadOption() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose Upload Option"),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    imageFile = await imageService.pickImageFromCamera();
                    Navigator.pop(context, true);
                  },
                  label: Text("Camera"),
                  icon: Icon(Icons.camera),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    imageFile = await imageService.pickImageFromGallery();
                    Navigator.pop(context, true);
                  },
                  label: Text("Gallery"),
                  icon: Icon(Icons.browse_gallery_sharp),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showLoadingDialog(BuildContext context) {
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
  }

  void addCategoryBottomSheet(CategoryModel? category) {
    print(category?.id);
    final categoryNameController = TextEditingController(
      text: category?.name ?? "",
    );
    final imageController = TextEditingController(text: category?.image ?? "");
    final codeController = TextEditingController(text: category?.code ?? "");

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocListener<UploadBloc, UploadState>(
            listener: (context, state) {
              if (state is UploadLoading) {
                showLoadingDialog(context);
                // CircularProgressIndicator();
              }
              if (state is UploadLoaded) {
                Navigator.pop(context);
                imageController.text = state.imageURl;
              }
            },
            child: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(category == null ? "Add Category" : "Update Category"),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: categoryNameController,
                    decoration: InputDecoration(
                      label: Text("Category Name"),
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: imageController,
                          decoration: InputDecoration(
                            label: Text("Image"),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return 'Please upload Image';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 6),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          context.read<UploadBloc>().add(UploadImage());
                          // chooseImageUploadOption();
                          // imageFile = await imageService.pickImageFromGallery();

                          // if (imageFile != null) {
                          //   final String imageURl = await imageService.uploadImage(
                          //     imageFile,
                          //   );
                          //   imageController.text = imageURl;
                          // }
                          // Navigator.pop(context);
                          // imageService.pickImage();
                        },
                        child: Text(
                          "Upload",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: codeController,
                    decoration: InputDecoration(
                      label: Text("Code"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Please enter code';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        final categoryModel = CategoryModel(
                          id: category?.id ?? "",
                          name: categoryNameController.text,
                          image: imageController.text,
                          code: codeController.text,
                        );
                        category == null
                            ? context.read<CategoryBloc>().add(
                                AddCategory(categoryModel),
                              )
                            : context.read<CategoryBloc>().add(
                                UpdateCategory(categoryModel),
                              );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      category == null ? "Add Category" : "Update Category",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
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
      appBar: AppBar(title: Text("Categories")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addCategoryBottomSheet(null);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          context.read<CategoryBloc>().add(GetCategories());
          return Future.delayed(Duration(seconds: 1));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CategoryError) {
                    return Center(child: Text(state.error));
                  } else if (state is CategoryLoaded) {
                    final categories = state.categories;
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.5,
                            ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
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
                                      category.image,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(Icons.image);
                                          },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(category.code ?? ""),
                                Text(category.name),
                                SizedBox(height: 20),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    addCategoryBottomSheet(category);
                                  },
                                  label: Text("Update"),
                                ),
                              ],
                            ),
                          );

                          // ListTile(
                          //   leading: Text(category.code ?? ""),
                          //   title: Text(category.name),
                          //   trailing: OutlinedButton(
                          //     onPressed: () {
                          //       addCategoryBottomSheet(category.id);
                          //     },
                          //     child: Text("Update"),
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
        ),
      ),
    );
  }
}
