import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firestore/firestore.dart';
import '../widgets/snackbar.dart';

class GoogleButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  const GoogleButton({super.key, this.isLoading = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              ),
              backgroundColor: const Color.fromRGBO(47, 37, 245, 1),
            ),
            onPressed: onPressed,
            icon: isLoading ? const SizedBox(): const Image(image: AssetImage('assets/google.jpg'),width: 24,height: 24,),
            label: isLoading ? const LoadingButton() : const Text(' Sign in with Google', style: TextStyle(fontFamily: 'Ubuntu',fontSize: 18),)
        ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: Colors.white,),
        ),
        SizedBox(width: 10,),
        Text('Loading...')
      ],
    );
  }
}

final isGoogleLoading = false.obs;

Future<void> googleSignIn(BuildContext context) async{
  try{
    isGoogleLoading.value = true;
    final UserCredential userCredential = await signInWithGoogle(context);
    final User user = userCredential.user!;
    userName = user.displayName ?? 'GUEST';
    isGoogleLoading.value = false;
  } catch (e){
    isGoogleLoading.value = false;
    // showMySnackBar(context, e.toString());
    showMySnackBar(context, 'Error, Please try again!');
  }
}