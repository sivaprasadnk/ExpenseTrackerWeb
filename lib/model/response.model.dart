import 'package:expense_tracker/api/response.status.dart';

class ResponseModel {
  ResponseStatus status;
  String message;
  String data;
  String userId;
  ResponseModel({
    required this.status,
    required this.message,
    required this.data,
    this.userId = "",
  });
}
