import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/add_expense.dart';

class MyDrawer extends StatelessWidget {
  final String userName;
  const MyDrawer({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: const Color.fromRGBO(27, 131, 129, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/avatar.jpg')
                        )
                    ),
                    height: 80,
                  ),
                  const SizedBox(height: 15,),
                  Text(
                    'Hello, $userName!',
                    style: const TextStyle(
                        fontSize: 25
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Total Income : ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        color: Colors.green
                    ),
                  ),
                  Icon(Icons.currency_rupee_rounded, color: Colors.green,size: 18,),
                  Text(
                    '20000',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        color: Colors.green
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Total Expense : ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        color: Colors.red
                    ),
                  ),
                  Icon(Icons.currency_rupee_rounded, color: Colors.red,size: 18,),
                  Text(
                    '20000',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        color: Colors.red
                    ),
                  )
                ],
              ),
            ),
            const Expanded(child: DrawerList()),
          ],
        ),
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            ListTile(
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddExpense(callback: (){},)
                ),
                );
              },
              leading: Icon(Icons.add, color: Colors.grey[700],),
              title: Text(
                'Add Transaction',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700]
                ),
              ),
              horizontalTitleGap: 1,
              titleAlignment: ListTileTitleAlignment.center,
            ),
            ListTile(
              leading: Icon(Icons.bar_chart_rounded, color: Colors.grey[700],),
              title: Text(
                'Statistics',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700]
                ),
              ),
              horizontalTitleGap: 1,
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.star_rate_rounded, color: Colors.grey[700],),
              title: Text(
                'Rate App',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700]
                ),
              ),
              horizontalTitleGap: 1,
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.grey[700],),
              title: Text(
                'Share App',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700]
                ),
              ),
              horizontalTitleGap: 1,
            ),
            ListTile(
              leading: Icon(Icons.info_outline_rounded, color: Colors.grey[700],),
              title: Text(
                'About Us',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700]
                ),
              ),
              horizontalTitleGap: 1,
            ),
            ListTile(
              onTap: ()async {await FirebaseAuth.instance.signOut();},
              leading: Icon(Icons.logout_rounded, color: Colors.grey[700],),
              title: Text(
                'Log out',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700]
                ),
              ),
              horizontalTitleGap: 1,
            )
          ],
        ),
      ),
    );
  }
}

