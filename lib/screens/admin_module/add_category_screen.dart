import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/category/category_bloc.dart';
import 'package:stylish_ecommerce/bloc/category/category_event.dart';
import 'package:stylish_ecommerce/bloc/category/category_state.dart';
import 'package:stylish_ecommerce/models/category_model.dart';
import 'package:stylish_ecommerce/service/image_service.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  ImageService imageService = ImageService();
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
                  onPressed: () {
                    imageService.pickImageFromCamera();
                  },
                  label: Text("Camera"),
                  icon: Icon(Icons.camera),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    imageService.pickImageFromGallery();
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

  void addCategoryBottomSheet() {
    final categoryNameController = TextEditingController();
    final imageController = TextEditingController();
    final codeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add Category"),
              SizedBox(height: 20),
              TextFormField(
                controller: categoryNameController,
                decoration: InputDecoration(
                  label: Text("Category Name"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: imageController,
                      decoration: InputDecoration(
                        label: Text("Image"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      chooseImageUploadOption();
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
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  final category = CategoryModel(
                    name: categoryNameController.text,
                    image: imageController.text,
                    code: codeController.text,
                  );
                  context.read<CategoryBloc>().add(AddCategory(category));
                },
                child: Text(
                  "Add Category",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
            ],
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
          addCategoryBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          context.read<CategoryBloc>().add(GetCategories());
          return Future.delayed(Duration(seconds: 1));
        },
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
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          leading: Text(category.code ?? ""),
                          title: Text(category.name),
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
    );
  }
}
