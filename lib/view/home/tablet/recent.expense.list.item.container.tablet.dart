import 'package:expense_tracker/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RecentExpenseListItemContainerTablet extends StatefulWidget {
  const RecentExpenseListItemContainerTablet({
    Key? key,
    required this.amount,
    required this.subTitle,
    required this.title,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String amount;

  @override
  State<RecentExpenseListItemContainerTablet> createState() =>
      _RecentExpenseListItemContainerState();
}

class _RecentExpenseListItemContainerState
    extends State<RecentExpenseListItemContainerTablet> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    var primaryColor = theme.primaryColor;
    var currency =
        Provider.of<HomeProvider>(context, listen: false).currencySymbol;
    return Container(
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 0),
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
              ),
              width: 1.w,
              height: 7.h,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.subTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "$currency ${widget.amount}",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 20),
            Icon(
              Icons.arrow_forward_ios,
              size: 2.h,
              color: primaryColor,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
