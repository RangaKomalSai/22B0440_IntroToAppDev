// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'drop_down.dart';
import 'card_list.dart';
import 'add_expenses.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

int expensesTotal = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(
        fontFamily: 'NotoSans',
        scaffoldBackgroundColor: Color.fromRGBO(14, 27, 28,1)
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String name = 'Name';
  double r = 130.0;
  bool visibleList = false;
  bool introVisible = true;
  bool amountVisible = true;
  bool showStars =false;
  bool showAmount = true;
  IconData showIcon1 = Icons.keyboard_double_arrow_down_rounded;
  IconData visibleIcon = Icons.visibility;
  // IconData notVisibleIcon = Icons.visibility_off;
  // List<Container> containers = [];


// void createContainer(String amount, String description) {
//   setState(() {
//     containers.add(Container(
//
//       width: MediaQuery.of(context).size.width,
//       height: 70.0,
//       margin: EdgeInsets.fromLTRB(28.0, 10.0, 28.0, 0.0),
//       padding: EdgeInsets.fromLTRB(25.0, 0.0, 20.0, 0.0),
//       alignment: Alignment.centerLeft,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.0),
//         color: Colors.white,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             description,
//             style: TextStyle(
//               fontSize: 20.0,
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.w100
//             ),
//           ),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Icon(
//                   Icons.currency_rupee,
//                   color: Colors.black,
//                   size: 15.0,
//                 ),
//                 Text(
//                   NumberFormat.decimalPattern().format(int.parse(amount)),
//                   textAlign: TextAlign.end,
//                   style: TextStyle(
//                     fontSize: 15.0,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ));
//     expensesTotal += int.parse(amount);
//   });
// }
  void removeCard(index){
    setState(() {
      int newAmount =int.parse(cardList[index].amount);
      if(cardList[index].posOrNeg == true){expensesTotal -= newAmount;}
      else{expensesTotal += newAmount;}
      cardList.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Color.fromRGBO(240, 244, 245, 1),
      //   title: const Text(
      //     'Budget  Tracker',
      //     style: TextStyle(
      //       color: Colors.black87,
      //       fontSize: 30.0,
      //       fontWeight: FontWeight.bold,
      //       letterSpacing: 4.0,
      //       fontFamily: 'Ubuntu',
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                  radius: r,
                ),
                SizedBox(height: 10.0),
                Visibility(
                  visible: introVisible,
                  child: Text(
                    'Welcome, $name!',
                    style: TextStyle(
                    fontSize: 30.0,
                    letterSpacing: 4.0,
                      color: Colors.white
                  ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: deviceHeight * 0.2,
                  width: deviceWidth,
                  margin: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
                  padding: EdgeInsets.fromLTRB(25.0, 0.0, 20.0, 0.0),
                  // alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color.fromRGBO(41, 140, 227,1)
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment : MainAxisAlignment.start,
                          children: [
                            Padding(
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
                          Icon(
                            Icons.currency_rupee,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10.0),
                          Visibility(
                            visible: showAmount,
                            child: Text(
                              NumberFormat.decimalPattern().format(int.parse(expensesTotal.toString())),
                              style: TextStyle(
                                fontSize: 37.0,
                                // fontFamily: 'IndieFlower',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: showStars,
                            child: Text(
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Visibility(
                  visible: visibleList,
                  child: Container(
                    height: deviceHeight * 0.4,
                    child: ListView.builder(
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
                                      },
                                      icon: Icon(Icons.delete_rounded, size: 28, color: Colors.white,),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        );
                        // return cards[index];
                      },
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddExpense(
            onPressedCallback: () {setState(() {});},
          )
          )
          ).then((result) {
            // When returning from Page B, update the counter in Page A
            if (result != null) {
              setState(() {});
            }
          });;
        },
        elevation: 5,
        backgroundColor: Color.fromRGBO(41, 140, 227,1),
        child: Icon(Icons.add),

      ),
    );
  }
}
