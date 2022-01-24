import 'package:expense_tracker/api/response.status.dart';

class ResponseModel {
  ResponseStatus status;
  String message;
  ResponseModel({required this.status, required this.message});
}
