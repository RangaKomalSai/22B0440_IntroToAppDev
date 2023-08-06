import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/home.dart';

List<MyCard> cardList = [];

class MyCard extends StatelessWidget {
  final String amount;
  final String description;
  final bool transaction;
  final String uniqueId;
  final int dateAdded;

  const MyCard({super.key, required this.amount, required this.description, required this.transaction, required this.uniqueId, required this.dateAdded});


  @override
  Widget build(BuildContext context) {

    return Dismissible(
      key: ValueKey<String>(uniqueId),
      direction: DismissDirection.none,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70.0,
            width: MediaQuery.of(context).size.width,
            child : Card(
              elevation: 0.0,
              color: const Color.fromRGBO(255, 255, 255, 0.5),
              margin: const EdgeInsets.fromLTRB(28, 10, 28, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Sets a border radius of 10.0
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          transaction ? Icons.add : Icons.remove,
                          size: 15,
                          color: transaction ? Colors.green : Colors.red,
                        ),
                        Icon(
                          Icons.currency_rupee,
                          color: transaction ? Colors.green : Colors.red,
                          size: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                          child: Text(
                            NumberFormat.decimalPattern().format(int.parse(amount)),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: transaction ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void removeCard(index) async{
  String cardKey = cardList[index].uniqueId;
  int newAmount =int.parse(cardList[index].amount);
  cardList[index].transaction ? expensesTotal -= newAmount : expensesTotal += newAmount ;
  cardList[index].transaction ? income -= newAmount : expense += newAmount;
  cardList.removeAt(index);
  await FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('Transactions').doc(cardKey).delete();
}

void addCard(String amount, String description, bool transaction) async{

  DateTime currentTime = DateTime.now();
  String uniqueId = currentTime.microsecondsSinceEpoch.toString();
  transaction ? expensesTotal += int.parse(amount) : expensesTotal -= int.parse(amount);
  transaction ? income += int.parse(amount) : expense -= int.parse(amount);
  cardList.add(MyCard(amount: amount, description: description, transaction: transaction, uniqueId: uniqueId, dateAdded: currentTime.day,));
  addTransactionToDB(user!.uid, amount, description, transaction, uniqueId);
}