import 'package:expense_tracker/api/response.status.dart';

class ResponseModel {
  ResponseStatus status;
  String message;
  String data;
  ResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
}
