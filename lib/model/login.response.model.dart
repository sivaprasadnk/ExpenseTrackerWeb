import 'package:expense_tracker/api/response.status.dart';

class LoginResponse<T> {
  ResponseStatus status;
  String message;
  T data;
  String userId;
  int dailyTotal;
  int dailyCashTotal;
  int dailyOnlineTotal;
  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.userId,
    required this.dailyTotal,
    required this.dailyCashTotal,
    required this.dailyOnlineTotal,
  });
}
