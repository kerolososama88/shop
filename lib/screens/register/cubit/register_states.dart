
import '../../../models/login_model.dart';

abstract class RegisterState{}

class RegisterInitalState extends RegisterState{}

class RegisterLoadinglState extends RegisterState{}

class RegisterSuccessState extends RegisterState{
   final ShopLoginModel shopLoginModel;

  RegisterSuccessState(this.shopLoginModel);
}
class RegisterErrorState extends RegisterState{
  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterState{}