import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/buyback_ipo_details_controller.dart';
import 'package:ipotec/dashboard_module/modal/buyback_details_model.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/packages/read_more.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _buybackIpoDetailsController = Get.put(BuybackDetailsController());

class BuybackIpoDetailsView extends StatefulWidget {
  const BuybackIpoDetailsView({super.key, required this.slug, required this.name});

  final String slug;
  final String name;

  @override
  State<BuybackIpoDetailsView> createState() => _BuybackIpoDetailsViewState();
}

class _BuybackIpoDetailsViewState extends State<BuybackIpoDetailsView> {
  @override
  void initState() {
    _buybackIpoDetailsController.getBuybackDetails(slug: widget.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoreAppBar(
        title: widget.name,
        centerTitle: false,
        showActions: false,
      ),
      body: _buybackIpoDetailsController.obx((state) {
        final data = [
          KeyValuePairModel(
            key: "Record Date",
            value: convertDate(state?.data?.recordDate ?? "", showYear: false),
          ),
          KeyValuePairModel(
            key: "Open Date",
            value: convertDate(state?.data?.startDate ?? "", showYear: false),
          ),
          KeyValuePairModel(
            key: "Close Date",
            value: convertDate(state?.data?.endDate ?? "", showYear: false),
          )
        ];
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: AppBoxDecoration.getBoxDecoration(),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        state?.data?.companyLogo?.contains("http") == true
                            ? CachedImageNetworkContainer(
                                height: 45,
                                width: 45,
                                decoration: AppBoxDecoration.getBoxDecoration(
                                  borderRadius: 10,
                                ),
                                url: state?.data?.companyLogo,
                                placeHolder: buildPlaceholder(
                                    name: state?.data?.companyName, context: context),
                              )
                            : Container(
                                height: 45,
                                width: 45,
                                decoration: AppBoxDecoration.getBoxDecoration(
                                  borderRadius: 10,
                                ),
                                child: SvgPicture.asset(
                                  getLogoPath(state?.data?.companyName ?? "-"),
                                ),
                              ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            state?.data?.companyName ?? "",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BuyBack Price: ${format2INR(state?.data?.offerPrice)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Issue Size(Amt.): ${state?.data?.issuedAmount}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        data.length,
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
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              FundaMentalCard(
                title: "Fundamentals Details",
                extras: List.generate(
                  state?.symbolData?.fundamentals?.length ?? 0,
                  (index) {
                    final fundamentals = state?.symbolData?.fundamentals?[index];
                    return KeyValuePairModel(key: fundamentals?.name, value: fundamentals?.value);
                  },
                ),
              ),
              const SizedBox(height: 16),
              ExtraDetailsCard(
                title: "Company Details",
                extras: [
                  if (state?.symbolData?.details?.fullName != null)
                    KeyValuePairModel(
                      key: "Name: ",
                      value: state?.symbolData?.details?.fullName,
                    ),
                  if (state?.symbolData?.details?.parentCompany != null)
                    KeyValuePairModel(
                      key: "Parent Company: ",
                      value: state?.symbolData?.details?.parentCompany,
                    ),
                  if (state?.symbolData?.details?.headquarters != null)
                    KeyValuePairModel(
                      key: "Headquarter: ",
                      value: state?.symbolData?.details?.headquarters,
                    ),
                  if (state?.symbolData?.details?.ceo != null)
                    KeyValuePairModel(
                      key: "CEO: ",
                      value: state?.symbolData?.details?.ceo,
                    ),
                  if (state?.symbolData?.details?.managingDirector != null)
                    KeyValuePairModel(
                      key: "Managing Director: ",
                      value: state?.symbolData?.details?.managingDirector,
                    ),
                  if (state?.symbolData?.details?.businessSummary != null)
                    KeyValuePairModel(
                      key: "Summary: ",
                      value: state?.symbolData?.details?.businessSummary,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              PeersList(
                title: "Peers (${state?.symbolData?.similarAssets?.size})",
                peers: state?.symbolData?.similarAssets?.peerList ?? [],
              ),
              const SizedBox(height: 16),
              ShareHoldingAllocationCard(
                shareHoldingPattern: state?.shareHoldingPattern,
              ),
              const SizedBox(height: 16),
              FinancialAllocationCard(
                financials: state?.financials,
              )
            ],
          ),
        );
      }),
    );
  }
}

class FundaMentalCard extends StatelessWidget {
  const FundaMentalCard({super.key, required this.extras, this.title});

  final List<KeyValuePairModel> extras;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width,
      decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 10),
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              width: MediaQuery.of(context).size.width,
              color: AppColors.porcelain,
              child: Text(
                title ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            itemCount: extras.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisExtent: 40,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    extras[index].key,
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.boulder),
                  ),
                  const SizedBox(height: 4),
                  extras[index].value.length > 40
                      ? ReadMoreText(
                          subtitle: extras[index].value,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                        )
                      : Text(
                          extras[index].value,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                        ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ExtraDetailsCard extends StatelessWidget {
  const ExtraDetailsCard({super.key, required this.extras, this.title});

  final List<KeyValuePairModel> extras;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width,
      decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 10),
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              width: MediaQuery.of(context).size.width,
              color: AppColors.porcelain,
              child: Text(
                title ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            itemCount: extras.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    extras[index].key,
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.boulder),
                  ),
                  const SizedBox(height: 4),
                  extras[index].value.length > 40
                      ? ReadMoreText(
                          subtitle: extras[index].value,
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                        )
                      : Text(
                          extras[index].value,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                        ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ],
      ),
    );
  }
}

