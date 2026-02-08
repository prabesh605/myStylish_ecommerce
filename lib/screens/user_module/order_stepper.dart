import 'package:flutter/material.dart';
import 'package:stylish_ecommerce/constant/order_status.dart';
import 'package:stylish_ecommerce/models/order_model.dart';

class OrderStepper extends StatefulWidget {
  const OrderStepper({super.key, required this.order});
  final OrderModel order;

  @override
  State<OrderStepper> createState() => _OrderStepperState();
}

class _OrderStepperState extends State<OrderStepper> {
  int getStepIndex(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.processing:
        return 1;
      case OrderStatus.shipped:
        return 2;
      case OrderStatus.completed:
        return 3;
      case OrderStatus.cancelled:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stepper(
              currentStep: getStepIndex(widget.order.status),
              controlsBuilder: (context, index) =>
                  SizedBox(child: Text("----")),
              steps: [
                Step(
                  isActive: getStepIndex(widget.order.status) >= 0,
                  title: Text("Pending"),
                  content: SizedBox(),
                ),
                Step(
                  isActive: getStepIndex(widget.order.status) >= 1,
                  title: Text("Processing"),
                  content: SizedBox(),
                ),
                Step(
                  isActive: getStepIndex(widget.order.status) >= 2,
                  title: Text("Shipped"),
                  content: SizedBox(),
                ),
                Step(
                  isActive: getStepIndex(widget.order.status) >= 3,
                  title: Text("Completed"),
                  content: SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
