import 'package:flutter/material.dart';

import '../../model/expense_model.dart';

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
      child: ListTile(

        leading: CircleAvatar(
          child: Text(
            expense.category[0],
          ),
        ),

        title: Text(expense.title),

        subtitle: Text(
          "${expense.category} • ${expense.date}",
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,

          children: [

            Flexible(
              child: Text(
                "₹ ${expense.amount}",
                overflow: TextOverflow.ellipsis,
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