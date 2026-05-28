import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/expense_model.dart';
import '../../utils/constants.dart';
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
  late String selectedType;

  late String selectedDate;

  final _formKey = GlobalKey<FormState>();

  bool get isIncome =>
      selectedType == AppConstants.typeIncome;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(
          text: widget.expense.title,
        );

    amountController =
        TextEditingController(
          text: widget.expense.amount.toString(),
        );

    selectedCategory = widget.expense.category.isNotEmpty
        ? widget.expense.category
        : AppConstants.expenseCategories.first;

    selectedType =
        widget.expense.type;

    selectedDate =
        widget.expense.date;
  }

  Future<void> pickDate() async {

    DateTime? pickedDate =
    await showDatePicker(

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
        title: const Text(
          "Edit Transaction",
        ),
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

                  if (value == null ||
                      value.isEmpty) {

                    return isIncome
                        ? "Please enter income source"
                        : "Please enter title";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(

                controller:
                amountController,

                keyboardType:
                TextInputType.number,

                decoration:
                const InputDecoration(
                  hintText: "Amount",
                  border:
                  OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return
                      "Please enter amount";
                  }

                  return null;
                },
              ),

              if (!isIncome) ...[

                const SizedBox(height: 20),

                DropdownButtonFormField(

                  value: AppConstants.expenseCategories
                      .contains(selectedCategory)
                      ? selectedCategory
                      : AppConstants.expenseCategories.first,

                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                  ),

                  items:
                  AppConstants.expenseCategories.map((category) {

                    return DropdownMenuItem(

                      value: category,

                      child: Text(category),
                    );

                  }).toList(),

                  onChanged: (value) {

                    setState(() {

                      selectedCategory =
                      value!;
                    });
                  },
                ),
              ],

              const SizedBox(height: 20),

              ListTile(

                tileColor:
                Colors.grey.shade200,

                title: Text(selectedDate),

                trailing: const Icon(
                  Icons.calendar_month,
                ),

                onTap: pickDate,
              ),

              const SizedBox(height: 30),

              CustomButton(

                text: "Update Transaction",

                onPressed: () async {

                  if (_formKey
                      .currentState!
                      .validate()) {

                    final updatedExpense =
                    ExpenseModel(

                      title:
                      titleController.text,

                      amount:
                      double.tryParse(
                        amountController
                            .text,
                      ) ??
                          0,

                      category: isIncome
                          ? ""
                          : selectedCategory,

                      date: selectedDate,

                      type: selectedType,
                    );

                    await Provider.of<
                        ExpenseViewModel>(
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
