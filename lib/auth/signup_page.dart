// ignore_for_file: prefer_final_fields

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../firestore/firestore.dart';


class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignupPage({super.key, required this.showLoginPage});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pswdController = TextEditingController();
  final confirmPswdController = TextEditingController();
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    pswdController.dispose();
    confirmPswdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'SIGN UP',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: 'Your Name',
                          prefixIcon: const Icon(Icons.person),
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
                    ),
                  ),
                  const SizedBox(height: 15,),
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
                      obscureText: obscurePassword1,
                      decoration: InputDecoration(
                          hintText: 'Set a Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: obscurePassword1 ?
                          IconButton(
                              icon:const Icon(Icons.visibility_rounded),
                              onPressed: (){setState(() {
                                obscurePassword1 = !obscurePassword1;
                              });
                              }) : IconButton(
                                icon:const Icon(Icons.visibility_off_rounded),
                                onPressed: (){setState(() {
                                  obscurePassword1 = !obscurePassword1;
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: confirmPswdController,
                      obscureText: obscurePassword2,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: obscurePassword2 ?
                          IconButton(
                              icon:const Icon(Icons.visibility_rounded),
                              onPressed: (){setState(() {
                                obscurePassword2 = !obscurePassword2;
                              });
                              }) : IconButton(
                              icon:const Icon(Icons.visibility_off_rounded),
                              onPressed: (){setState(() {
                                obscurePassword2 = !obscurePassword2;
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
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: GestureDetector(
                      onTap:() {signUp(context, nameController.text.trim(),emailController.text.trim(),pswdController.text.trim(),confirmPswdController.text.trim());},
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
                            'Sign up',
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
                          width: MediaQuery.of(context).size.width * 0.3,
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
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue with ',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/google.jpg'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a member?',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          ' Login',
                          style: TextStyle(
                              color: Color.fromRGBO(47, 37, 245, 1),
                              fontWeight: FontWeight.w800,
                              fontSize: 18
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
    );
  }
}
