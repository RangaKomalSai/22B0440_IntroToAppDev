import 'package:expense_tracker/widgets/card.dart';
import 'package:expense_tracker/widgets/line_chart.dart';
import 'package:expense_tracker/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../firestore/firestore.dart';
import '../widgets/drop_down.dart';
import 'home.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
bool? isItIncome;

class AddExpense extends StatefulWidget {
  final VoidCallback callback;
  const AddExpense({super.key, required this.callback});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController transactionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    amountController.dispose();
    descriptionController.dispose();
    transactionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //AlertBox
    void showAlertDialog(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(47, 37, 245, 1),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 1.0,
              backgroundColor: const Color.fromRGBO(27, 131, 129, 1),
              centerTitle: true,
              title: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Tooltip(
                      message: 'Back',
                      child: Icon(
                        Icons.arrow_back_ios,
                        semanticLabel: 'Back',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  const Text(
                    'Add Amount',
                    style: TextStyle(
                      fontFamily: 'Josfie',
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                      child: DropDown(
                        data: const [
                          'Income', 'Expense'
                        ],
                        hint: 'Transaction Type',
                        textEditingController: transactionController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                      child: MyTextField(
                          controller: amountController,
                          textInputAction: TextInputAction.next,
                          labelText: 'Enter Amount',
                          textInputType: TextInputType.phone,
                          prefixIcon: const Icon(
                              Icons.currency_rupee,
                              color: Colors.black,
                            )
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                      child: MyTextField(
                          controller: descriptionController,
                          textInputAction: TextInputAction.next,
                          labelText: 'Description',
                          textCapitalization: TextCapitalization.sentences,
                          )
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          if(int.tryParse(amountController.text.trim()) == null)  {
                            showAlertDialog(context, 'Please enter correct amount value.');
                          } else if(amountController.text.isEmpty || descriptionController.text.isEmpty || transactionController.text.isEmpty){
                            showAlertDialog(context,'Please enter a value in all the fields.');
                          } else {
                            calculateBalanceData();
                            // cardList.add(MyCard(amount: amountController.text.trim(), description: descriptionController.text.trim(), transaction: transactionController.text=='Income'));
                            addCard(amountController.text.trim(), descriptionController.text.trim(), transactionController.text=='Income');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            ).then((value) {
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            });
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(27, 131, 129, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21.0), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40)
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
