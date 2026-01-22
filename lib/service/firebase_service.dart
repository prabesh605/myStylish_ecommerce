import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_ecommerce/models/category_model.dart';

class FirebaseService {
  final CollectionReference categoryCollection = FirebaseFirestore.instance
      .collection('categories');
  Future<void> addCategory(CategoryModel category) async {
    await categoryCollection.add(category.toJson());
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final response = await categoryCollection.get();
    return response.docs
        .map(
          (e) => CategoryModel.fromJson(e.data() as Map<String, dynamic>, e.id),
        )
        .toList();
  }
}
