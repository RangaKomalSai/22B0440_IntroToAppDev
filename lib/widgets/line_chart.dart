import 'package:expense_tracker/widgets/card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                'Transactions Chart',
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
          body: Center(child: AspectRatio(aspectRatio: 0.7, child: MyLineChart())),
    ));
  }
}

class MyLineChart extends StatefulWidget {
  const MyLineChart({super.key});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  List<double> transactions = []; // List of transaction amounts
  List<String> dates = [];
  final myGradient = LinearGradient(
      colors: [const Color(0xff23b6e6), const Color(0xff02d39a)]);
  final myOGradient = LinearGradient(colors: [
    const Color(0xff23b6e6).withOpacity(0.3),
    const Color(0xff02d39a).withOpacity(0.3)
  ]);
  // List of transaction dates

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: LineChart(
        LineChartData(
          backgroundColor: Color(0xff0e0145),
          titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: bottomTitlesWidget,
              )),
              topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false, reservedSize: 45)),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(reservedSize: 45, showTitles: true)),
              rightTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 0))),
          borderData: FlBorderData(
              show: true,
              border: Border.all(color: Color(0xff37434d), width: 1)),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Color(0xff37434d), strokeWidth: 1);
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) {
              return FlLine(color: Color(0xff37434d), strokeWidth: 1);
            },
          ),
          lineBarsData: [
            LineChartBarData(
              spots: calculateBalanceData(),
              isCurved: false,
              gradient: myGradient,
              barWidth: 5,
              belowBarData:
                  BarAreaData(show: true, cutOffY: 50, gradient: myOGradient),
              dotData: FlDotData(show: true),
            ),
          ],
          // minX: 0,
          // maxX: transactions.length.toDouble() - 1,
          // minY: 0,
          // maxY: transactions.isNotEmpty ? transactions.reduce((max, transaction) => transaction > max ? transaction : max) : 100,
        ),
      ),
    );
  }
}

List<FlSpot> calculateBalanceData() {
  List<FlSpot> balanceData = [];
  double currentBalance = 0.0;

  // Assuming transactions are sorted by time, iterate through them
  for (int i = 0; i < cardList.length; i++) {
    double time = i.toDouble(); // You can use actual time values if available
    MyCard card = cardList[i];

    // Calculate the balance after each transaction
    if (card.transaction) {
      currentBalance += int.parse(card.amount);
    } else {
      currentBalance -= int.parse(card.amount);
    }

    balanceData.add(FlSpot(time, currentBalance));
  }

  return balanceData;
}

Widget bottomTitlesWidget(double value, TitleMeta meta) {
  int index = value.toInt();
  if (index == 0 && index < cardList.length) {
    MyCard card = cardList[index];
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Text(card.dateAdded.toString() + 'th'),
    );
  } else if (index >= 1 && index < cardList.length) {
    MyCard card = cardList[index];
    MyCard oldCard = cardList[index - 1];
    int currentDate = card.dateAdded;
    int oldDate = oldCard.dateAdded;
    if (currentDate != oldDate) {
      return Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: Text(card.dateAdded.toString() + 'th'),
      );
    } else {
      return Text('');
    }
  } else {}
  return Text('');
}
