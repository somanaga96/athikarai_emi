import 'package:athikarai_emi/components/page/calc/details_screen/headline_widget.dart';
import 'package:athikarai_emi/components/page/calc/details_screen/table_row_value_widget.dart';
import 'package:athikarai_emi/components/page/calc/emi_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final String amount;
  final String rate;
  final double period;
  final bool canShow;

  const DetailScreen(
    this.amount,
    this.rate,
    this.period,
    this.canShow, {
    Key? key,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    double _amount = double.parse(widget.amount);
    final double _rate = double.parse(widget.rate);
    double term = _amount / widget.period;
    double ratePerMonth = (_rate / 100) / 12;
    double interest = 0;

    List<TableRow> ans() {
      List<TableRow> result = [];
      DateTime currentDate = DateTime.now(); // Start with the current date

      for (var i = 1; i <= widget.period; i++) {
        interest = _amount * ratePerMonth;

        // Calculate the first day of the current month
        DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month + 1, 1);

        // Calculate the first Saturday of the month
        int daysToSaturday = (6 - firstDayOfMonth.weekday) % 7;
        DateTime firstSaturday = firstDayOfMonth.add(Duration(days: daysToSaturday));

        // Format the first Saturday's date
        String formattedDate = DateFormat('dd-MMM-yy').format(firstSaturday);

        // Add the row with the first Saturday's date using the new TableRowValueWidget
      
   result.add(
  TableRowValueWidget(
    index: i,
    date: formattedDate,
    amount: _amount,
    interest: interest,
    emi: term + interest,
  ).buildTableRow() // This is correct
);


        // Subtract the term from the amount
        _amount -= term;

        // Increment the current date by one month
        currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
      }
      return result;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Athikarai EMI"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EmiResult(
              amount: widget.amount,
              period: widget.period,
              interest: widget.rate,
              canShow: widget.canShow,
            ),
            const HeadlineWidget(),  // Use the new HeadlineWidget here
            Table(
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(3),
              },
              border: TableBorder.all(color: Colors.blue, width: 2.5),
              children: ans(),
            ),
          ],
        ),
      ),
    );
  }
}
