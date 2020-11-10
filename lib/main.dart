import 'dart:io';
import 'package:EXPENSES_APP/Widgets/New_Transaction.dart';
import 'package:EXPENSES_APP/Widgets/Transactions_List.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'Models/Transactions.dart';

import './Widgets/Chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal EXPENSES',
      theme: ThemeData(
          //brightness: Brightness.dark,
          primarySwatch: Colors.purple,
          accentColor: Colors.black87,
          fontFamily: 'OpenSans',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline5: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                button: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  final titlecontroller = TextEditingController();

  final amountController = TextEditingController();

  List<Transaction> _userTransacion = [];
  // ignore: unused_field
  bool _showChart = false;

  void _addNewTransaction(String txtitle, double txamount, DateTime date) {
    final newtx = Transaction(
      id: DateTime.now().toString(),
      title: txtitle,
      date: date,
      amount: txamount,
    );
    setState(() {
      _userTransacion.add(newtx);
    });
  }

  void _startAddNewTransacion(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          //return NewTransacion(_addNewTransaction);
          return GestureDetector(
            onTap: () {},
            child: NewTransacion(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransacion.removeWhere((element) => element.id == id);
    });
  }

  List<Transaction> get _recentTransaction {
    return _userTransacion.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandScapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart ! '),
          Switch.adaptive(
            activeColor: Theme.of(context).primaryColor,
            value: _showChart,
            onChanged: (status) {
              setState(() {
                _showChart = status;
              });
            },
          )
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransaction))
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
        // ## chart Container
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransaction),
      ),
      txListWidget
    ];
  }

  Widget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Personal EXPENSES"),
            trailing: Row(
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransacion(context),
                )
              ],
            ),
          )
        : AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransacion(context),
              ),
            ],
            title: Text('Personal EXPENSES'),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBar();

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransacion, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape)
              ..._buildLandScapeContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
            //Card is pre Styled Container ...
            if (!isLandScape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),

            // NewTransacion(_addNewTransaction),
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => _startAddNewTransacion(context),
              child: Icon(
                Icons.add,
              ),
            ),
    );
  }
}
