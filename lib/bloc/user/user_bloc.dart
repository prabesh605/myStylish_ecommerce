import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/user/user_event.dart';
import 'package:stylish_ecommerce/bloc/user/user_state.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  FirebaseService service;
  UserBloc(this.service) : super(UserInitial()) {
    on<GetUser>((event, emit) async {
      emit(UserLoading());
      final user = await service.getUser();
      emit(UserLoaded(user));
    });
    on<UpdateUser>((event, emit) async {
      emit(UserLoading());
      await service.updateUser(event.user);
      // emit(UserSuccess());
      final user = await service.getUser();
      emit(UserLoaded(user));
    });
    on<ChangePassword>((event, emit) async {
      emit(UserLoading());
      await service.changePassword(event.currentPassword, event.newPassword);
      emit(UserSuccess());
      // final user = await service.getUser();
      // emit(UserLoaded(user));
    });
  }
}
