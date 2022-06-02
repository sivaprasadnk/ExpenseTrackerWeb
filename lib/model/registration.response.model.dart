import 'package:expense_tracker/api/response.status.dart';

class RegistrationResponse {
  ResponseStatus status;
  String message;
  String data;
  String userId;
  int dailyTotal;
  RegistrationResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.userId,
    required this.dailyTotal,
  });
}
