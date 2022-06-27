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
  accountExistsWithDifferentProvider,
  undefined,
}

class AuthExceptionHandler {
  static String handleException(e) {
    switch (e.code) {
      case "invalid-email":
        return generateExceptionMessage(AuthResultStatus.invalidEmail);
      case "wrong-password":
        return generateExceptionMessage(AuthResultStatus.wrongPassword);
      case "user-not-found":
        return generateExceptionMessage(AuthResultStatus.userNotFound);
      case "ERROR_USER_DISABLED":
        return generateExceptionMessage(AuthResultStatus.userDisabled);
      case "ERROR_TOO_MANY_REQUESTS":
        return generateExceptionMessage(AuthResultStatus.tooManyRequests);
      case "ERROR_OPERATION_NOT_ALLOWED":
        return generateExceptionMessage(AuthResultStatus.operationNotAllowed);
      case "email-already-in-use":
        return generateExceptionMessage(AuthResultStatus.emailAlreadyExists);
      case "weak-password":
        return generateExceptionMessage(AuthResultStatus.weakPassword);
      case "account-exists-with-different-credential":
        return generateExceptionMessage(
            AuthResultStatus.accountExistsWithDifferentProvider);
      default:
        return generateExceptionMessage(AuthResultStatus.undefined);
    }
  }

  static String generateExceptionMessage(exceptionCode) {
    String errorMessage;
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
      case AuthResultStatus.accountExistsWithDifferentProvider:
        errorMessage =
            " An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.";
        break;
      default:
        errorMessage = "Something went wrong ! Please try again .";
    }

    return errorMessage;
  }
}
