// enum Mode { Cash, Online, All }

class Expense {
  String expenseTitle;
  String details;
  int categoryIndex;
  String categoryName;
  int amount;
  String expenseDate;
  String expenseDay;
  String expenseMonth;
  String expenseDocId;
  String createdDate;
  String mode;
  Expense({
    required this.expenseTitle,
    required this.categoryIndex,
    required this.details,
    required this.amount,
    required this.categoryName,
    required this.expenseDate,
    required this.expenseDay,
    required this.expenseMonth,
    required this.createdDate,
    required this.expenseDocId,
    required this.mode,
  });
}
