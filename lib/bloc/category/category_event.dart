import 'package:stylish_ecommerce/models/category_model.dart';

abstract class CategoryEvent {}

class AddCategory extends CategoryEvent {
  CategoryModel category;
  AddCategory(this.category);
}

class GetCategories extends CategoryEvent {}
