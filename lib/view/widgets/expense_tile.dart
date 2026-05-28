import 'package:flutter/material.dart';

import '../../model/expense_model.dart';
import '../../utils/constants.dart';

class ExpenseTile extends StatelessWidget {

  final ExpenseModel expense;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ExpenseTile({
    super.key,
    required this.expense,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      color: expense.type == AppConstants.typeIncome
          ? Colors.green.shade100
          : Colors.red.shade100,

      child: ListTile(

        leading: CircleAvatar(

          backgroundColor:
          expense.type == AppConstants.typeIncome
              ? Colors.green
              : Colors.red,

          child: Icon(

            expense.type == AppConstants.typeIncome
                ? Icons.arrow_downward
                : Icons.arrow_upward,

            color: Colors.white,
          ),
        ),

        title: Text(expense.title),

        subtitle: Text(
          expense.type == AppConstants.typeIncome
              ? expense.date
              : "${expense.category} • ${expense.date}",
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,

          children: [

            Text(

              "${expense.type == AppConstants.typeIncome ? "+" : "-"} ₹${expense.amount}",

              style: TextStyle(

                fontWeight: FontWeight.bold,

                color:
                expense.type == AppConstants.typeIncome
                    ? Colors.green
                    : Colors.red,
              ),
            ),

            IconButton(

              onPressed: onEdit,

              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),

            IconButton(

              onPressed: onDelete,

              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}