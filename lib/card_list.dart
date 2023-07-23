// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'add_expenses.dart';
import 'drop_down.dart';

List<MyCard> cardList = [];
bool plusOrMinus = false;

class MyCard extends StatelessWidget {
  final String amount;
  final String description;
  final bool transaction;
  final bool posOrNeg;
  const MyCard({ required this.amount, required this.description, this.transaction = false, this.posOrNeg = false});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.none,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              child : Card(
                elevation: 0.0,
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(28, 10, 28, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Sets a border radius of 10.0
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                      child: Text(
                        description,
                        style: TextStyle(
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
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
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
      ),
    );
  }
}