class ShareHoldingAllocationCard extends StatelessWidget {
  const ShareHoldingAllocationCard({super.key, this.shareHoldingPattern});

  final List<ShareHoldingPattern>? shareHoldingPattern;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppBoxDecoration.getBoxDecoration(),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Container(
              decoration: AppBoxDecoration.getBoxDecoration(
                color: AppColors.whiteSmoke,
                borderRadius: 12,
                showShadow: false,
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              child: Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "Year",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                      width: 70,
                      child: Text(
                        "Promoters",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                      width: 70,
                      child: Text(
                        "Mutual Funds",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                      width: 70,
                      child: Text(
                        "Insurance",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                      width: 70,
                      child: Text(
                        "Foreign Inst.",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                      width: 70,
                      child: Text(
                        "Retail",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ...List.generate(shareHoldingPattern?.length ?? 0, (index) {
              final ranks = shareHoldingPattern?[index];
              return Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: Text(
                      ranks?.period ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(
                      ranks?.promoters?.individual?.percent?.toStringAsFixed(2).toPercent() ?? "",
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(
                      ranks?.mutualFunds?.percent?.toStringAsFixed(2).toPercent() ?? "",
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(
                      ranks?.otherDomesticInstitutions?.insurance?.percent
                              ?.toStringAsFixed(2)
                              .toPercent() ??
                          "",
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(
                      ranks?.foreignInstitutions?.percent?.toStringAsFixed(2).toPercent() ?? "",
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(
                      ranks?.retailAndOthers?.percent?.toStringAsFixed(2).toPercent() ?? "",
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}

class PeersList extends StatelessWidget {
  const PeersList({super.key, required this.peers, this.title});

  final List<PeerList> peers;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width,
      decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 10),
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              width: MediaQuery.of(context).size.width,
              color: AppColors.porcelain,
              child: Text(
                title ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            itemCount: peers.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisExtent: 32,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  peers[index].companyHeader?.logoUrl?.contains("http") == true
                      ? CachedImageNetworkContainer(
                          height: 28,
                          width: 28,
                          decoration: AppBoxDecoration.getBoxDecoration(
                            borderRadius: 10,
                          ),
                          url: peers[index].companyHeader?.logoUrl,
                          placeHolder: buildPlaceholder(
                              name: peers[index].companyHeader?.displayName, context: context),
                        )
                      : Container(
                          height: 28,
                          width: 28,
                          decoration: AppBoxDecoration.getBoxDecoration(
                            borderRadius: 10,
                          ),
                          child: SvgPicture.asset(
                            getLogoPath(peers[index].companyHeader?.displayName ?? "-"),
                          ),
                        ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      peers[index].companyHeader?.displayName ?? "",
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class FinancialAllocationCard extends StatelessWidget {
  const FinancialAllocationCard({super.key, this.financials});

  final List<Financials>? financials;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 12),
      decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            width: MediaQuery.of(context).size.width,
            color: AppColors.porcelain,
            child: Text(
              "Company Financials",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 12),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        "",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.boulder,
                            ),
                      ),
                    ),
                    ...List.generate(
                      financials?[0].yearly?.length ?? 0,
                      (index) {
                        return SizedBox(
                          width: 80,
                          child: Text(
                            financials?[0].yearly?[index].year?.toString() ?? "",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.boulder,
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ...List.generate(financials?.length ?? 0, (mainIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.22,
                          child: Text(
                            financials?[mainIndex].title.toString() ?? "-",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.onyx,
                                ),
                          ),
                        ),
                        ...List.generate(
                          financials?[mainIndex].yearly?.length ?? 0,
                          (index) {
                            return SizedBox(
                              width: 80,
                              child: Text(
                                financials?[mainIndex].yearly?[index].value?.toStringAsFixed(2) ??
                                    "-",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
