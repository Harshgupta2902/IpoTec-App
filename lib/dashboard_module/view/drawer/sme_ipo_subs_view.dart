import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/drawer/sme_ipo_subs_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/error_widget.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _smeIpoSubsController = Get.put(SmeIpoSubsController());

class SmeIpoSubsView extends StatefulWidget {
  const SmeIpoSubsView({super.key});

  @override
  State<SmeIpoSubsView> createState() => _SmeIpoSubsViewState();
}

class _SmeIpoSubsViewState extends State<SmeIpoSubsView> {
  late List<GlobalKey> expansionTileKey;
  int selectedIndex = -1;

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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      await _smeIpoSubsController.getSmeSubsData();
      expansionTileKey =
          List.generate(_smeIpoSubsController.state?.data?.length ?? 0, (index) => GlobalKey());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoreAppBar(
        title: "SME Ipo Subscription",
        showBackButton: true,
        centerTitle: false,
        showActions: false,
      ),
      body: _smeIpoSubsController.obx(
        (state) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: state?.data?.length ?? 0,
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemBuilder: (context, index) {
              final ipoSubscriptionData = state?.data?[index];
              final List<KeyValuePairModel> data = [
                if (ipoSubscriptionData?.size != null)
                  KeyValuePairModel(
                    key: "Size in Cr.:",
                    value: "${ipoSubscriptionData?.size}",
                  ),
                if (ipoSubscriptionData?.applications != null)
                  KeyValuePairModel(
                    key: "Applications:",
                    value: "${ipoSubscriptionData?.applications}",
                  ),
                if (ipoSubscriptionData?.total != null)
                  KeyValuePairModel(
                    key: "Total:",
                    value: "${ipoSubscriptionData?.total}x",
                  ),
              ];

              final List<KeyValuePairModel> moreDetails = [
                if (ipoSubscriptionData?.qib != null)
                  KeyValuePairModel(
                    key: "QIB:",
                    value: "${ipoSubscriptionData?.qib}x",
                  ),
                if (ipoSubscriptionData?.nii != null)
                  KeyValuePairModel(
                    key: "NII:",
                    value: "${ipoSubscriptionData?.nii}x",
                  ),
                if (ipoSubscriptionData?.retail != null)
                  KeyValuePairModel(
                    key: "Retail:",
                    value: "${ipoSubscriptionData?.retail}",
                  ),
                if (ipoSubscriptionData?.total != null)
                  KeyValuePairModel(
                    key: "Total Subscription:",
                    value: "${ipoSubscriptionData?.total}",
                  ),
                if (ipoSubscriptionData?.applications != null)
                  KeyValuePairModel(
                    key: "Applications:",
                    value: "${ipoSubscriptionData?.applications}",
                  ),
                if (ipoSubscriptionData?.size != null)
                  KeyValuePairModel(
                    key: "Size (Rs Cr):",
                    value: "${ipoSubscriptionData?.size}",
                  ),
              ];

              return Container(
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
                                Row(
                                  children: [
                                    Text(
                                      ipoSubscriptionData?.open ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(color: AppColors.boulder),
                                    ),
                                    Text(
                                      " -> ${ipoSubscriptionData?.close}",
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
                              flex: index == data.length ? 1 : 0,
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
                      ),
                      secondChild: Column(
                        children: List.generate(
                          moreDetails.length,
                          (index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Text(
                                    moreDetails[index].key,
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
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
                      crossFadeState: selectedIndex == index
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 600),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () => openOrCloseContainer(index: index),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(selectedIndex != index ? "More" : 'Less'),
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
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          );
        },
        onError: (error) => TryAgainWidget(
          onTap: () => _smeIpoSubsController.getSmeSubsData(),
        ),
      ),
    );
  }
}