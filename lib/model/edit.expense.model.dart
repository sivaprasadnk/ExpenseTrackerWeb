import 'package:expense_tracker/model/expense.model.dart';

class EditExpenseModel {
  int newDateWiseTotal;
  int newCategoryWiseTotal;
  Expense expense;
  String userId;
  String updateDateTimeString;
  DateTime updateDateTime;
  EditExpenseModel({
    required this.newDateWiseTotal,
    required this.newCategoryWiseTotal,
    required this.expense,
    required this.userId,
    required this.updateDateTime,
    required this.updateDateTimeString,
  });
}
