import 'package:flutter/material.dart';

class EmptyTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints) {
      return Column(
        children: [
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.15,
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: FittedBox(
              child: Text(
                'No transactions to show!',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
          ),
          SizedBox(height: constraints.maxHeight * 0.15),
        ],
      );
    });
  }
}
