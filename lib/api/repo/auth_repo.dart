import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/api/auth_exception_handler.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/location.response.model.dart';
import 'package:expense_tracker/model/login.response.model.dart';
import 'package:expense_tracker/model/registration.response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthRepo {
  final fireStoreInstance = FirebaseFirestore.instance;

  Future<RegistrationResponse> createAccount(
      String email, String password) async {
    final DateTime now = DateTime.now();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    var build = packageInfo.buildNumber;
    UserCredential credential;
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);
    try {
      credential = await FirebaseAuth.instance
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
        });
      }
    } catch (e) {
      debugPrint('Exception @createAccount: $e');
      return RegistrationResponse(
        status: ResponseStatus.error,
        data: '',
        dailyTotal: 0,
        userId: '',
        message: AuthExceptionHandler.handleException(e).toString(),
      );
    }
    return RegistrationResponse(
      userId: credential.user!.uid,
      status: ResponseStatus.success,
      dailyTotal: 0,
      message: 'Success',
      data: "",
    );
  }

  // Future<RegistrationResponse> googleSignIn(
  //     String email, String password) async {
  //   final DateTime now = DateTime.now();
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   var version = packageInfo.version;
  //   var build = packageInfo.buildNumber;
  //   UserCredential credential;
  //   final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);
  //   try {
  //     credential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     if (credential.user != null) {
  //       fireStoreInstance
  //           .collection(kUsersCollection)
  //           .doc(credential.user!.uid)
  //           .set({
  //         'email': email,
  //         'password': password,
  //         'registeredTime': formattedTime,
  //         'isWeb': kIsWeb,
  //         'userId': credential.user!.uid,
  //         'registrationAppVersion': version,
  //         'registrationAppVersionCode': build,
  //       });
  //     }
  //   } catch (e) {
  //     debugPrint('Exception @createAccount: $e');
  //     return RegistrationResponse(
  //       status: ResponseStatus.error,
  //       data: '',
  //       dailyTotal: 0,
  //       userId: '',
  //       message: AuthExceptionHandler.handleException(e).toString(),
  //     );
  //   }
  //   return RegistrationResponse(
  //     userId: credential.user!.uid,
  //     status: ResponseStatus.success,
  //     dailyTotal: 0,
  //     message: 'Success',
  //     data: "",
  //   );
  // }

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

  Future<LoginResponse> loginNew(
      String email, String password, LocationResponseModel model) async {
    final DateTime now = DateTime.now();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    var build = packageInfo.buildNumber;
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);

    try {
      var json = model.toJson();
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

        fireStoreInstance
            .collection(kUsersCollection)
            .doc(credential.user!.uid)
            .collection('location')
            .add(json);
      }
    } catch (e) {
      debugPrint('Exception @loginAccount: $e');
      return LoginResponse(
        status: ResponseStatus.error,
        data: '',
        userId: '',
        dailyTotal: 0,
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
    return LoginResponse(
      status: ResponseStatus.success,
      message: 'Success',
      userId: userId,
      dailyTotal: dailyTotal,
      data: model.currency.toString(),
    );
  }

  Future<LoginResponse> googleSignIn(GoogleSignInAccount account) async {
    final DateTime now = DateTime.now();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    var build = packageInfo.buildNumber;
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);

    try {
      GoogleSignInAuthentication? googleSignInAuthentication =
          await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        fireStoreInstance
            .collection(kUsersCollection)
            .doc(userCredential.user!.uid)
            .set({
          'email': account.email,
          'username': account.displayName,
          "photoUrl": account.photoUrl,
          'password': 'googleSignIn',
          'registeredTime': formattedTime,
          'isWeb': kIsWeb,
          'userId': userCredential.user!.uid,
        });
        fireStoreInstance
            .collection(kUsersCollection)
            .doc(userCredential.user!.uid)
            .update({
          'lastLoginTime': formattedTime,
          'lastLoginIsWeb': kIsWeb,
          'lastLoginVersion': version,
          'lastLoginVersionCode': build,
        });
        fireStoreInstance
            .collection(kUsersCollection)
            .doc(userCredential.user!.uid)
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
      return LoginResponse(
        status: ResponseStatus.error,
        data: '',
        userId: '',
        dailyTotal: 0,
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
    return LoginResponse(
        status: ResponseStatus.success,
        message: 'Success',
        userId: userId,
        dailyTotal: dailyTotal,
        data: '');
  }
}
