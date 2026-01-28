import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/cart/cart_event.dart';
import 'package:stylish_ecommerce/bloc/cart/cart_state.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final FirebaseService service;
  CartBloc(this.service) : super(CartInitial()) {
    on<GetCart>((event, emit) async {
      emit(CartLoading());
      final carts = await service.getAllCart();
      emit(CartLoaded(carts));
    });
    on<AddCart>((event, emit) async {
      emit(CartLoading());
      await service.addCart(event.cart);
      final carts = await service.getAllCart();
      emit(CartLoaded(carts));
    });
  }
}
