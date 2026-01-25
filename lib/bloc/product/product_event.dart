import 'package:stylish_ecommerce/models/product_model.dart';

abstract class ProductEvent {}

class GetProduct extends ProductEvent {}

class AddProduct extends ProductEvent {
  final ProductModel product;
  AddProduct(this.product);
}

class UpdateProduct extends ProductEvent {
  final ProductModel product;
  UpdateProduct(this.product);
}
