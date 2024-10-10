import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/dashboard_module/modal/drawer/ipo_subs_model.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class IpoMainBoardSubsCard extends StatefulWidget {
  const IpoMainBoardSubsCard({
    super.key,
    this.state,
  });

  final List<IpoSubscriptionData>? state;

  @override
  State<IpoMainBoardSubsCard> createState() => _IpoMainBoardSubsCardState();
}

class _IpoMainBoardSubsCardState extends State<IpoMainBoardSubsCard> {
  late List<GlobalKey> expansionTileKey;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    expansionTileKey = List.generate(widget.state?.length ?? 0, (index) => GlobalKey());
  }

  openOrCloseContainer({required int index}) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
      } else {
        selectedIndex = index;
      }
    });

    final keyContext = expansionTileKey[index].currentContext;
    if (keyContext == null) {
      return;
    }
    Scrollable.ensureVisible(
      keyContext,
      duration: const Duration(milliseconds: 400),
      alignment: 0.6,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.state?.length ?? 0,
      itemBuilder: (context, index) {
        final ipoSubscriptionData = widget.state?[index];
        final List<KeyValuePairModel> data = [
          if (ipoSubscriptionData?.qibX != null)
            KeyValuePairModel(
              key: "QIB:",
              value: "${ipoSubscriptionData?.qibX}x",
            ),
          if (ipoSubscriptionData?.niiX != null)
            KeyValuePairModel(
              key: "NII:",
              value: "${ipoSubscriptionData?.niiX}x",
            ),
          if (ipoSubscriptionData?.bniiX != null)
            KeyValuePairModel(
              key: "BNII:",
              value: "${ipoSubscriptionData?.bniiX}x",
            ),
        ];

        final List<KeyValuePairModel> moreDetails = [
          if (ipoSubscriptionData?.qibX != null)
            KeyValuePairModel(
              key: "QIB:",
              value: "${ipoSubscriptionData?.qibX}x",
            ),
          if (ipoSubscriptionData?.niiX != null)
            KeyValuePairModel(
              key: "NII:",
              value: "${ipoSubscriptionData?.niiX}x",
            ),
          if (ipoSubscriptionData?.bniiX != null)
            KeyValuePairModel(
              key: "BNII:",
              value: "${ipoSubscriptionData?.bniiX}x",
            ),
          if (ipoSubscriptionData?.retailX != null)
            KeyValuePairModel(
              key: "Retail:",
              value: "${ipoSubscriptionData?.retailX}x",
            ),
          if (ipoSubscriptionData?.employeeX != null)
            KeyValuePairModel(
              key: "Employee:",
              value: "${ipoSubscriptionData?.employeeX}x",
            ),
          if (ipoSubscriptionData?.othersX != null)
            KeyValuePairModel(
              key: "Others:",
              value: "${ipoSubscriptionData?.othersX}x",
            ),
          if (ipoSubscriptionData?.totalX != null)
            KeyValuePairModel(
              key: "Total Subscription:",
              value: "${ipoSubscriptionData?.totalX}x",
            ),
          if (ipoSubscriptionData?.applications != null)
            KeyValuePairModel(
              key: "Applications:",
              value: "${ipoSubscriptionData?.applications}",
            ),
          if (ipoSubscriptionData?.sizeRsCr != null)
            KeyValuePairModel(
              key: "Size (Rs Cr):",
              value: "${ipoSubscriptionData?.sizeRsCr}",
            ),
        ];

        return GestureDetector(
          onTap: () => openOrCloseContainer(index: index),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: AppBoxDecoration.getBoxDecoration(),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  key: expansionTileKey[index],
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: AppBoxDecoration.getBoxDecoration(
                        borderRadius: 10,
                      ),
                      child: SvgPicture.asset(
                        getLogoPath(ipoSubscriptionData?.companyName ?? "-"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${ipoSubscriptionData?.companyName}",
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                          ),
                          if (ipoSubscriptionData?.close != null)
                            Text(
                              ipoSubscriptionData?.close ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: AppColors.boulder),
                            )
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: selectedIndex == index ? 0 : .5,
                      duration: const Duration(milliseconds: 400),
                      child: const Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: AppColors.aluminium,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 1),
                    painter: HorizontalDashedLinePainter(color: Colors.black54),
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: Row(
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
                  ),
                  secondChild: Column(
                    children: List.generate(
                      moreDetails.length,
                      (index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                moreDetails[index].key,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                moreDetails[index].value,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  crossFadeState:
                      selectedIndex == index ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 600),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
    );
  }
}

class IpoSmeBoardSubsCard extends StatefulWidget {
  const IpoSmeBoardSubsCard({
    super.key,
    this.state,
  });

  final List<SmeSubscriptionData>? state;

  @override
  State<IpoSmeBoardSubsCard> createState() => _IpoSmeBoardSubsCardState();
}

class _IpoSmeBoardSubsCardState extends State<IpoSmeBoardSubsCard> {
  late List<GlobalKey> expansionTileKey;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    expansionTileKey = List.generate(widget.state?.length ?? 0, (index) => GlobalKey());
  }

  openOrCloseContainer({required int index}) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
      } else {
        selectedIndex = index;
      }
    });

    final keyContext = expansionTileKey[index].currentContext;
    if (keyContext == null) {
      return;
    }
    Scrollable.ensureVisible(
      keyContext,
      duration: const Duration(milliseconds: 400),
      alignment: 0.6,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.state?.length ?? 0,
      itemBuilder: (context, index) {
        final smeSubscriptionData = widget.state?[index];

        final List<KeyValuePairModel> data = [
          if (smeSubscriptionData?.qibX != null)
            KeyValuePairModel(
              key: "QIB:",
              value: "${smeSubscriptionData?.qibX}x",
            ),
          if (smeSubscriptionData?.niiX != null)
            KeyValuePairModel(
              key: "NII:",
              value: "${smeSubscriptionData?.niiX}x",
            ),
          if (smeSubscriptionData?.retailX != null)
            KeyValuePairModel(
              key: "Retail:",
              value: "${smeSubscriptionData?.retailX}x",
            ),
        ];

        final List<KeyValuePairModel> moreDetails = [
          if (smeSubscriptionData?.open != null)
            KeyValuePairModel(
              key: "Opening Date",
              value: "${smeSubscriptionData?.open}",
            ),
          if (smeSubscriptionData?.close != null)
            KeyValuePairModel(
              key: "Closing Date",
              value: "${smeSubscriptionData?.close}",
            ),
          if (smeSubscriptionData?.sizeRsCr != null)
            KeyValuePairModel(
              key: "Size (Rs Cr):",
              value: "${smeSubscriptionData?.sizeRsCr}",
            ),
          if (smeSubscriptionData?.qibX != null)
            KeyValuePairModel(
              key: "QIB Subscription:",
              value: "${smeSubscriptionData?.qibX}x",
            ),
          if (smeSubscriptionData?.niiX != null)
            KeyValuePairModel(
              key: "NII Subscription:",
              value: "${smeSubscriptionData?.niiX}x",
            ),
          if (smeSubscriptionData?.retailX != null)
            KeyValuePairModel(
              key: "Retail Subscription:",
              value: "${smeSubscriptionData?.retailX}x",
            ),
          if (smeSubscriptionData?.totalX != null)
            KeyValuePairModel(
              key: "Total Subscription:",
              value: "${smeSubscriptionData?.totalX}x",
            ),
          if (smeSubscriptionData?.applications != null)
            KeyValuePairModel(
              key: "Applications:",
              value: "${smeSubscriptionData?.applications}",
            ),
        ];

        return GestureDetector(
          onTap: () => openOrCloseContainer(index: index),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: AppBoxDecoration.getBoxDecoration(),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  key: expansionTileKey[index],
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: AppBoxDecoration.getBoxDecoration(
                        borderRadius: 10,
                      ),
                      child: SvgPicture.asset(
                        getLogoPath(smeSubscriptionData?.companyName ?? "-"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${smeSubscriptionData?.companyName}",
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                          ),
                          if (smeSubscriptionData?.close != null)
                            Text(
                              smeSubscriptionData?.close ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: AppColors.boulder),
                            )
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: selectedIndex == index ? 0 : .5,
                      duration: const Duration(milliseconds: 400),
                      child: const Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: AppColors.aluminium,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 1),
                    painter: HorizontalDashedLinePainter(color: Colors.black54),
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: Row(
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
                  ),
                  secondChild: Column(
                    children: List.generate(
                      moreDetails.length,
                      (index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                moreDetails[index].key,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                moreDetails[index].value,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  crossFadeState:
                      selectedIndex == index ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 600),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
    );
  }
}
