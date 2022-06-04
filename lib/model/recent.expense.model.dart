import 'package:cloud_firestore/cloud_firestore.dart';

class RecentExpense {
  String expenseTitle;
  String details;
  int categoryId;
  String categoryName;
  int amount;
  String expenseDate;
  String expenseDay;
  String expenseMonth;
  String expenseMonthDocId;
  String createdDate;
  String recentDocId;
  String expenseDocId;
  String mode;
  Timestamp createdDateTime;
  String createdDateTimeString;
  RecentExpense({
    required this.expenseTitle,
    required this.categoryId,
    required this.details,
    required this.amount,
    required this.categoryName,
    required this.expenseDate,
    required this.expenseMonth,
    required this.expenseMonthDocId,
    required this.createdDate,
    required this.recentDocId,
    required this.expenseDocId,
    required this.expenseDay,
    required this.createdDateTime,
    required this.createdDateTimeString,
    required this.mode,
  });

  // factory RecentExpense.fromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data() as Map;
  //   return RecentExpense(
  //     expenseTitle: data['expenseTitle'],
  //     categoryId: data['categoryId'],
  //     details: data['details'],
  //     amount: data['amount'],
  //     categoryName: data['categoryName'],
  //     expenseDate: data['expenseDate'],
  //     expenseMonth: data['expenseMonth'],
  //     expenseMonthDocId: '',
  //     createdDate: data['createdDate'],
  //     recentDocId: data['recentDocId'],
  //     expenseDocId: data['expenseDocId'],
  //     expenseDay: data['expenseDay'],
  //     mode: data['mode'],
  //   );
  // }

  static RecentExpense toModel(QueryDocumentSnapshot<Object?> element) {
    // var parsedDateTime = DateTime.parse(element['createdDate']);
    return RecentExpense(
      expenseTitle: element['expenseTitle'],
      categoryId: element['categoryId'],
      details: element['details'],
      amount: element['amount'],
      categoryName: element['categoryName'],
      expenseDate: element['expenseDate'],
      expenseMonth: element['expenseMonth'],
      expenseMonthDocId: '',
      createdDate: '',
      recentDocId: element['recentDocId'],
      expenseDay: element['expenseDay'],
      mode: element['mode'],
      expenseDocId: element['expenseDocId'],
      createdDateTime: element['createdDateTime'],
      createdDateTimeString: element['createdDateTimeString'],
    );
  }

  static RecentExpense fromMap(Map element) {
    // var parsedDateTime = DateTime.parse(element['createdDate']);
    return RecentExpense(
      expenseTitle: element['expenseTitle'],
      categoryId: element['categoryId'],
      details: element['details'],
      amount: element['amount'],
      categoryName: element['categoryName'],
      expenseDate: element['expenseDate'],
      expenseMonth: element['expenseMonth'],
      expenseMonthDocId: '',
      createdDate: '',
      recentDocId: element['recentDocId'],
      expenseDay: element['expenseDay'],
      mode: element['mode'],
      createdDateTime: element['createdDateTime'],
      createdDateTimeString: element['createdDateTimeString'],
      expenseDocId: element['expenseDocId'],
    );
  }

  // static
}
