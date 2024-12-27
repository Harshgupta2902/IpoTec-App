import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/components/dashboard/today_stock_view.dart';
import 'package:ipotec/ipo_module/controller/drawer/ipo_gmp_controller.dart';
import 'package:ipotec/utilities/common/skeleton_widget.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _ipoGmpController = Get.put(IpoGmpController());

class TrendingIpoView extends StatefulWidget {
  const TrendingIpoView({super.key});

  @override
  State<TrendingIpoView> createState() => _TrendingIpoViewState();
}

class _TrendingIpoViewState extends State<TrendingIpoView> {
  @override
  void initState() {
    super.initState();
    _ipoGmpController.getGmpData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Current Ipo GMP",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          _ipoGmpController.obx(
            (state) {
              return SizedBox(
                height: 210,
                child: ListView.separated(
                  itemCount: state?.data?.length ?? 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final ipoData = state?.data?[index];
                    Color gmpColor = ((double.tryParse((ipoData?.gmp ?? "")) ?? 0) > 0)
                        ? Colors.green
                        : AppColors.cadmiumRed;

                    String? percentageString = ipoData?.estListing
                        ?.split('(')
                        .last
                        .replaceAll(')', '')
                        .replaceAll('%', '');
                    double? percentage = double.tryParse(percentageString!);

                    Color textColor = (percentage != null && percentage > 0)
                        ? Colors.green
                        : AppColors.cadmiumRed;

                    return Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: AppBoxDecoration.getBoxDecoration(),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: AppBoxDecoration.getBoxDecoration(
                                  borderRadius: 10,
                                ),
                                child: SvgPicture.asset(
                                  getLogoPath(ipoData?.companyName ?? "-"),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Flexible(
                                child: Text(
                                  ipoData?.companyName ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Price: ",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: "₹${ipoData?.price}",
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
                                      text: "₹${ipoData?.gmp}",
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: gmpColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "IPO Size: ",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: "${ipoData?.ipoSize}",
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
                                  text: "Lot Size: ",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: ipoData?.lot,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (ipoData?.estListing != null) ...[
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                text: "Est. Listing: ",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                children: [
                                  TextSpan(
                                    text: ipoData?.estListing,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: textColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Updated On: ${ipoData?.updatedAt}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: AppColors.boulder),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                ),
              );
            },
            onLoading: const TrendingIpoShimmer(),
          ),
        ],
      ),
    );
  }
}

class TrendingIpoShimmer extends StatelessWidget {
  const TrendingIpoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        itemCount: 2,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: AppBoxDecoration.getBoxDecoration(),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonWidget(height: 45, width: 45),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonWidget(height: 16, width: 180),
                        SizedBox(height: 10),
                        SkeletonWidget(height: 16, width: 100),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonWidget(height: 14, width: 100),
                    SkeletonWidget(height: 14, width: 100),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonWidget(height: 14, width: 120),
                    SkeletonWidget(height: 14, width: 100),
                  ],
                ),
                SizedBox(height: 10),
                SkeletonWidget(height: 14, width: 140),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: SkeletonWidget(height: 14, width: 160),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
