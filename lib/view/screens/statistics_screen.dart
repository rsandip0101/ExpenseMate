import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/expense_viewmodel.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ExpenseViewModel>(context);

    Map<String, double> categoryData = {};

    for (var expense in provider.expenses) {

      if (categoryData.containsKey(expense.category)) {

        categoryData[expense.category] =
            categoryData[expense.category]! +
                expense.amount;

      } else {

        categoryData[expense.category] =
            expense.amount;
      }
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text("Statistics"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Expanded(

              child: PieChart(

                PieChartData(

                  sections: [

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
                        ][i % 5],

                        value:
                        categoryData.entries
                            .elementAt(i)
                            .value,

                        title:

                        "${categoryData.entries.elementAt(i).key}\n₹${categoryData.entries.elementAt(i).value.toInt()}",

                        radius: 110,

                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}