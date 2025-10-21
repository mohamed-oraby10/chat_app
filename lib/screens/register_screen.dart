import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/widgets/field.dart';
import 'package:chat_app/screens/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static String id = "registerScreen";

  @override
  Widget build(BuildContext context) {
    String? email;

    String? password;

    bool isLoading = false;

    GlobalKey<FormState> formKey = GlobalKey();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatScreen.id);
          isLoading = false;
        } else if (state is RegisterFailure) {
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
                          "Register",
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
                      buttonText: "Sign Up",
                      onPress: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(
                            context,
                          ).registerUser(email: email!, password: password!);
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "already have an account?",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Log In",
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
