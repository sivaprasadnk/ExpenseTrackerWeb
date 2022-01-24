import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/view/windows/small/home/item.dart';
import 'package:expense_tracker/view/windows/windows.splash.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WindowsSmallHome extends StatefulWidget {
  const WindowsSmallHome({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WindowsSmallHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // FirebaseFirestore.instance.collection(kUsersCollection)
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const WindowsSplashScreen()));
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(kDatesCollection)
                  .snapshots(),
              builder: (ctx, snapshot) {
                return snapshot.connectionState != ConnectionState.done
                    ? snapshot.hasData
                        ? const Item()
                        : const Center(
                            child: CircularProgressIndicator(),
                          )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
