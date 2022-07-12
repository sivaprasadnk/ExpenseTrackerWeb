import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/api/auth_exception_handler.dart';
import 'package:expense_tracker/api/response.status.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/location.response.model.dart';
import 'package:expense_tracker/model/login.response.model.dart';
import 'package:expense_tracker/model/registration.response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthRepo {
  final fireStoreInstance = FirebaseFirestore.instance;
  // GoogleSignIn? _googleSignIn = GoogleSignIn(
  //   scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  // );
  Future<void> createAccount(
      String email, String password) async {
    // final DateTime now = DateTime.now();
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // var version = packageInfo.version;
    // var build = packageInfo.buildNumber;
    // UserCredential credential;
    // final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);
    // try {
    //   credential = await FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(email: email, password: password);
    //   if (credential.user != null) {
    //     fireStoreInstance
    //         .collection(kUsersCollection)
    //         .doc(credential.user!.uid)
    //         .set({
    //       'email': email,
    //       'password': password,
    //       'registeredTime': formattedTime,
    //       'isWeb': kIsWeb,
    //       'userId': credential.user!.uid,
    //       'registrationAppVersion': version,
    //       'registrationAppVersionCode': build,
    //     });
    //   }
    // } catch (e) {
    //   debugPrint('Exception @createAccount: $e');
    //   return RegistrationResponse(
    //     status: ResponseStatus.error,
    //     data: '',
    //     monthlyExpenseTotal: 0,
    //     monthlyIncomeTotal: 0,
    //     userId: '',
    //     message: AuthExceptionHandler.handleException(e).toString(),
    //   );
    // }
    // return RegistrationResponse(
    //   userId: credential.user!.uid,
    //   status: ResponseStatus.success,
    //   monthlyExpenseTotal: 0,
    //   monthlyIncomeTotal: 0,
    //   message: 'Success',
    //   data: "",
    // );
  }

  Future<RegistrationResponse> createAccountV2(
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
        userId: '',
        message: AuthExceptionHandler.handleException(e).toString(),
      );
    }
    return RegistrationResponse(
      userId: credential.user!.uid,
      status: ResponseStatus.success,
      message: 'Success',
      data: "",
    );
  }

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

        // var res = await fireStoreInstance
        //     .collection(kExpenseCategoriesCollection)
        //     .get();
        // var docsList = res.docs;
        // for (var i = 0; i < docsList.length; i++) {}
      }
    } catch (e) {
      debugPrint('Exception @loginAccount: $e');
      return LoginResponse(
        status: ResponseStatus.error,
        data: '',
        userId: '',
        dailyTotal: 0,
        dailyCashTotal: 0,
        dailyOnlineTotal: 0,
        message: AuthExceptionHandler.handleException(e).toString(),
      );
    }
    String userId = FirebaseAuth.instance.currentUser!.uid;

    var date = DateFormat('dd-MM-yyyy').format(now);
    int dailyTotal = 0;
    int dailyCashTotal = 0;
    int dailyOnlineTotal = 0;
    var value1 = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(date)
        .get();

    if (value1.data() != null) {
      dailyTotal = value1.data()!['totalExpense'];
      dailyCashTotal = value1.data()!['totalCashExpense'];
      dailyOnlineTotal = value1.data()!['totalOnlineExpense'];
    }
    return LoginResponse(
      status: ResponseStatus.success,
      message: 'Success',
      userId: userId,
      dailyTotal: dailyTotal,
      dailyCashTotal: dailyCashTotal,
      dailyOnlineTotal: dailyOnlineTotal,
      data: model.currency.toString(),
    );
  }

  Future<LoginResponse> googleSignIn(
    GoogleSignInAccount account, [
    bool link = false,
    AuthCredential? authCredential,
  ]) async {
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
        if (link) {
          await linkProviders(userCredential, authCredential!);
        }

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
      return LoginResponse(
        status: ResponseStatus.error,
        data: '',
        userId: '',
        dailyTotal: 0,
        dailyCashTotal: 0,
        dailyOnlineTotal: 0,
        message: AuthExceptionHandler.handleException(e).toString(),
      );
    }

    String userId = FirebaseAuth.instance.currentUser!.uid;

    var date = DateFormat('dd-MM-yyyy').format(now);
    int dailyTotal = 0;
    int dailyCashTotal = 0;
    int dailyOnlineTotal = 0;
    var value1 = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(date)
        .get();

    if (value1.data() != null) {
      dailyTotal = value1.data()!['totalExpense'];
      dailyCashTotal = value1.data()!['totalCashExpense'];
      dailyOnlineTotal = value1.data()!['totalOnlineExpense'];
    }
    return LoginResponse(
        status: ResponseStatus.success,
        message: 'Success',
        userId: userId,
        dailyTotal: dailyTotal,
        dailyCashTotal: dailyCashTotal,
        dailyOnlineTotal: dailyOnlineTotal,
        data: '');
  }

  // Future<LoginResponse> fbLogin({required LoginResult result}) async {
  //   final DateTime now = DateTime.now();
  //   final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   var version = packageInfo.version;
  //   var build = packageInfo.buildNumber;
  //   final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);

  //   try {
  //     final AccessToken accessToken = result.accessToken!;
  //     debugPrint(accessToken.token);

  //     final AuthCredential facebookCredential =
  //         FacebookAuthProvider.credential(result.accessToken!.token);

  //     Map<String, dynamic> userDetails =
  //         await FacebookAuth.instance.getUserData();

  //     String email = userDetails['email'];
  //     String name = userDetails['name'];
  //     String url = userDetails['picture']['url'];
  //     // String id = userDetails['id'];
  //     // you are logged

  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(facebookCredential);

  //     if (userCredential.user != null) {
  //       fireStoreInstance
  //           .collection(kUsersCollection)
  //           .doc(userCredential.user!.uid)
  //           .set({
  //         'email': email,
  //         'username': name,
  //         "photoUrl": url,
  //         'password': 'fbSignIN',
  //         'registeredTime': formattedTime,
  //         'isWeb': kIsWeb,
  //         'userId': userCredential.user!.uid,
  //       });
  //       fireStoreInstance
  //           .collection(kUsersCollection)
  //           .doc(userCredential.user!.uid)
  //           .update({
  //         'lastLoginTime': formattedTime,
  //         'lastLoginIsWeb': kIsWeb,
  //         'lastLoginVersion': version,
  //         'lastLoginVersionCode': build,
  //       });
  //       fireStoreInstance
  //           .collection(kUsersCollection)
  //           .doc(userCredential.user!.uid)
  //           .collection(kLoginTimeCollection)
  //           .add({
  //         'loginVersion': version,
  //         'loginVersionCode': build,
  //         'loginTime': formattedTime,
  //         'isWeb': kIsWeb,
  //       });
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     // List<String> emailList =
  //     //     await FirebaseAuth.instance.fetchSignInMethodsForEmail(e.email!);
  //     // if (emailList.first == "google.com") {
  //     //   linkWithGoogle(authCredential: e.credential);
  //     // }

  //     return LoginResponse(
  //       status: ResponseStatus.error,
  //       data: e,
  //       userId: '',
  //       dailyTotal: 0,
  //       dailyCashTotal: 0,
  //       dailyOnlineTotal: 0,
  //       message: AuthExceptionHandler.handleException(e).toString(),
  //     );
  //   } catch (err) {
  //     debugPrint('error @fbLogin: $err');
  //     return LoginResponse(
  //       status: ResponseStatus.error,
  //       data: '',
  //       userId: '',
  //       dailyTotal: 0,
  //       dailyCashTotal: 0,
  //       dailyOnlineTotal: 0,
  //       message: AuthExceptionHandler.handleException(err).toString(),
  //     );
  //   }

  //   String userId = FirebaseAuth.instance.currentUser!.uid;

  //   var date = DateFormat('dd-MM-yyyy').format(now);
  //   int dailyTotal = 0;
  //   int dailyCashTotal = 0;
  //   int dailyOnlineTotal = 0;
  //   var value1 = await fireStoreInstance
  //       .collection(kUsersCollection)
  //       .doc(userId)
  //       .collection(kExpenseDatesNewCollection)
  //       .doc(date)
  //       .get();

  //   if (value1.data() != null) {
  //     dailyTotal = value1.data()!['totalExpense'];
  //     dailyCashTotal = value1.data()!['totalCashExpense'];
  //     dailyOnlineTotal = value1.data()!['totalOnlineExpense'];
  //   }
  //   return LoginResponse(
  //     status: ResponseStatus.success,
  //     message: 'Success',
  //     userId: userId,
  //     dailyTotal: dailyTotal,
  //     dailyCashTotal: dailyCashTotal,
  //     dailyOnlineTotal: dailyOnlineTotal,
  //     data: '',
  //   );
  // }

  Future<LoginResponse> linkWithGoogle({AuthCredential? authCredential}) async {
    final DateTime now = DateTime.now();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    var build = packageInfo.buildNumber;
    final String formattedTime = DateFormat('dd-MM-yyyy  kk:mm').format(now);
    try {
      // final GoogleSignInAccount? googleSignInAccount =
      //     await _googleSignIn!.signIn();
      // if (googleSignInAccount != null) {
      //   final GoogleSignInAuthentication googleSignInAuthentication =
      //       await googleSignInAccount.authentication;
      //   final AuthCredential credential = GoogleAuthProvider.credential(
      //     accessToken: googleSignInAuthentication.accessToken,
      //     idToken: googleSignInAuthentication.idToken,
      //   );
      //   UserCredential userCredential =
      //       await FirebaseAuth.instance.signInWithCredential(credential);
      //   await userCredential.user!.linkWithCredential(authCredential!);
      //   if (userCredential.user != null) {
      //     var user = userCredential.user;
      //     debugPrint(" userCredential.user :  $user");

      //     fireStoreInstance.collection(kUsersCollection).doc(user!.uid).set({
      //       'email': user.email!,
      //       'username': user.displayName,
      //       "photoUrl": user.photoURL,
      //       'password': 'fbSignIN+google',
      //       'registeredTime': formattedTime,
      //       'isWeb': kIsWeb,
      //       'userId': userCredential.user!.uid,
      //     });
      //     fireStoreInstance
      //         .collection(kUsersCollection)
      //         .doc(userCredential.user!.uid)
      //         .update({
      //       'lastLoginTime': formattedTime,
      //       'lastLoginIsWeb': kIsWeb,
      //       'lastLoginVersion': version,
      //       'lastLoginVersionCode': build,
      //     });
      //     fireStoreInstance
      //         .collection(kUsersCollection)
      //         .doc(userCredential.user!.uid)
      //         .collection(kLoginTimeCollection)
      //         .add({
      //       'loginVersion': version,
      //       'loginVersionCode': build,
      //       'loginTime': formattedTime,
      //       'isWeb': kIsWeb,
      //     });
      //   }
      // }
    } on FirebaseAuthException catch (err) {
      debugPrint('Exception @FirebaseAuthException 2: $err');
      return LoginResponse(
        status: ResponseStatus.error,
        data: '',
        userId: '',
        dailyTotal: 0,
        dailyCashTotal: 0,
        dailyOnlineTotal: 0,
        message: AuthExceptionHandler.handleException(err).toString(),
      );
    } on PlatformException catch (err) {
      debugPrint('Exception @PlatformException: $err');
      return LoginResponse(
        status: ResponseStatus.error,
        data: '',
        userId: '',
        dailyTotal: 0,
        dailyCashTotal: 0,
        dailyOnlineTotal: 0,
        message: AuthExceptionHandler.handleException(err).toString(),
      );
    } catch (err) {
      debugPrint('Exception @loginAccount: $err');
      return LoginResponse(
        status: ResponseStatus.error,
        data: '',
        userId: '',
        dailyCashTotal: 0,
        dailyOnlineTotal: 0,
        dailyTotal: 0,
        message: AuthExceptionHandler.handleException(err).toString(),
      );
    }
    String userId = FirebaseAuth.instance.currentUser!.uid;

    var date = DateFormat('dd-MM-yyyy').format(now);
    int dailyTotal = 0;
    int dailyCashTotal = 0;
    int dailyOnlineTotal = 0;
    var value1 = await fireStoreInstance
        .collection(kUsersCollection)
        .doc(userId)
        .collection(kExpenseDatesNewCollection)
        .doc(date)
        .get();

    if (value1.data() != null) {
      dailyTotal = value1.data()!['totalExpense'];
      dailyCashTotal = value1.data()!['totalCashExpense'];
      dailyOnlineTotal = value1.data()!['totalOnlineExpense'];
    }

    return LoginResponse(
      status: ResponseStatus.success,
      message: 'Success',
      userId: userId,
      dailyTotal: dailyTotal,
      dailyCashTotal: dailyCashTotal,
      dailyOnlineTotal: dailyOnlineTotal,
      data: '',
    );
  }

  Future<UserCredential?> linkProviders(
      UserCredential userCredential, AuthCredential newCredential) async {
    return await userCredential.user!.linkWithCredential(newCredential);
  }
}
