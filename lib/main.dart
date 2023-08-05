import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/start_page.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyDDPSy2QAY5kFz4yl9ZYMDKpm0N1P8TC44", appId: "1:232841560260:web:5b402520eaac64602a0991", messagingSenderId: "232841560260", projectId: "expense-tracker-bb04e"));
  }
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Tracker',
      theme: ThemeData(
          fontFamily: 'NotoSans',
          scaffoldBackgroundColor: const Color.fromRGBO(222, 222, 222,1)
      ),
      home: const StartPage(),
    );
  }
}
