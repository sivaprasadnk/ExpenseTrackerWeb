import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MonthlyTotalText extends StatelessWidget {
  const MonthlyTotalText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final DateTime now = DateTime.now();

    var userId = FirebaseAuth.instance.currentUser!.uid;

    // var month = DateFormat('MMM_yyyy').format(now);
    // var date = DateFormat('dd_MM_yyyy').format(now);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(userId)
          .collection(kExpenseMonthsCollection)
          .snapshots(),
      builder:
          (_, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        var doc = snapshot.hasData ? (snapshot.data!).docs[0] : null;
        return snapshot.connectionState != ConnectionState.waiting
            ? snapshot.hasData && snapshot.data != null
                ? Text(
                    doc!['totalExpense'].toString(),
                    // provider.dailyTotalExpense.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      // fontFamily: 'Rajdhani',
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )
                : CircularProgressIndicator()
            : Text(
                '',
                // provider.dailyTotalExpense.toString(),
                style: const TextStyle(
                  fontSize: 30,
                  // fontFamily: 'Rajdhani',
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              );
      },
    );
  }
}
