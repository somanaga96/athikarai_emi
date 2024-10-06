import 'package:athikarai_emi/components/page/home/cards/transaction_card.dart';
import 'package:flutter/material.dart'; // For navigation
import 'package:provider/provider.dart';
import '../../../utils/global.dart';
import '../transactions/transaction_detail_page.dart';
import '../debts/debt_detail_page.dart'; // Import the page to navigate to

class CardHorizontalScrollView extends StatefulWidget {
  const CardHorizontalScrollView({super.key});

  @override
  State<CardHorizontalScrollView> createState() =>
      _CardHorizontalScrollViewState();
}

class _CardHorizontalScrollViewState extends State<CardHorizontalScrollView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, global, child) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionDetailPage(
                      title: 'Transaction Details',
                      count: global.count,
                      amount: global.sum.toDouble(),
                    ),
                  ),
                );
              },
              child: TransactionCard(
                title: 'Transaction',
                count: global.count,
                amount: global.sum.toDouble(),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DebtDetailPage(),
                  ),
                );
              },
              child: TransactionCard(
                title: 'Debt',
                count: global.debtCount,
                amount: global.debtSum.toDouble(),
              ),
            ),
            // Add more TransactionCards with onTap events if needed
          ],
        ),
      ),
    );
  }
}
