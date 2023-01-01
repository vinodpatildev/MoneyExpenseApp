import 'package:expenses_app/widgets/EmptyTransactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function DeleteTransaction;
  TransactionList(
      {required this.userTransactions, required this.DeleteTransaction});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return userTransactions.isEmpty
        ? EmptyTransactions()
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 6,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          '\$' +
                              userTransactions[index].amount.toStringAsFixed(2),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    userTransactions[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransactions[index].date),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                  trailing: mediaQuery.size.width > 400
                      ? TextButton(
                          child: Text(
                              'Delete',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          onPressed: () =>
                              DeleteTransaction(userTransactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () =>
                              DeleteTransaction(userTransactions[index].id),
                        ),
                ),
              );
            },
            itemCount: userTransactions.length,
          );
  }
}
