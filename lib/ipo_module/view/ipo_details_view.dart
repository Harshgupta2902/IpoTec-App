import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/ipo_module/components/details/details_view.dart';
import 'package:ipotec/ipo_module/components/details/gmp_view.dart';
import 'package:ipotec/ipo_module/components/details/information_view.dart';
import 'package:ipotec/ipo_module/components/details/news_view.dart';
import 'package:ipotec/ipo_module/components/details/subscription_view.dart';
import 'package:ipotec/ipo_module/components/details/summary_view.dart';
import 'package:ipotec/ipo_module/controller/ipo_details_controller.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/custom_tab_bar.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _ipoDetailsController = Get.put(IpoDetailsController());

class IpoDetailsView extends StatefulWidget {
  const IpoDetailsView({super.key, required this.slug, required this.name});

  final String slug;
  final String name;

  @override
  State<IpoDetailsView> createState() => _IpoDetailsViewState();
}

class _IpoDetailsViewState extends State<IpoDetailsView> {
  @override
  void initState() {
    super.initState();
    _ipoDetailsController.getIpoData(slug: widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoreAppBar(
        title: widget.name,
        showBackButton: true,
        centerTitle: false,
        showActions: false,
      ),
      body: _ipoDetailsController.obx((state) {
        final isSubs = state?.data?.subscription?.subscriptionData?.isEmpty == true ? false : true;
        return DefaultTabController(
          length: isSubs ? 6 : 5,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: AppBoxDecoration.getBoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        state?.data?.logo?.contains("http") == true
                            ? CachedImageNetworkContainer(
                                height: 45,
                                width: 45,
                                decoration: AppBoxDecoration.getBoxDecoration(
                                  borderRadius: 10,
                                ),
                                url: state?.data?.logo,
                                placeHolder: buildNetworkPlaceholder(),
                              )
                            : Container(
                                height: 45,
                                width: 45,
                                decoration: AppBoxDecoration.getBoxDecoration(
                                  borderRadius: 10,
                                ),
                                child: SvgPicture.asset(
                                  getLogoPath(widget.name),
                                ),
                              ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            state?.data?.address?.name ?? widget.name,
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
                  ],
                ),
              ),
              CustomTabBar(
                tabList: [
                  KeyValuePairModel(key: "Summary", value: ""),
                  KeyValuePairModel(key: "GMP", value: ""),
                  KeyValuePairModel(key: "Details", value: ""),
                  KeyValuePairModel(key: "Information", value: ""),
                  if (isSubs) KeyValuePairModel(key: "Subscription", value: ''),
                  KeyValuePairModel(key: "News", value: "")
                ],
              ),
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: TabBarView(
                    children: [
                      SummaryView(summary: state?.data?.summary, about: state?.data?.about),
                      GmpView(gmpData: state?.data?.gmpData),
                      DetailsView(
                        ipoDetails: state?.data?.ipoDetails,
                        promoterHolding: state?.data?.promoterHolding,
                      ),
                      InformationView(
                        address: state?.data?.address,
                        registrar: state?.data?.registrar,
                        docs: state?.data?.docLinks,
                      ),
                      if (isSubs)
                        SubscriptionView(
                          subscriptionData: state?.data?.subscription?.subscriptionData,
                        ),
                      NewsView(news: state?.data?.news)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
