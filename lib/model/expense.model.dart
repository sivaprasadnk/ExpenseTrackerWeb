class Expense {
  String expenseTitle;
  String details;
  int categoryIndex;
  String categoryName;
  int amount;
  String expenseDate;
  String expenseMonth;
  String expenseDocId;
  String createdDate;
  Expense({
    required this.expenseTitle,
    required this.categoryIndex,
    required this.details,
    required this.amount,
    required this.categoryName,
    required this.expenseDate,
    required this.expenseMonth,
    required this.createdDate,
    required this.expenseDocId,
  });
}
