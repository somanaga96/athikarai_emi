import 'package:flutter/material.dart';

class HeadlineWidget extends StatelessWidget {
  const HeadlineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      margin: const EdgeInsets.only(top: 50),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth; // Get the screen width

          // Calculate column widths dynamically based on screen width
          double dateWidth = screenWidth * 0.2; // 20% of the screen width for Date
          double amountWidth = screenWidth * 0.2; // 20% for Amount
          double interestWidth = screenWidth * 0.2; // 20% for Interest
          double emiWidth = screenWidth * 0.2; // 20% for EMI
          double spacing = screenWidth * 0.05; // 5% for spacing between columns

          return Row(
            children: [
              SizedBox(width: spacing),
              Column(
                children: [
                  SizedBox(
                    width: dateWidth,
                    child: const Text(
                      "Date",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
              SizedBox(width: spacing),
              Column(
                children: [
                  SizedBox(
                    width: amountWidth,
                    child: const Text(
                      "Amount",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
              SizedBox(width: spacing),
              Column(
                children: [
                  SizedBox(
                    width: interestWidth,
                    child: const Text(
                      "Interest",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
              SizedBox(width: spacing),
              Column(
                children: [
                  SizedBox(
                    width: emiWidth,
                    child: const Text(
                      "EMI",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
