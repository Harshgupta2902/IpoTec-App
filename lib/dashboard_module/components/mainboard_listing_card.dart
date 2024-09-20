import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class MainboardListingCard extends StatelessWidget {
  const MainboardListingCard({
    super.key,
    this.logo,
    this.name,
    this.bid,
    this.data,
    this.listedTime,
  });
  final String? logo;
  final String? name;
  final String? bid;
  final String? listedTime;
  final List<KeyValuePairModel>? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: AppBoxDecoration.getBoxDecoration(),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Hero(
                tag: "fund",
                child: logo?.contains("http") == true
                    ? CachedImageNetworkContainer(
                        height: 45,
                        width: 45,
                        decoration: AppBoxDecoration.getBoxDecoration(
                          borderRadius: 10,
                        ),
                        url: logo,
                        placeHolder: buildPlaceholder(name: name, context: context),
                      )
                    : Container(
                        height: 45,
                        width: 45,
                        decoration: AppBoxDecoration.getBoxDecoration(
                          borderRadius: 10,
                        ),
                        child: SvgPicture.asset(
                          getLogoPath(logo ?? "-"),
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "$name",
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            listedTime ?? "",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              data?.length ?? 0,
              (index) {
                return Container(
                  decoration: AppBoxDecoration.getBoxDecoration(
                    color: AppColors.porcelain,
                    borderRadius: 6,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Text(
                        data?[index].key,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.boulder),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        data?[index].value,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.oil, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 1),
              painter: HorizontalDashedLinePainter(color: Colors.black54),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              bid ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.mediumGreen, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
