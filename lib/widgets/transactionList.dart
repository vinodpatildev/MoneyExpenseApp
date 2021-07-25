import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transactionCard.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList(this.userTransactions);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: userTransactions.map((tx) {
        return TransactionCard(tx);
      }).toList(),
    );
  }
}
