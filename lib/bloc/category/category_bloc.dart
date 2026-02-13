import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/category/category_event.dart';
import 'package:stylish_ecommerce/bloc/category/category_state.dart';
import 'package:stylish_ecommerce/models/category_model.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  FirebaseService service;
  CategoryBloc(this.service) : super(CategoryInitial()) {
    on<AddCategory>((event, emit) async {
      emit(CategoryLoading());
      await service.addCategory(event.category);
      final List<CategoryModel> categories = await service.getAllCategories();
      emit(CategoryLoaded(categories));
    });
    on<GetCategories>((event, emit) async {
      emit(CategoryLoading());
      final List<CategoryModel> categories = await service.getAllCategories();
      emit(CategoryLoaded(categories));
    });
    on<UpdateCategory>((event, emit) async {
      emit(CategoryLoading());
      await service.updateCategory(event.category);
      final List<CategoryModel> categories = await service.getAllCategories();
      emit(CategoryLoaded(categories));
    });
  }
}
