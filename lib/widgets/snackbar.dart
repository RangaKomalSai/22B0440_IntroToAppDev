import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget {
  final String message;
  const MySnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(21),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

void showMySnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: MySnackBar(message: message),
      duration: const Duration(seconds: 2),
    ),
  );
}


