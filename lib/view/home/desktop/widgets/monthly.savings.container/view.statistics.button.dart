import 'package:expense_tracker/utils/string.extension.dart';
import 'package:expense_tracker/view/monthly.statistics/monthly.statistics.screen.dart';
import 'package:flutter/material.dart';

class ViewStatisticsButton extends StatelessWidget {
  const ViewStatisticsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Positioned.fill(
      bottom: 10,
      right: 10,
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MonthlyStatisticsScreen(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.primaryColor),
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Statistics')
                      .boldPrimaryColorTextWithSize(context, 20),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 13,
                    color: theme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
