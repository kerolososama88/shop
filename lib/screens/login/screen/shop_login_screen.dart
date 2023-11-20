import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/constans/constans_buttom.dart';
import '../../../styels/color.dart';
import '../../register/screen/register_screen.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';

class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({super.key});
  var emailConteroller = TextEditingController();
  var passwordConteroller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(LoginInitalState()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              showToast(
                text: state.loginModel.message,
                state: ToastState.SUCCESS,
              );
            } else {
              showToast(
                text: state.loginModel.message,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailConteroller,
                          decoration: const InputDecoration(
                            label: Text('Email Address'),
                            prefix: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your emil address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordConteroller,
                          obscureText:
                          LoginCubit.get(context).isPassword ? true : false,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            prefix: const Icon(Icons.lock),
                            suffix: LoginCubit.get(context).suffixWidget(),
                          ),
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                context: context,
                                email: emailConteroller.text,
                                password: passwordConteroller.text,
                              );
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          //لو ب لودنج هيظهر ال فول باك
                          condition: state is! LoginLoadinglState,
                          builder: (context) => defaultButtom(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  context: context,
                                  email: emailConteroller.text,
                                  password: passwordConteroller.text,
                                );
                              }
                            },
                            color: Colors.white,
                            text: 'LOGIN',
                            background: defaultColor,
                          ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Don not have an account?',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            defaultTextButtom(
                              function: () {
                                print('object');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>  ShopRegisterScreen()));
                              },
                              text: 'Register', color: defaultColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
