
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/expense_model.dart';
import '../../viewmodel/expense_viewmodel.dart';
import '../widgets/custom_button.dart';

class EditExpenseScreen extends StatefulWidget {

  final ExpenseModel expense;
  final dynamic index;

  const EditExpenseScreen({
    super.key,
    required this.expense,
    required this.index,
  });

  @override
  State<EditExpenseScreen> createState() =>
      _EditExpenseScreenState();
}

class _EditExpenseScreenState
    extends State<EditExpenseScreen> {

  late TextEditingController titleController;
  late TextEditingController amountController;

  late String selectedCategory;

  late String selectedDate;

  final _formKey = GlobalKey<FormState>();

  List<String> categories = [
    "Food",
    "Travel",
    "Shopping",
    "Bills",
  ];

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(text: widget.expense.title);

    amountController =
        TextEditingController(
          text: widget.expense.amount.toString(),
        );

    selectedCategory = widget.expense.category;

    selectedDate = widget.expense.date;
  }

  Future<void> pickDate() async {

    DateTime? pickedDate = await showDatePicker(

      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime(2020),

      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {

      setState(() {

        selectedDate =
            DateFormat('yyyy-MM-dd')
                .format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Edit Expense"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(

          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller: titleController,

                decoration: const InputDecoration(
                  hintText: "Expense Title",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Please enter title";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: amountController,

                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  hintText: "Amount",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Please enter amount";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField(

                initialValue: selectedCategory,

                items: categories.map((category) {

                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );

                }).toList(),

                onChanged: (value) {

                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              ListTile(

                tileColor: Colors.grey.shade200,

                title: Text(selectedDate),

                trailing: const Icon(Icons.calendar_month),

                onTap: pickDate,
              ),

              const SizedBox(height: 30),

              CustomButton(

                text: "Update Expense",

                onPressed: () async {

                  if (_formKey.currentState!.validate()) {

                    final updatedExpense = ExpenseModel(

                      title: titleController.text,

                      amount: double.tryParse(amountController.text) ?? 0,

                      category: selectedCategory,

                      date: selectedDate,
                    );

                    await Provider.of<ExpenseViewModel>(
                      context,
                      listen: false,
                    ).updateExpense(
                      widget.index,
                      updatedExpense,
                    );

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}