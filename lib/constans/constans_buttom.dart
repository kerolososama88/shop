import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../layOut/shoop_app/cubit/cubit.dart';
import '../styels/color.dart';

Widget defaultButtom({
  double width = double.infinity,
  required Function() function,
  required Color color,
  required String text,
  required Color background,
  bool isUpperCase = true,
}) =>
    Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required  controller,
  required String text,
  required Color color,
  required IconData prefixIcon ,
   required validator,

})=>Container(
  decoration: BoxDecoration(
    border: Border.all(width: 1.2,color: Colors.grey),
    borderRadius: const BorderRadius.all(Radius.circular(15)),
  ),
  child:TextFormField(
    controller:controller,
    decoration:InputDecoration(
      labelText: text,
      prefixIcon: Icon(prefixIcon),
    ),
  ),
);

Widget defaultTextButtom({
  required Function() function,
  required String text,
  required Color color,
}) =>
    TextButton(onPressed: function,
        child: Text(text,
      style: TextStyle(
      color: color,
    ),));

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0,
    );

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}


