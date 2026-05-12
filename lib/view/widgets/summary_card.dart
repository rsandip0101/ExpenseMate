import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {

  final double total;

  const SummaryCard({
    super.key,
    required this.total,
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

          const Text(
            "Total Expense",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "₹ ${total.toStringAsFixed(2)}",

            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}