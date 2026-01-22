import 'package:stylish_ecommerce/models/category_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  List<CategoryModel> categories;
  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  String error;
  CategoryError(this.error);
}
