import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expense/models/transaction.dart';
import 'package:my_expense/widgets/NewTransaction.dart';
import 'package:my_expense/widgets/transactionList.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [];
  
  void _addNewTransaction(String txTitle, String txAmount) {
    final newTx = new Transaction(
      title: txTitle,
      amount: double.parse(txAmount),
      date: DateTime.now(),
      id: DateFormat('hhmmss').format(DateTime.now()),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
