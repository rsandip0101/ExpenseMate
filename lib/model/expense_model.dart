import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String category;

  @HiveField(3)
  String date;

  @HiveField(4)
  String type;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.type,
  });
}