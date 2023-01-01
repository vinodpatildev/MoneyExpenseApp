import 'dart:io';
import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.landscapeLeft
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 16,
              ),
              titleMedium: TextStyle(fontFamily: 'QuickSand', fontSize: 24)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _userTransactions = [];
  void _AddNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: txDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (builderContext) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(AddNewTransaction: _AddNewTransaction),
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final Widget appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text('Expense App'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    ): AppBar(title: Text('Expense App'), actions: [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    ]);
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              (appBar as PreferredSizeWidget).preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
      padding: EdgeInsets.all(5),
      child: TransactionList(
          userTransactions: _userTransactions,
          DeleteTransaction: _deleteTransaction),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart", style: Theme.of(context).textTheme.titleSmall,),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    inactiveTrackColor: Colors.black26,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (isLandScape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.75,
                      padding: EdgeInsets.all(5),
                      child: Chart(recentTransactions: _recentTransactions))
                  : txListWidget,
            if (!isLandScape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.25,
                padding: EdgeInsets.all(5),
                child: Chart(recentTransactions: _recentTransactions),
              ),
            if (!isLandScape) txListWidget
          ],
        ),
      ),
    );
    
    return Platform.isIOS? CupertinoPageScaffold(
      navigationBar: appBar as ObstructingPreferredSizeWidget?,
      child: pageBody
      ) :
     Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context)),
      body: pageBody,
    );
  }
}
