import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/product/product_event.dart';
import 'package:stylish_ecommerce/bloc/product/product_state.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseService service;
  ProductBloc(this.service) : super(ProductInitial()) {
    on<GetProduct>((event, emit) async {
      emit(ProductLoading());
      final products = await service.getAllProduct();
      emit(ProductLoaded(products));
    });
    on<AddProduct>((event, emit) async {
      emit(ProductLoading());
      await service.addProduct(event.product);
      final products = await service.getAllProduct();
      emit(ProductLoaded(products));
    });
    on<UpdateProduct>((event, emit) async {
      emit(ProductLoading());
      await service.updateProduct(event.product);
      final products = await service.getAllProduct();
      emit(ProductLoaded(products));
    });
  }
}
