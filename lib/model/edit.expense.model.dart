import 'package:expense_tracker/model/expense.model.dart';

class EditExpenseModel {
  Expense expense;
  String userId;
  String updateDateTimeString;
  DateTime updateDateTime;
  EditExpenseModel({
    required this.expense,
    required this.userId,
    required this.updateDateTime,
    required this.updateDateTimeString,
  });
}
