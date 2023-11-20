import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/layOut/shoop_app/cubit/cubit.dart';
import 'package:untitled5/remote/cache_helper.dart';
import 'package:untitled5/remote/dio_helper.dart';
import 'package:untitled5/screens/login/screen/shop_login_screen.dart';
import 'package:untitled5/shop_app/on_boarding/on_boarding_screen.dart';
import 'constans/componant.dart';
import 'layOut/shoop_app/cubit/states.dart';
import 'layOut/shoop_app/shop_layout.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = await CacheHelper.getData(key: 'OnBoarding');
  String? token = await CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    // ignore: unnecessary_null_comparison
    if (token != null) {
      widget = const ShopLayOut();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({
    super.key,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(ShopInitialState())
        ..getUserData()
        ..getFavorites()
        ..updateUserData(
          name: 'name',
          phone: 'phone',
          email: 'email',
        ),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home:startWidget,
      ),
    );
  }
}
