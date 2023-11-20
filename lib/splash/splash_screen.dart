import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/layOut/shoop_app/shop_layout.dart';
import 'package:untitled5/remote/cache_helper.dart';
import 'package:untitled5/screens/login/screen/shop_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn=false;
  late CachedNetworkImage image;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      _navigateUser();
    });
  }
  void _navigateUser() async {
    String? token = await CacheHelper.getData(key: 'token');
    // SharedPreferences prefs = await SharedPreferences.getInstance();
   bool? isLoggedIn =await CacheHelper.getData(key: 'isLoggedIn');
    if(isLoggedIn!){
      if(token!=null){
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const ShopLayOut()));
      }
    }else{
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ShopLoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      AnimatedSplashScreen(
      splashIconSize: 300,
        splashTransition: SplashTransition.fadeTransition,
        splash:CachedNetworkImage(
          imageUrl: 'https://img.freepik.com/free-vector/cartoon-style-cafe-front-shop-view_134830-697.jpg',
        width: double.infinity,
          height: 300,
        ) ,
        nextScreen:const ShopLayOut() ,
    );
  }
}
