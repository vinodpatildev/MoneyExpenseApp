import 'package:flutter/material.dart';
import 'package:my_expense/widgets/UserTransaction.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Expense App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Container(
                child: Text("CHART"),
                width: double.infinity,
                alignment: Alignment.center,
              ),
              elevation: 5,
            ),
            UserTransaction(),
          ],
        ),
      ),
    );
  }
}
