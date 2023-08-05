import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../firestore/firestore.dart';
import '../widgets/card.dart';
import '../widgets/drawer.dart';
import '../widgets/vibration.dart';
import 'add_expense.dart';

int expensesTotal = 0;

class Home extends StatefulWidget {
  final String userName;
  const Home({super.key, required this.userName});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double r = 130.0;
  bool introVisible = true;
  bool visibleList = false;
  bool amountVisible = true;
  bool showStars =false;
  bool showAmount = true;
  IconData showIcon1 = Icons.keyboard_double_arrow_down_rounded;
  IconData visibleIcon = Icons.visibility;

  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    void refresh(){
      setState(() {
      });
    }

    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(userName: user!.uid),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color.fromRGBO(27, 131, 129, 1),
          title: const Text(
            'Budget  Tracker',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 4.0,
              fontFamily: 'Ubuntu',
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                CircleAvatar(
                  backgroundImage: const AssetImage('assets/avatar.jpg'),
                  radius: r,
                ),
                const SizedBox(height: 10.0),
                Visibility(
                  visible: introVisible,
                  child: Text(
                    'Welcome, ${widget.userName}!',
                    style: const TextStyle(
                        fontSize: 30.0,
                        letterSpacing: 4.0,
                        color: Colors.black
                    ),
                  ),
                ),
                Container(
                  height: deviceHeight * 0.2,
                  width: deviceWidth,
                  margin: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 20.0, 0.0),
                  // alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      // gradient: LinearGradient(
                      //     colors: [Colors.green.shade300,Colors.green,Colors.blueAccent,Colors.blue],
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   stops: [0.0,0.3,0.8,1],
                      // )
                      color: const Color.fromRGBO(11, 191, 186, 1)
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment : MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(33, 0, 0, 0),
                              child: Text(
                                'Total Balance',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.white
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.zero,
                                  child: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        amountVisible = !amountVisible;
                                        if(amountVisible == true){visibleIcon = Icons.visibility;showAmount = true; showStars = false;}
                                        else{visibleIcon = Icons.visibility_off;showAmount = false; showStars = true;}
                                      });
                                    },
                                    icon: Icon(visibleIcon, size: 15, color: Colors.white,),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(height: 5,),
                      Row(
                        children: [
                          const Icon(
                            Icons.currency_rupee,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10.0),
                          Visibility(
                            visible: showAmount,
                            child: Text(
                              NumberFormat.decimalPattern().format(int.parse(expensesTotal.toString())),
                              style: const TextStyle(
                                fontSize: 37.0,
                                // fontFamily: 'IndieFlower',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: showStars,
                            child: const Text(
                              '***',
                              style: TextStyle(
                                fontSize: 37.0,
                                // fontFamily: 'IndieFlower',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 1.0),
                                ),
                                child: IconButton(
                                  onPressed:(){setState(() {
                                    visibleList = !visibleList;
                                    if(visibleList == true){showIcon1 = Icons.keyboard_double_arrow_up_rounded; r = 50.0; introVisible = false;}
                                    else {showIcon1 = Icons.keyboard_double_arrow_down_rounded; r = 130.0; introVisible = true;}
                                  });},
                                  icon: Icon(showIcon1),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Visibility(
                  visible: visibleList,
                  child: Container(
                      height: deviceHeight * 0.4,
                      child: ListView.builder(
                        reverse: true,
                        itemCount: cardList.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  cardList[index],
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 8, 10, 0),
                                    child: Container(
                                      height: 55.0,
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Colors.red,
                                      ),
                                      child: IconButton(
                                        onPressed: (){
                                          removeCard(index);
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.delete_rounded, size: 28, color: Colors.white,),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          );
                        },
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            vibrationOn ? vibrate(): null;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddExpense(callback: refresh)
            )
            ).then((result) {
              // When returning from Page B, update the counter in Page A
              if (true) {
                setState(() {});
              }
            });
          },
          elevation: 5,
          backgroundColor: const Color.fromRGBO(47, 37, 245, 1),
          child: const Icon(Icons.add),

        ),
      ),
    );
  }
}
