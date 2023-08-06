import 'package:expense_tracker/widgets/card.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Settings',
              style: TextStyle(
                  fontFamily: 'Josfie',
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
              ),
            ),
            elevation: 0,
            backgroundColor: Color.fromRGBO(27, 131, 129, 1),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete All'),
                          content: const Text('Do you want to Delete all transactions?'),
                          actions: [
                            TextButton(
                              onPressed: () async{
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                for(int i=0; i < cardList.length; i++){
                                  removeCard(i);
                                }
                                Navigator.popUntil(context, (route) => route.isFirst);
                              },
                              child: const Text('Yes', style: TextStyle(color: Colors.red),),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  leading: Icon(Icons.delete, color: Colors.grey[700],),
                  title: Text(
                    'Delete all Transactions',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700]
                    ),
                  ),
                  horizontalTitleGap: 1,
                  titleAlignment: ListTileTitleAlignment.center,
                ),
              ],
            ),
          ),
        )
    );
  }
}
