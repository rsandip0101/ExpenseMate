import 'package:hive/hive.dart';

import '../model/expense_model.dart';

class HiveService {

  static const String boxName = "expenseBox";

  Future<Box<ExpenseModel>> openBox() async {
    return await Hive.openBox<ExpenseModel>(boxName);
  }
}