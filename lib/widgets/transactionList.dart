import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'transactionCard.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final void Function(String id) deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, Constraints) {
            return Column(
              children: [
                Container(
                  height: Constraints.maxHeight  * 0.2,
                  child: Center(
                    child: Text(
                      "Nothing to show.",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                Container(
                    height: Constraints.maxHeight * 0.8,
                    child: Image.asset(
                      'assets/images/test.jpg',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctc, index) {
              return Card(
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          "\$${userTransactions[index].amount}",
                        ),
                      ),
                    ),
                  ),
                  title: Text("${userTransactions[index].title}",
                      style: Theme.of(context).textTheme.headline6),
                  subtitle: Row(
                    children: [
                      Text("${userTransactions[index].id}",
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(width: 5),
                      Text(DateFormat.yMEd()
                          .format(userTransactions[index].date)),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      deleteTransaction(userTransactions[index].id);
                    },
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).accentColor,
                  ),
                ),
              );
              // TransactionCard(userTransactions[index]);
            },
            itemCount: userTransactions.length,
          );
  }
}
