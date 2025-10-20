import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/widgets/main_button.dart';
import 'package:chat_app/screens/widgets/field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
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
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        print(
                          "FirebaseAuthException: ${ex.code} - ${ex.message}",
                        );

                        if (!mounted) return;

                        switch (ex.code) {
                          case 'user-not-found':
                            showSnackBar(context, 'User not found');
                            break;
                          case 'wrong-password':
                            showSnackBar(context, 'Wrong password');
                            break;
                          case 'invalid-credential':
                            showSnackBar(context, 'Invalid email or password');
                            break;
                          case 'invalid-email':
                            showSnackBar(context, 'Invalid email format');
                            break;
                          default:
                            showSnackBar(
                              context,
                              'Authentication error: ${ex.message ?? 'Unknown error'}',
                            );
                        }
                      }

                      setState(() {});
                      isLoading = false;
                    } else {}
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
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
