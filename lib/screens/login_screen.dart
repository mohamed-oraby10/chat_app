import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/blocs/auth_cubit/auth_bloc.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/widgets/main_button.dart';
import 'package:chat_app/screens/widgets/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    bool isLoading = false;
    GlobalKey<FormState> formKey = GlobalKey();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatScreen.id);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kMainColor,
            body: Padding(
              padding: const EdgeInsets.only(top: 32, left: 8, right: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Image.asset(
                      "assets/images/maxresdefault-removebg-preview.png",
                      width: 300,
                      height: 150,
                    ),
                    Center(
                      child: Text(
                        "Scholar Chat",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    Field(
                      hintName: "Email",
                      onChanged: (data) {
                        email = data;
                      },
                    ),

                    Field(
                      hintName: "Password",
                      onChanged: (data) {
                        password = data;
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: 10),

                    MainButton(
                      buttonText: "Log In",
                      onPress: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(
                            context,
                          ).add(LoginEvent(email: email!, password: password!));
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "don\'t have an account?",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
