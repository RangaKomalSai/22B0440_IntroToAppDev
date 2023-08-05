import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';
import 'auth_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something gone wrong! Please try again!'),);
            } else if (snapshot.hasData) {
              final user = snapshot.data;
              return FutureBuilder<String?>(
                // future: getUserName(), // Call the function to get the user's name from Firestore
                builder: (context, nameSnapshot) {
                  if (nameSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final userName = nameSnapshot.data ?? ''; // Get the user's name or an empty string if it's not available
                    return Home(userName: user!.uid,); // Pass the user's name to the HomeScreen widget
                  }
                },
              );
            } else {
              return const AuthPage();
            }
          }
      ),
    );
  }
}
