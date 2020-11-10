import 'package:flutter/material.dart';
import '../Models/Transactions.dart';
import 'package:intl/intl.dart';

class TransactionsItem extends StatelessWidget {
  const TransactionsItem({
    Key key,
    @required this.transacion,
    @required Function removetx,
  })  : _removetx = removetx,
        super(key: key);

  final Transaction transacion;
  final Function _removetx;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black12,
      elevation: 5,
      //margin: EdgeInsets.only(top: 5, bottom: 5),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),

      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '\$${transacion.amount}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ),
        title: Text(
          '${transacion.title}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format((transacion.date)),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 350
            ? FlatButton.icon(
                onPressed: () => _removetx(transacion.id),
                textColor: Theme.of(context).errorColor,
                color: Colors.white12,
                icon: Icon(Icons.delete),
                label: Text("Delete"))
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removetx(transacion.id),
                color: Theme.of(context).errorColor,
                iconSize: 30,
              ),
      ),
    );
  }
}
