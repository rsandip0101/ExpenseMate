import 'package:expensemate/model/expense_model.dart';
import 'package:expensemate/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/expense_viewmodel.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  Map<String, double> _groupByCategory(
      List<ExpenseModel> transactions,
      ) {

    final Map<String, double> data = {};

    for (var expense in transactions) {

      if (expense.type != AppConstants.typeExpense) {
        continue;
      }

      final key = expense.category;

      data[key] = (data[key] ?? 0) + expense.amount;
    }

    return data;
  }

  Map<String, double> _groupIncomeBySource(
      List<ExpenseModel> transactions,
      ) {

    final Map<String, double> data = {};

    for (var expense in transactions) {

      if (expense.type != AppConstants.typeIncome) {
        continue;
      }

      final key = expense.title;

      data[key] = (data[key] ?? 0) + expense.amount;
    }

    return data;
  }

  List<PieChartSectionData> _buildSections(
      Map<String, double> categoryData,
      ) {

    if (categoryData.isEmpty) {
      return [];
    }

    return [

      for (int i = 0;
      i < categoryData.entries.length;
      i++)

        PieChartSectionData(

          color: [
            Colors.blue,
            Colors.red,
            Colors.orange,
            Colors.green,
            Colors.purple,
            Colors.teal,
            Colors.amber,
          ][i % 7],

          value:
          categoryData.entries
              .elementAt(i)
              .value,

          title:

          "${categoryData.entries.elementAt(i).key}\n₹${categoryData.entries.elementAt(i).value.toInt()}",

          radius: 80,

          titleStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
    ];
  }

  Widget _pieSection({
    required String title,
    required Map<String, double> data,
  }) {

    return Expanded(
      child: Column(
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: data.isEmpty
                ? const Center(
              child: Text("No data yet"),
            )
                : PieChart(
              PieChartData(
                sections: _buildSections(data),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ExpenseViewModel>(context);

    final expenseData =
    _groupByCategory(provider.filteredExpenses);

    final incomeData =
    _groupIncomeBySource(provider.filteredExpenses);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Statistics"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            _pieSection(
              title: "Expenses by Category",
              data: expenseData,
            ),

            const SizedBox(height: 24),

            _pieSection(
              title: "Income by Source",
              data: incomeData,
            ),
          ],
        ),
      ),
    );
  }
}
