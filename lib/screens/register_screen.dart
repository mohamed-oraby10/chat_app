import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/widgets/field.dart';
import 'package:chat_app/screens/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String id = "registerScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                      isLoading = true;
                      setState(() {
                        
                      });
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, ChatScreen.id);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == "weak-password") {
                          showSnackBar(context, "weak password");
                        } else if (ex.code == "email-already-in-use") {
                          showSnackBar(context, "email already is used");
                        }
                      }
                        setState(() {
                        
                      });
                      isLoading = false;
                    

                    } else {}
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
  }

 
  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}