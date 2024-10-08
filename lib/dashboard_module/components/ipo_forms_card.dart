import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/dashboard_module/modal/ipo_forms_model.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

class IpoFormsCard extends StatelessWidget {
  const IpoFormsCard({
    super.key,
    this.state,
  });

  final Forms? state;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: AppBoxDecoration.getBoxDecoration(),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
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
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
