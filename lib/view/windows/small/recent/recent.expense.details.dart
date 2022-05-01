import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecentExpenseDetails extends StatelessWidget {
  const RecentExpenseDetails({
    Key? key,
    required this.docId,
    required this.title,
  }) : super(key: key);
  final String docId;
  final String title;
  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(kUsersCollection)
              .doc(userId)
              .collection(kRecentExpensesCollection)
              .doc(docId)
              // .collection(kExpenseCollection)
              // .orderBy('updatedTime', descending: false)
              .snapshots(),
          builder: (ct, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              // debugPrint('..${snapshot.data!["amount"].toString()}');
            }
            return snapshot.connectionState != ConnectionState.done
                ? snapshot.hasData
                    ? Center(
                        child: SizedBox(
                          // height: 100,
                          child: Column(
                            children: [
                              Text(
                                  "Rs. " + snapshot.data!["amount"].toString()),
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
        ),
      ),
    );
  }
}
