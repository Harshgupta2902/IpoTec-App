import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class MainboardUpcomingCard extends StatelessWidget {
  const MainboardUpcomingCard({
    super.key,
    this.name,
    this.bid,
    this.data,
    this.size,
    this.leadManager,
    this.marketMaker,
    required this.markets,
  });

  final String? name;
  final String? bid;
  final String? size;
  final String? leadManager;
  final String? marketMaker;
  final List<String> markets;
  final List<KeyValuePairModel>? data;

  @override
  Widget build(BuildContext context) {
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
                  getLogoPath(name ?? "-"),
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
          const SizedBox(height: 10),

          RichText(
            text: TextSpan(
              text: "Price Range: ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(
                  text: "$bid",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          if (markets.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: "Listing On: ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Row(
                  children: List.generate(markets.length, (index) {
                    return Container(
                      decoration: AppBoxDecoration.getBoxDecoration(
                        color: AppColors.porcelain,
                        borderRadius: 6,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      margin: const EdgeInsets.only(left: 4),
                      child: Text(
                        markets[index],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.green.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                      ),
                    );
                  }),
                ),
              ],
            )
          ],
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              text: "IPO Size: ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(
                  text: "$size ${size == null ? "" : "Cr."}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          if (leadManager != null) ...[
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                text: "Lead Manager: ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: " $leadManager",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            )
          ],
          if (marketMaker != null) ...[
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                text: "Market Maker: ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: " $marketMaker",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            )
          ],

          if (data?.isNotEmpty == true || (data?.length ?? 0) > 0) ...[
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
                data?.length ?? 0,
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
                            data?[index].key,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.boulder,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            data?[index].value,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.oil,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ]
        ],
      ),
    );
  }
}
