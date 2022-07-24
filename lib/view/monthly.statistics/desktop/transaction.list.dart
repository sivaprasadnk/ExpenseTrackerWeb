import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/transaction.model.dart';
import 'package:expense_tracker/view/monthly.statistics/desktop/transaction.item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
    this.stream,
  }) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  @override
  Widget build(BuildContext context) {
    var bgColor = Theme.of(context).scaffoldBackgroundColor;
    return SizedBox(
      child: StreamBuilder(
        stream: stream,
        builder: (_, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? snapshot.hasData &&
                      (snapshot.data! as QuerySnapshot).docs.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                      itemBuilder: (_, index) {
                        var doc = (snapshot.data! as QuerySnapshot).docs[index];
                        TransactionModel trans = TransactionModel.fromJson(doc);
                        return TransactionListItem(
                          trans: trans,
                        );
                      },
                    )
                  : SizedBox(
                      child: Text(
                        'No data found !!',
                        style: TextStyle(color: bgColor),
                      ),
                    )
              : SizedBox(
                  child: Text(
                    'No data found !',
                    style: TextStyle(color: bgColor),
                  ),
                );
        },
      ),
    );
  }
}
