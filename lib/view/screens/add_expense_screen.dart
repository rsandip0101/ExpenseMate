import 'package:expensemate/model/expense_model.dart';
import 'package:expensemate/utils/constants.dart';
import 'package:expensemate/view/widgets/custom_button.dart';
import 'package:expensemate/viewmodel/expense_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() =>
      _AddExpenseScreenState();
}

class _AddExpenseScreenState
    extends State<AddExpenseScreen> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String selectedCategory = AppConstants.expenseCategories.first;

  String selectedType = AppConstants.typeExpense;

  String selectedDate =
  DateFormat('yyyy-MM-dd')
      .format(DateTime.now());

  bool get isIncome =>
      selectedType == AppConstants.typeIncome;

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
        title: const Text("Add Transaction"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(

          key: _formKey,

          child: Column(
            children: [

              DropdownButtonFormField(

                value: selectedType,

                decoration: const InputDecoration(
                  labelText: "Type",
                  border: OutlineInputBorder(),
                ),

                items: [
                  AppConstants.typeExpense,
                  AppConstants.typeIncome,
                ].map((type) {

                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );

                }).toList(),

                onChanged: (value) {

                  setState(() {
                    selectedType = value!;
                    if (!isIncome) {
                      selectedCategory =
                          AppConstants.expenseCategories.first;
                    }
                  });
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: titleController,

                decoration: InputDecoration(
                  hintText: isIncome
                      ? "Income source (e.g. Salary)"
                      : "Title",
                  border: const OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return isIncome
                        ? "Please enter income source"
                        : "Please enter title";
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

              if (!isIncome) ...[

                const SizedBox(height: 20),

                DropdownButtonFormField(

                  value: selectedCategory,

                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                  ),

                  items: AppConstants.expenseCategories.map((category) {

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
              ],

              const SizedBox(height: 20),

              ListTile(

                tileColor: Colors.grey.shade200,

                title: Text(selectedDate),

                trailing: const Icon(Icons.calendar_month),

                onTap: pickDate,
              ),

              const SizedBox(height: 30),

              CustomButton(

                text: "Save Transaction",

                onPressed: () async {

                  if (_formKey.currentState!.validate()) {

                    final expense = ExpenseModel(

                      title: titleController.text,

                      amount:
                      double.tryParse(
                        amountController.text,
                      ) ?? 0,

                      category: isIncome
                          ? ""
                          : selectedCategory,

                      date: selectedDate,

                      type: selectedType,
                    );

                    await Provider.of<ExpenseViewModel>(
                      context,
                      listen: false,
                    ).addExpense(expense);

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
