import 'package:stylish_ecommerce/constant/order_status.dart';
import 'package:stylish_ecommerce/models/cart_model.dart';

class OrderModel {
  String? id;
  String userId;
  String userName;
  int items;
  double total;
  OrderStatus status;
  List<CartModel> carts;

  OrderModel({
    this.id,
    required this.userId,
    required this.userName,
    required this.items,
    required this.total,
    required this.carts,
    required this.status,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json, String id) {
    return OrderModel(
      id: id,
      userId: json['userId'],
      userName: json['userName'] ?? "",
      items: json['items'],
      total: json['total'],
      status: OrderStatusHelper.toOrderStatus(json['status']),
      carts: (json['carts'] as List)
          .map((e) => CartModel.fromJson(e as Map<String, dynamic>, e['id']))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    "userId": userId,
    "userName": userName,
    "items": items,
    "total": total,
    "status": OrderStatusHelper.toStringValue(status),
    "carts": carts.map((e) => e.toJson()).toList(),
  };
}
