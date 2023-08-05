
import 'package:expense_tracker/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

User? user = FirebaseAuth.instance.currentUser;

Future signOut() async{
  await FirebaseAuth.instance.signOut();
}


Future signUp(BuildContext context,String name,String email, String password, String confirmPassword) async{
  if (password != confirmPassword) {
    showMySnackBar(context, "Passwords do not match.");
    return;
  }
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    // addUserDetails(nameController.text.trim());
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'Name' : name,
    });
    addSubCollection(userCredential.user!.uid);
  } on FirebaseAuthException catch (ex){
      showMySnackBar(context, ex.code.toString());
  }
}

Future signIn(BuildContext context, String email, String password) async{
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  }on FirebaseAuthException catch (ex){
    showMySnackBar(context, ex.code.toString());
  }
}

Future<void> addSubCollection(String userId) async{
  FirebaseFirestore.instance.collection('users').doc(userId).collection('Transactions');
}

Future<void> addTransactionToDB(String userId,String amount, String description, bool type,String uniqueId) async{
  // CollectionReference usersCollection = FirebaseFirestore.instance.collection('users').doc(userId).collection('Transactions');
  // DocumentReference docref = FirebaseFirestore.instance.collection('users').doc(userId).collection('Transactions').doc(newKey.toString());
  // DocumentReference docRef = await usersCollection.add({
  //   'amount': amount,
  //   'description': description,
  //   'type': type ? 'Income' : 'Expense'
  // });

  DocumentReference newDocRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('Transactions').doc(uniqueId);
  newDocRef.set(
      {
        'amount': amount,
        'description': description,
        'type': type ? 'Income' : 'Expense',
        'id': uniqueId
      });

  // String transactionId = newDocRef.id;
  // await newDocRef.update({'transactionId': transactionId});
}
