import 'package:stylish_ecommerce/models/user_model.dart';

abstract class UserEvent {}

class GetUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final UserModel user;
  UpdateUser(this.user);
}
