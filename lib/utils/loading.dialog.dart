import 'package:expense_tracker/utils/custom.dialog.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';

class Loading {
  static showLoading(BuildContext context) {
    showDialog(
      barrierColor: Colors.black87,
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Builder(builder: (context) {
          return const SizedBox(
            width: 80,
            child: CustomDialog(
              // backgroundColor: Colors.transparent,
              // insetPadding: EdgeInsets.zero,
              child: NeumorphicLoader(
                size: 70,
                borderColor: Colors.black,
              ),
            ),
          );
        });
      },
    );
  }
}
