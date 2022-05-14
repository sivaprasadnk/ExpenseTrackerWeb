import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WindowsSmallExpenseDetails extends StatefulWidget {
  const WindowsSmallExpenseDetails({
    Key? key,
    required this.title,
    required this.date,
    required this.docId,
  }) : super(key: key);
  final String docId;
  final String title;
  final String date;

  @override
  State<WindowsSmallExpenseDetails> createState() =>
      _WindowsSmallExpenseDetailsState();
}

class _WindowsSmallExpenseDetailsState
    extends State<WindowsSmallExpenseDetails> {
  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(kUsersCollection)
                .doc(userId)
                .collection(kExpenseDatesCollection)
                .doc(widget.date)
                .collection(kExpenseCollection)
                .doc(widget.docId)
                .snapshots(),
            builder: (ct, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                //  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                debugPrint('..${snapshot.data!["amount"].toString()}');
              }
              return snapshot.connectionState != ConnectionState.done
                  ? snapshot.hasData
                      ? Center(
                          child: SizedBox(
                            // height: 100,
                            child: Column(
                              children: [
                                Text(kRupeeSymbol +
                                    " " +
                                    snapshot.data!["amount"].toString()),
                                const SizedBox(height: 20),
                                Text(snapshot.data!["details"].toString()),
                                const SizedBox(height: 20),
                                Text(snapshot.data!["updatedTime"].toString()),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          height: screenHeight * 0.5,
                          child: const Center(
                            child: Text(
                              'No Data !',
                            ),
                          ),
                        )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          )
          // Text(details),
          // const SizedBox(
          //   height: 20,
          // ),
          // Text('₹ $amount'),
          // const SizedBox(
          //   height: 20,
          // ),
          // Text(time)
        ],
      ),
    );
  }
}
