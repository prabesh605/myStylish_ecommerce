import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/orders/order_event.dart';
import 'package:stylish_ecommerce/bloc/orders/order_state.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final FirebaseService service;
  OrderBloc(this.service) : super(OrderInitial()) {
    on<AddOrder>((event, emit) async {
      emit(OrderLoading());
      await service.addOrder(event.order);
      final orders = await service.getAllOrder();
      emit(OrderLoaded(orders));
    });
    on<GetOrder>((event, emit) async {
      emit(OrderLoading());
      final orders = await service.getAllOrder();
      emit(OrderLoaded(orders));
    });
    on<GetMyOrder>((event, emit) async {
      emit(OrderLoading());
      final orders = await service.getMyOrder();
      emit(OrderLoaded(orders));
    });
    on<UpdateOrder>((event, emit) async {
      emit(OrderLoading());
      await service.updateOrder(event.order);
      final orders = await service.getAllOrder();
      emit(OrderLoaded(orders));
    });
  }
}
