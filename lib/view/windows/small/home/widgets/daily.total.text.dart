import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyTotalText extends StatelessWidget {
  const DailyTotalText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return Text(
          "$kRupeeSymbol ${provider.dailyTotalExpense}",
          // provider.dailyTotalExpense.toString(),
          style: const TextStyle(
            fontSize: 60,
            fontFamily: 'Rajdhani',
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
        );
      },
    );
    // return StreamBuilder(
    //   stream: FirebaseFirestore.instance
    //       .collection(kUsersCollection)
    //       .doc(userId)
    //       .collection(kExpenseDatesNewCollection)
    //       .doc(date)
    //       // .collection(date)
    //       .snapshots(),
    //   builder:
    //       (_, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapshot) {
    //     var doc = snapshot!.hasData && (snapshot.data!).docs.isNotEmpty
    //         ? (snapshot.data!).docs[0]
    //         : null;
    //     // debugPrint('.. @@ doc ${doc!['totalExpense']}');
    //     return snapshot.connectionState != ConnectionState.waiting &&
    //             doc != null
    //         ? Text(
    //             doc['totalExpense'] != null
    //                 ? doc['totalExpense'].toString()
    //                 : "",
    //             // provider.dailyTotalExpense.toString(),
    //             style: const TextStyle(
    //               fontSize: 30,
    //               fontFamily: 'Rajdhani',
    //               fontWeight: FontWeight.bold,
    //               color: Colors.red,
    //             ),
    //           )
    //         : Text(
    //             '',
    //             // provider.dailyTotalExpense.toString(),
    //             style: const TextStyle(
    //               fontSize: 30,
    //               fontFamily: 'Rajdhani',
    //               fontWeight: FontWeight.bold,
    //               color: Colors.red,
    //             ),
    //           );
    //   },
    // );
  }
}
