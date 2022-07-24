import 'package:expense_tracker/provider/statistics.provider.dart';
import 'package:expense_tracker/utils/string.extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllCategoriesText extends StatelessWidget {
  const ViewAllCategoriesText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var primaryColor = theme.primaryColor;

    return Consumer<StatisticsProvider>(
      builder: (_, provider, __) {
        return SizedBox(
          height: 40,
          child: provider.monthDocList!.isNotEmpty &&
                  provider.filteredCategoryList!.isNotEmpty &&
                  provider.filteredCategoryList!.length > 3
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Text('View All').boldPrimaryColorText(context),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
