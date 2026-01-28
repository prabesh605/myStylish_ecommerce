import 'package:stylish_ecommerce/models/cart_model.dart';

abstract class CartEvent {}

class GetCart extends CartEvent {}

class AddCart extends CartEvent {
  final CartModel cart;
  AddCart(this.cart);
}

class UpdateCart extends CartEvent {}
