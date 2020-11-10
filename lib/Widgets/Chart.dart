import 'package:EXPENSES_APP/Models/Transactions.dart';
import 'package:flutter/material.dart';
import '../Models/Transactions.dart';
import 'package:intl/intl.dart';
import './Chart _Bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    if (groupedTransactionValues.length == 0) return 0;
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactionValues.map((data) {
            return Container(
              //padding: EdgeInsets.only(left: 13.5, right: 13.5),
              child: Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: data['day'].toString(),
                  spendingAmount: data['amount'],
                  speneingPrecentageOfTotal: totalSpending > 0
                      ? (data['amount'] as double) / totalSpending
                      : 0,
                ),
              ),
            );
          }).toList()),
    );
  }
}
