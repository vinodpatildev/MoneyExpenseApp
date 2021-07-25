import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final void Function(String title, String amount) addNewTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  
  NewTransaction(this.addNewTransaction);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
            ),
            TextButton(
              onPressed: () {
                addNewTransaction(titleController.text,amountController.text);
              },
              child: Text("Add Transaction."),
            ),
          ],
        ),
      ),
      elevation: 5,
    );
  }
}