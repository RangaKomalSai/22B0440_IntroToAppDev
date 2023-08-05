// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../firestore/firestore.dart';
import '../screens/home.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignupPage;
  const LoginPage({super.key, required this.showSignupPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pswdController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    pswdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100,),
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email_rounded),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: const BorderSide(color: Color.fromRGBO(47, 37, 245, 1), width: 2)
                            ),
                            fillColor: Colors.grey[100],
                            filled: true
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) => email != null && !EmailValidator.validate(email)? 'Enter a valid email' : null,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: pswdController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: obscurePassword ?
                            IconButton(
                                icon:const Icon(Icons.visibility_rounded),
                                onPressed: (){setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                                }) : IconButton(
                                  icon:const Icon(Icons.visibility_off_rounded),
                                onPressed: (){setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                                  }),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: const BorderSide(color: Colors.white)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: const BorderSide(color: Color.fromRGBO(47, 37, 245, 1), width: 2)
                            ),
                            fillColor: Colors.grey[100],
                            filled: true
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6 ? 'Enter min. 6 characters' : null,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: GestureDetector(
                        onTap: (){
                          final isValid = formKey.currentState!.validate();
                          if(!isValid)return;

                          signIn(context, emailController.text.trim(), pswdController.text.trim());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(47, 37, 245, 1),
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Container(
                            height: 3,
                            width: MediaQuery.of(context).size.width * 0.35,
                            color: Colors.grey,
                          ),
                          const Text(
                            ' OR ',
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                          Container(
                            height: 3,
                            width: MediaQuery.of(context).size.width * 0.35,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/google.jpg'),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.showSignupPage,
                          child: const Text(
                            ' Create Now',
                            style: TextStyle(
                                color: Color.fromRGBO(47, 37, 245, 1),
                                fontWeight: FontWeight.w800,
                                fontSize: 16
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}