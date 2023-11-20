import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled5/layOut/shoop_app/shop_layout.dart';
import 'package:untitled5/models/login_model.dart';
import 'package:untitled5/network/end_point.dart';
import 'package:untitled5/screens/register/cubit/register_states.dart';
import '../../../constans/constans_buttom.dart';
import '../../../remote/cache_helper.dart';
import '../../../remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(super.initialState);

  static RegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadinglState());
    try {
      DioHelper.postData(url: REGISTER, data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      }).then((value) {
        if (value.data['status'] = true) {
          loginModel = ShopLoginModel.fromJson(value.data);
          CacheHelper.saveData(
            key: 'token',
            value: loginModel!.data!.token,
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=> const ShopLayOut(),
            ),
          );
          emit(RegisterSuccessState(loginModel!));
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
    }catch (error) {
      emit(RegisterErrorState(error.toString()));
    }
  }

  Icon suffix = const Icon(Icons.visibility);
  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(RegisterChangePasswordVisibilityState());
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
