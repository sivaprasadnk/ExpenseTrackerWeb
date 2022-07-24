import 'package:expense_tracker/utils/string.extension.dart';
import 'package:flutter/material.dart';

import '../../../../monthly.statistics/monthly.statistics.desktop.dart';

class ViewStatisticsButton extends StatelessWidget {
  const ViewStatisticsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const MonthlyStatisticsDesktop(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
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
    );
  }
}
