import 'package:flutter/material.dart';
import '../Models/Transactions.dart';

import '../Widgets/Transactions_Item.dart';

// ignore: camel_case_types
class TransactionList extends StatelessWidget {
  final List<Transaction> transacions;
  final Function _removetx;
  TransactionList(this.transacions, this._removetx);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      margin: EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
      // decoration: BoxDecoration( border: Border.all(color: Colors.purple, style: BorderStyle.solid, width: 0)),
      child: transacions
              .isEmpty // if no items add in Containes >  Column else add  list view
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Container(
                    // For text when no items
                    height: constraints.maxHeight * 0.1,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "No Transactions Added Yet !",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  Container(
                    // for Image when no items added
                    height: constraints.maxHeight * 0.9,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemCount: transacions.length,
              itemBuilder: (bct, index) {
                return TransactionsItem(
                    transacion: transacions[index], removetx: _removetx);
              },
            ),
    );
  }
}
