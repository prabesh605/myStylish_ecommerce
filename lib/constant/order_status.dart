enum OrderStatus { pending, processing, shipped, completed, cancelled }

class OrderStatusHelper {
  static String toStringValue(OrderStatus status) {
    return status.name;
  }

  static OrderStatus toOrderStatus(String value) {
    return OrderStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => OrderStatus.pending,
    );
  }
}
