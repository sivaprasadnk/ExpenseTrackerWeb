import 'package:flutter/material.dart';
import 'package:neumorphic_loader/neumorphic_loader.dart';

class Loading {
  showLoading(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Container(
          child: NeumorphicLoader(
            size: 70,
            borderColor: Colors.black,
          ),
        );
      },
    );
  }
}
