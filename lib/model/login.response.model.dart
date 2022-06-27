import 'package:expense_tracker/api/response.status.dart';

class LoginResponse<T> {
  ResponseStatus status;
  String message;
  T data;
  String userId;
  int dailyTotal;
  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.userId,
    required this.dailyTotal,
  });
}
