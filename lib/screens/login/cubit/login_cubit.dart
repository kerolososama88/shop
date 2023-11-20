import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled5/models/login_model.dart';
import 'package:untitled5/network/end_point.dart';
import 'package:untitled5/screens/login/cubit/login_states.dart';
import '../../../constans/constans_buttom.dart';
import '../../../layOut/shoop_app/shop_layout.dart';
import '../../../remote/cache_helper.dart';
import '../../../remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(super.initialState);

  static LoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) {
   // String token = CacheHelper.getData(key: 'token');
    emit(LoginLoadinglState());
    try{
      DioHelper.postData(
          url: LOGIN, data: {
        'email': email,
        'password': password,
      }).then((value) {
        if (value.data['status'] = true) {
          loginModel = ShopLoginModel.fromJson(value.data);
          CacheHelper.saveData(
            key: 'token',
            value: loginModel!.data!.token ,
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=> const ShopLayOut(),
            ),
          );
          emit(LoginSuccessState(loginModel!));
        } else {
          Fluttertoast.showToast(
              msg: value.data['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
             backgroundColor: chooseToastColor(ToastState.ERROR),
              textColor: Colors.white,
              fontSize: 16.0,
          );
        }
      });
    }catch (e){
      emit(LoginErrorState(e.toString()));
    }
  }

  Icon suffix = const Icon(Icons.visibility);
  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(LoginChangePasswordVisibilityState());
  }

  Widget suffixWidget() {
    return isPassword
        ? IconButton(
            icon: const Icon(Icons.visibility_off),
            onPressed: () => changePasswordVisibility(),
          )
        : IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () => changePasswordVisibility(),
          );
  }
}
