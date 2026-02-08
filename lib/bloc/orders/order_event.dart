import 'package:stylish_ecommerce/models/order_model.dart';

abstract class OrderEvent {}

class AddOrder extends OrderEvent {
  final OrderModel order;
  AddOrder(this.order);
}

class GetOrder extends OrderEvent {}

class GetMyOrder extends OrderEvent {}

class UpdateOrder extends OrderEvent {
  final OrderModel order;
  UpdateOrder(this.order);
}
