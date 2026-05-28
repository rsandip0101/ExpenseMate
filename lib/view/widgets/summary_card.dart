import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {

  final double totalIncome;
  final double totalExpenses;
  final double balance;

  const SummaryCard({
    super.key,
    required this.totalIncome,
    required this.totalExpenses,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          _summaryRow(
            label: "Income",
            amount: totalIncome,
            color: Colors.greenAccent,
          ),

          const SizedBox(height: 12),

          _summaryRow(
            label: "Expenses",
            amount: totalExpenses,
            color: Colors.redAccent,
          ),

          const Divider(color: Colors.white24, height: 24),

          const Text(
            "Balance",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "₹ ${balance.toStringAsFixed(2)}",

            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow({
    required String label,
    required double amount,
    required Color color,
  }) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [

        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),

        Text(
          "₹ ${amount.toStringAsFixed(2)}",
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
