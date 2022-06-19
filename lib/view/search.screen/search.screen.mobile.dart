import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/common_strings.dart';
import 'package:expense_tracker/model/expense.model.dart';
import 'package:expense_tracker/view/expense.list.by.date/widgets/expense.details.card.mobile.dart';
import 'package:expense_tracker/view/mobile.view.dart';
import 'package:expense_tracker/view/todays.expense.list/widgets/no.expense.container.mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreenMobile extends StatefulWidget {
  const SearchScreenMobile({Key? key}) : super(key: key);

  @override
  State<SearchScreenMobile> createState() => _SearchScreenMobileState();
}

class _SearchScreenMobileState extends State<SearchScreenMobile> {
  ///
  String searchWord = "";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var userId = FirebaseAuth.instance.currentUser!.uid;

    return MobileView(
      showSearchIcon: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: theme.primaryColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchWord = value;
                      });
                    },
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      hintText: 'Enter text to search in expense titles',
                      isDense: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(kUsersCollection)
                  .doc(userId)
                  .collection(kRecentExpensesCollection)
                  .where('expenseTitle_i', isEqualTo: searchWord.toLowerCase())
                  .snapshots(),
              builder: (_, snapshot) {
                return snapshot.connectionState != ConnectionState.done
                    ? snapshot.hasData &&
                            (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                        ? SizedBox(
                            child: ListView.separated(
                              separatorBuilder: (ctx, _) => const SizedBox(
                                height: 10,
                              ),
                              itemCount:
                                  (snapshot.data! as QuerySnapshot).docs.length,
                              itemBuilder: (ctx, index) {
                                var doc = (snapshot.data! as QuerySnapshot)
                                    .docs[index];
                                Expense expense = Expense.fromJson(doc);
                                return Center(
                                  child: SizedBox(
                                    width: 450,
                                    child: ExpenseDetailsCardMobile(
                                      expense: expense,
                                      width: 450,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const NoExpenseContainerMobile(
                            title: 'No search results found !',
                          )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          )
        ],
      ),
      appBarTitle: 'Search',
    );
  }
}
