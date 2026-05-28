import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../model/expense_model.dart';
import '../services/hive_service.dart';
import '../utils/constants.dart';

class ExpenseViewModel extends ChangeNotifier {

  final HiveService _hiveService = HiveService();

  List<ExpenseModel> expenses = [];

  late Box<ExpenseModel> _box;

  String selectedMonth = "All";

  static const _metaBoxName = 'app_meta';
  static const _incomeMigrationKey = 'income_v1_cleared';

  Future<void> init() async {

    _box = await _hiveService.openBox();

    final meta = await Hive.openBox(_metaBoxName);
    if (meta.get(_incomeMigrationKey) != true) {
      await _box.clear();
      await meta.put(_incomeMigrationKey, true);
    }

    getExpenses();
  }

  void getExpenses() {

    expenses = _box.values.toList();

    notifyListeners();
  }

  List<ExpenseModel> get filteredExpenses {

    if (selectedMonth == "All") {
      return expenses;
    }

    return expenses.where((expense) {

      DateTime expenseDate =
      DateTime.parse(expense.date);

      String monthName =
      DateFormat('MMMM').format(expenseDate);

      return monthName == selectedMonth;

    }).toList();
  }

  void changeMonth(String month) {

    selectedMonth = month;

    notifyListeners();
  }

  Future<void> addExpense(
      ExpenseModel expense,
      ) async {

    await _box.add(expense);

    getExpenses();
  }

  Future<void> deleteExpense(
      dynamic key,
      ) async {

    await _box.delete(key);

    getExpenses();
  }

  Future<void> updateExpense(
      dynamic key,
      ExpenseModel expense,
      ) async {

    await _box.put(key, expense);

    getExpenses();
  }

  double get totalIncome {

    double total = 0;

    for (var expense in filteredExpenses) {

      if (expense.type == AppConstants.typeIncome) {
        total += expense.amount;
      }
    }

    return total;
  }

  double get totalExpenses {

    double total = 0;

    for (var expense in filteredExpenses) {

      if (expense.type == AppConstants.typeExpense) {
        total += expense.amount;
      }
    }

    return total;
  }

  double get balance => totalIncome - totalExpenses;
}
