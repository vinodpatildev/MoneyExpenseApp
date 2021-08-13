import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fc;

import 'models/transaction.dart';
import 'widgets/NewTransaction.dart';
import 'widgets/chart.dart';
import 'widgets/transactionList.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
        ),
      ),
      title: 'Flutter Expense App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentUserTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosedDate) {
    final newTx = new Transaction(
      title: txTitle,
      amount: txAmount,
      date: choosedDate,
      id: DateFormat('hhmmss').format(DateTime.now()),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void addNewTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((item) {
        return item.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = AppBar(
      title: Text("Expense App"),
      actions: [
        IconButton(
          onPressed: () {
            null;
          },
          icon: Icon(
            Icons.add,
          ),
        )
      ],
    );
    final PreferredSizeWidget txList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    ) as PreferredSizeWidget;
    final appBody = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_isLandscape)
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: Chart(
                _recentUserTransactions,
              ),
            )
          else
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(
                _recentUserTransactions,
              ),
            ),
          if (!_isLandscape) txList,
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: appBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewTransactionModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
