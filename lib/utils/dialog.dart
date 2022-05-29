import 'package:expense_tracker/cursor.widget.dart';
import 'package:expense_tracker/utils/custom.dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static showConfirmDialog(
      {required BuildContext context,
      required String title,
      required VoidCallback positiveCallBack}) {
    double width = (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)
        ? double.infinity
        : 360;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return CustomDialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 150,
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Rajdhani',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CursorWidget(
                          onTap: () {
                            Navigator.pop(ctx);
                          },
                          isButton: true,
                          borderColor: Theme.of(context).primaryColor,
                          bgColor: Theme.of(context).scaffoldBackgroundColor,
                          buttonWidth: 100,
                          child: const Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        CursorWidget(
                          onTap: positiveCallBack,
                          isButton: true,
                          borderColor: Theme.of(context).primaryColor,
                          bgColor: Theme.of(context).primaryColor,
                          buttonWidth: 100,
                          child: Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static showAlertDialog(
      {required BuildContext context, required String title}) {
    double width = (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)
        ? double.infinity
        : 360;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return CustomDialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 150,
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Rajdhani',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CursorWidget(
                      onTap: () {
                        Navigator.pop(ctx);
                      },
                      isButton: true,
                      borderColor: Theme.of(context).primaryColor,
                      bgColor: Theme.of(context).primaryColor,
                      // borderColor: Theme.of(context).primaryColor,
                      // bgColor: Theme.of(context).scaffoldBackgroundColor,
                      buttonWidth: 100,
                      child: Center(
                        child: Text(
                          'OK',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
