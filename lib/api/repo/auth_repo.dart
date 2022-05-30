import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/api/auth_exception_handler.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthRepo {
  final fireStoreInstance = FirebaseFirestore.instance;

  Future<ResponseModel> createAccount(String email, String password) async {
    final DateTime now = DateTime.now();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    var build = packageInfo.buildNumber;
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        fireStoreInstance
            .collection(kUsersCollection)
            .doc(credential.user!.uid)
            .set({
          'email': email,
          'password': password,
          'registeredTime': formattedTime,
          'isWeb': kIsWeb,
          'userId': credential.user!.uid,
          'registrationAppVersion': version,
          'registrationAppVersionCode': build,
          // 'registrationBuildNumber': build,
        });
      }
    } catch (e) {
      debugPrint('Exception @createAccount: $e');
      return ResponseModel(
        status: ResponseStatus.error,
        data: '',
        message: AuthExceptionHandler.handleException(e).toString(),
      );
    }
    return ResponseModel(
        status: ResponseStatus.success, message: 'Success', data: "");
  }

  // Future<ResponseModel> login(String email, String password) async {
  //   final DateTime now = DateTime.now();
  //   final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);

  //   try {
  //     UserCredential credential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     if (credential.user != null) {
  //       fireStoreInstance
  //           .collection(kUsersCollection)
  //           .doc(credential.user!.uid)
  //           .update({
  //         'lastLoginTime': formattedTime,
  //       });
  //     }
  //   } catch (e) {
  //     debugPrint('Exception @createAccount: $e');
  //     return ResponseModel(
  //       status: ResponseStatus.error,
  //       data: '',
  //       message: AuthExceptionHandler.handleException(e).toString(),
  //     );
  //   }
  //   String userId = FirebaseAuth.instance.currentUser!.uid;

  //   var date = DateFormat('dd_MM_yyyy').format(now);
  //   var month = DateFormat('MMM_yyyy').format(now);
  //   int dailyTotal = 0, monthlyTotal = 0;
  //   var value1 = await fireStoreInstance
  //       .collection(kUsersCollection)
  //       .doc(userId)
  //       .collection(kExpenseMonthsCollection)
  //       .doc(month)
  //       .collection(date)
  //       .doc(date)
  //       .get();
  //   // debugPrint('..month $month }');

  //   var value2 = await fireStoreInstance
  //       .collection(kUsersCollection)
  //       .doc(userId)
  //       .collection(kExpenseMonthsCollection)
  //       .doc(month)
  //       .get();
  //   debugPrint('.. @@ value2 : $value2    ');
  //   if (value1.data() != null) dailyTotal = value1.data()!['totalExpense'];
  //   if (value2.data() != null) monthlyTotal = value2.data()!['totalExpense'];
  //   debugPrint('.. @@ dailyTotal : $dailyTotal');
  //   debugPrint('.. @@ monthlyTotal : $monthlyTotal');
  //   return ResponseModel(
  //       status: ResponseStatus.success,
  //       message: 'Success',
  //       data: dailyTotal.toString() + "." + monthlyTotal.toString());
  // }

  Future<ResponseModel> loginNew(String email, String password) async {
    final DateTime now = DateTime.now();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    var build = packageInfo.buildNumber;
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);

    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        fireStoreInstance
            .collection(kUsersCollection)
            .doc(credential.user!.uid)
            .update({
          'lastLoginTime': formattedTime,
          'lastLoginIsWeb': kIsWeb,
          'lastLoginVersion': version,
          'lastLoginVersionCode': build,
        });
        fireStoreInstance
            .collection(kUsersCollection)
            .doc(credential.user!.uid)
            .collection(kLoginTimeCollection)
            .add({
          'loginVersion': version,
          'loginVersionCode': build,
          'loginTime': formattedTime,
          'isWeb': kIsWeb,
        });
      }
    } catch (e) {
      debugPrint('Exception @loginAccount: $e');
      return ResponseModel(
        status: ResponseStatus.error,
        data: '',
        message: AuthExceptionHandler.handleException(e).toString(),
      );
    }
    String userId = FirebaseAuth.instance.currentUser!.uid;

    var date = DateFormat('dd-MM-yyyy').format(now);
    int dailyTotal = 0;
    var value1 = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(date)
        .get();

    if (value1.data() != null) {
      dailyTotal = value1.data()!['totalExpense'];
    }
    debugPrint('.. @@ dailyTotal from db : $dailyTotal');
    return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success',
        data: dailyTotal.toString() + "." + "0");
  }
}
