import 'package:flutter/material.dart';

enum AuthResultStatus {
  weakPassword,
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class AuthExceptionHandler {
  static String handleException(e) {
    // debugPrint(e.code);
    // var status;
    switch (e.code) {
      case "invalid-email":
        return generateExceptionMessage(AuthResultStatus.invalidEmail);
      // break;
      case "wrong-password":
        return generateExceptionMessage(AuthResultStatus.wrongPassword);
      // break;
      case "user-not-found":
        return generateExceptionMessage(AuthResultStatus.userNotFound);
      // break;
      case "ERROR_USER_DISABLED":
        return generateExceptionMessage(AuthResultStatus.userDisabled);
      // break;
      case "ERROR_TOO_MANY_REQUESTS":
        return generateExceptionMessage(AuthResultStatus.tooManyRequests);
      // break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        return generateExceptionMessage(AuthResultStatus.operationNotAllowed);
      // break;
      case "email-already-in-use":
        return generateExceptionMessage(AuthResultStatus.emailAlreadyExists);
      // break;
      case "weak-password":
        return generateExceptionMessage(AuthResultStatus.weakPassword);
      // break;
      default:
        return generateExceptionMessage(AuthResultStatus.undefined);
    }
    // return status;
  }

  static String generateExceptionMessage(exceptionCode) {
    String errorMessage;
    debugPrint(':::: exceptionCode $exceptionCode ');
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. \n Please login or reset your password.";
        break;
      case AuthResultStatus.weakPassword:
        errorMessage = "Password should be at least \n 6 characters.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}
