import 'package:untitled5/models/login_model.dart';

abstract class LoginState{}

class LoginInitalState extends LoginState{}

class LoginLoadinglState extends LoginState{}

class LoginSuccessState extends LoginState{
   final ShopLoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginState{
  final String error;

  LoginErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginState{}