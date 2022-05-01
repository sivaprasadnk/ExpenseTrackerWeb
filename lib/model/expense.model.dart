class Expense {
  String title;
  String details;
  int categoryIndex;
  String categoryName;
  int amount;
  String expenseDate;
  String expenseMonth;
  Expense({
    required this.title,
    required this.categoryIndex,
    required this.details,
    required this.amount,
    required this.categoryName,
    required this.expenseDate,
    required this.expenseMonth,
  });
}
