import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_ecommerce/models/category_model.dart';
import 'package:stylish_ecommerce/models/product_model.dart';

class FirebaseService {
  final CollectionReference categoryCollection = FirebaseFirestore.instance
      .collection('categories');
  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection('products');
  Future<void> addCategory(CategoryModel category) async {
    try {
      await categoryCollection.add(category.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final response = await categoryCollection.get();
    return response.docs
        .map(
          (e) => CategoryModel.fromJson(e.data() as Map<String, dynamic>, e.id),
        )
        .toList();
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      await categoryCollection.doc(category.id).update(category.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await productCollection.add(product.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> getAllProduct() async {
    final response = await productCollection.get();
    return response.docs
        .map(
          (e) => ProductModel.fromJson(e.data() as Map<String, dynamic>, e.id),
        )
        .toList();
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await productCollection.doc(product.id).update(product.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
