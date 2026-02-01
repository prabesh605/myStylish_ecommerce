import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_event.dart';
import 'package:stylish_ecommerce/bloc/auth/auth_state.dart';
import 'package:stylish_ecommerce/service/firebase_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseService service;
  AuthBloc(this.service) : super(AuthInitial()) {
    on<Login>((event, emit) async {
      emit(AuthLoading());
      final user = await service.loginUserWithEmailPassword(event.user);
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthError());
      }
    });
    on<SignUp>((event, emit) async {
      emit(AuthLoading());
      final user = await service.createUserWithEmailPassword(event.user);
      if (user != null) {
        await service.addUser(event.user);
        emit(AuthSuccess());
      } else {
        emit(AuthError());
      }
    });
  }
}
