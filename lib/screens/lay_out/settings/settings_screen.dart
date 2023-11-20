import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/constans/componant.dart';
import 'package:untitled5/constans/constans_buttom.dart';
import 'package:untitled5/layOut/shoop_app/cubit/cubit.dart';
import 'package:untitled5/layOut/shoop_app/cubit/states.dart';
import 'package:untitled5/styels/color.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 25,
                  ),
                  defaultFormField(
                    controller: nameController,
                    color: Colors.white,
                    prefixIcon: Icons.person,
                    text: 'Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  defaultFormField(
                    controller: emailController,
                    color: Colors.white,
                    prefixIcon: Icons.email,
                    text: 'Email',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    color: Colors.white,
                    prefixIcon: Icons.phone,
                    text: 'Phone',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  defaultButtom(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
                    },
                    color: Colors.white,
                    text: 'UPDATE',
                    background: defaultColor,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  defaultButtom(
                    function: () {
                      singOut(context);
                    },
                    color: Colors.white,
                    text: 'LOGOUT',
                    background: defaultColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}