import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key, this.summary, this.about});

  final List<String>? summary;
  final List<String>? about;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Summary",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 4),
          ...List.generate(summary?.length ?? 0, (index) {
            if (summary?[index] == "") {
              return SizedBox.shrink();
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• ", style: TextStyle(fontSize: 20)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      summary?[index] ?? "",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.shuttleGrey,
                          ),
                    ),
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: 16),
          Text(
            "About",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 4),
          ...List.generate(about?.length ?? 0, (index) {
            if (about?[index] == "") {
              return SizedBox.shrink();
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• ", style: TextStyle(fontSize: 20)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      about?[index] ?? "",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.shuttleGrey,
                          ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
