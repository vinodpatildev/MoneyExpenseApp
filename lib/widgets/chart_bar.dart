import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String label;
  double spendingsAmount;
  double spentTotalPercentage;
  ChartBar(
      {required this.label,
      required this.spendingsAmount,
      required this.spentTotalPercentage});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.05, horizontal: constraints.maxWidth * 0.05),
        child: Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(
                  '\$${spendingsAmount.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: constraints.maxWidth * 0.2,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0 / 5),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spentTotalPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
