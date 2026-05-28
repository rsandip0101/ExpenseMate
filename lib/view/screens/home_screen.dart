
import 'package:expensemate/view/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/expense_viewmodel.dart';
import '../widgets/expense_tile.dart';
import '../widgets/summary_card.dart';
import 'add_expense_screen.dart';
import 'edit_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ExpenseViewModel>(context);

    List<String> months = [
      "All",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return Scaffold(

      appBar: AppBar(
        title: const Text("Expense Tracker"),

        actions: [

          IconButton(

            onPressed: () {

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (_) =>
                  const StatisticsScreen(),
                ),
              );
            },

            icon: const Icon(Icons.pie_chart),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () {

          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) =>
              const AddExpenseScreen(),
            ),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            /// TOTAL EXPENSE CARD
            SummaryCard(
              totalIncome: provider.totalIncome,
              totalExpenses: provider.totalExpenses,
              balance: provider.balance,
            ),

            const SizedBox(height: 20),

            /// MONTH FILTER
            DropdownButtonFormField(

              value: provider.selectedMonth,

              decoration: InputDecoration(

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),

              items: months.map((month) {

                return DropdownMenuItem(

                  value: month,

                  child: Text(
                    month == "All"
                        ? "All Months"
                        : month,
                  ),
                );

              }).toList(),

              onChanged: (value) {

                provider.changeMonth(value!);
              },
            ),

            const SizedBox(height: 20),

            /// EXPENSE LIST
            Expanded(

              child: provider.filteredExpenses.isEmpty

                  ? const Center(
                child: Text(
                  "No transactions yet",
                ),
              )

                  : ListView.builder(

                itemCount:
                provider.filteredExpenses.length,

                itemBuilder: (context, index) {

                  final expense =
                  provider.filteredExpenses[index];

                  return ExpenseTile(

                    expense: expense,

                    onDelete: () async {

                      await provider.deleteExpense(
                        expense.key,
                      );
                    },

                    onEdit: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) => EditExpenseScreen(

                            expense: expense,

                            index: expense.key,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}