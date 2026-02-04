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
        final userData = await service.getUser();
        if (userData != null) {
          emit(AuthSuccess(userData.role));
        }
      } else {
        emit(AuthError("User is Null"));
      }
    });
    on<SignUp>((event, emit) async {
      emit(AuthLoading());
      final user = await service.createUserWithEmailPassword(event.user);
      if (user != null) {
        await service.addUser(event.user);

        emit(AuthSuccess(""));
      } else {
        emit(AuthError("User is Null"));
      }
    });
    on<Logout>((event, emit) async {
      emit(AuthLoading());
      await service.userLogout();
      emit(AuthSuccess(""));
    });
  }
}
