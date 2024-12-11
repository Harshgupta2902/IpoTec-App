import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:ipotec/dashboard_module/modal/bottom/ipo_gmp_model.dart';

class IpoGmpCard extends StatelessWidget {
  const IpoGmpCard({super.key, this.state});

  final Data? state;

  @override
  Widget build(BuildContext context) {
    final List<KeyValuePairModel> data = [
      KeyValuePairModel(
        key: "Open Date:",
        value: "${state?.open == "" ? "--" : state?.open}",
      ),
      KeyValuePairModel(
        key: "Close Date:",
        value: "${state?.close == "" ? "--" : state?.close}",
      ),
      KeyValuePairModel(
        key: "Listing Date:",
        value: "${state?.listing == "" ? "--" : state?.listing}",
      ),
    ];
    String? percentageString =
        state?.estListing?.split('(').last.replaceAll(')', '').replaceAll('%', '');
    double? percentage = double.tryParse(percentageString!);

    Color textColor = (percentage != null && percentage > 0) ? Colors.green : AppColors.cadmiumRed;

    Color gmpColor =
        ((double.tryParse((state?.gmp ?? "")) ?? 0) > 0) ? Colors.green : AppColors.cadmiumRed;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: AppBoxDecoration.getBoxDecoration(),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: AppBoxDecoration.getBoxDecoration(
                  borderRadius: 10,
                ),
                child: SvgPicture.asset(
                  getLogoPath(state?.companyName ?? "-"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${state?.companyName}",
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (state?.lot != "")
                          Text(
                            "Lot Size: ${state?.lot ?? "-"}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.boulder),
                          ),
                        if (state?.updatedAt != "")
                          Text(
                            "Updated On: ${state?.updatedAt}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.boulder),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              text: "Price: ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(
                  text: "₹${state?.price}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: "GMP: ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(
                  text: "₹${state?.gmp}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: gmpColor,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          if (state?.estListing != null) ...[
            RichText(
              text: TextSpan(
                text: "Est. Listing: ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: state?.estListing,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            )
          ],
          RichText(
            text: TextSpan(
              text: "IPO Size: ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(
                  text: "${state?.ipoSize}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 1),
              painter: HorizontalDashedLinePainter(color: Colors.black54),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              data.length,
              (index) {
                return Flexible(
                  child: Container(
                    decoration: AppBoxDecoration.getBoxDecoration(
                      color: AppColors.porcelain,
                      borderRadius: 6,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Column(
                      children: [
                        Text(
                          data[index].key,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.boulder),
                        ),
                        Text(
                          data[index].value,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
