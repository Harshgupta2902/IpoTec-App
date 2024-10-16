import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/dashboard_module/modal/drawer/ipo_gmp_model.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class IpoGmpCard extends StatelessWidget {
  const IpoGmpCard({
    super.key,
    this.state,
  });

  final Gmp? state;

  @override
  Widget build(BuildContext context) {
    debugPrint("${state?.gain}");
    final List<KeyValuePairModel> data = [
      if (state?.price != null)
        KeyValuePairModel(
          key: "Offer Price:",
          value: "${state?.price}",
        ),
      if (state?.ipoGmp != null)
        KeyValuePairModel(
          key: "GMP:",
          value: "${state?.ipoGmp}",
        ),
      if (state?.gain != null)
        KeyValuePairModel(
          key: "Listing Gain:",
          value: "${state?.gain}",
        ),
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: AppBoxDecoration.getBoxDecoration(),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => MyNavigator.pushNamed(
              GoPaths.commonDetails,
              extra: {
                'slug': state?.slug,
                'name': state?.companyName,
              },
            ),
            child: Row(
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
                      if (state?.date != null)
                        Text(
                          state?.date ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppColors.boulder),
                        )
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                SvgPicture.asset(AssetPath.viewSvg),
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
