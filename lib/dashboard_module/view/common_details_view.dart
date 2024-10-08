import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/common_details_controller.dart';
import 'package:ipotec/dashboard_module/controller/mainboard_ipo_details_controller.dart';
import 'package:ipotec/dashboard_module/modal/ipo_details_model.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/error_widget.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/dashed_line_painter.dart';
import 'package:ipotec/utilities/packages/read_more.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _commonDetailsController = Get.put(CommonDetailsController());

class CommonDetailsView extends StatefulWidget {
  const CommonDetailsView({super.key, required this.slug, required this.name});

  final String slug;
  final String name;

  @override
  State<CommonDetailsView> createState() => _CommonDetailsViewState();
}

class _CommonDetailsViewState extends State<CommonDetailsView> {
  @override
  void initState() {
    _commonDetailsController.getCommonDetails(slug: widget.slug);
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
        body: _commonDetailsController.obx(
          (state) {
            return Text("data");
          },
        ));
  }
}

class ExtraDetailsCard extends StatelessWidget {
  const ExtraDetailsCard({super.key, required this.extras, this.dates});

  final List<KeyValuePairModel> extras;
  final List<KeyValuePairModel>? dates;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width,
      decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 10),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          if (dates?.isNotEmpty == true || (dates?.length ?? 0) != 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                dates?.length ?? 0,
                (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dates?[index].key,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.boulder),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dates?[index].value,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(),
          ],
          ListView.separated(
            shrinkWrap: true,
            itemCount: extras.length,
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
                  Text(
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

class Faqs extends StatelessWidget {
  const Faqs({super.key, required this.pros, required this.cons});
  final List<String> pros;
  final List<String> cons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width,
          decoration: AppBoxDecoration.getBoxDecoration(
            borderRadius: 10,
            border: Border.all(color: AppColors.lightGrey),
          ),
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.aliceBlue,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: Text(
                  "Pro's",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(
                pros.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4, right: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.arrow_right, color: Colors.black, size: 18),
                        const SizedBox(width: 4),
                        pros[index].length > 40
                            ? Flexible(child: ReadMoreText(subtitle: pros[index]))
                            : Flexible(
                                child: Text(
                                  pros[index],
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width,
          decoration: AppBoxDecoration.getBoxDecoration(
            borderRadius: 10,
            border: Border.all(color: AppColors.lightGrey),
          ),
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.aliceBlue,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: Text(
                  "Con's",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(
                cons.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4, right: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.arrow_right, color: Colors.black, size: 18),
                        const SizedBox(width: 4),
                        cons[index].length > 40
                            ? Flexible(child: ReadMoreText(subtitle: cons[index]))
                            : Flexible(
                                child: Text(
                                  cons[index],
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CompanyDetailsCard extends StatelessWidget {
  const CompanyDetailsCard({super.key, required this.companyDetails});

  final AboutCompany? companyDetails;

  @override
  Widget build(BuildContext context) {
    final data = [
      if (companyDetails?.yearFounded != null) "Founded in ${companyDetails?.yearFounded}",
      if (companyDetails?.managingDirector != null)
        "Managing Director: ${companyDetails?.managingDirector}",
      if (companyDetails?.aboutCompany != null) "${companyDetails?.aboutCompany?.trim()}"
    ];

    return Container(
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width,
      decoration: AppBoxDecoration.getBoxDecoration(
        borderRadius: 10,
        border: Border.all(color: AppColors.lightGrey),
      ),
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.aliceBlue,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: Text(
              "Company Details",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 8),
          ...List.generate(
            data.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4, right: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right, color: Colors.black, size: 18),
                    const SizedBox(width: 4),
                    data[index].length > 60
                        ? Flexible(child: ReadMoreText(subtitle: data[index]))
                        : Flexible(
                            child: Text(
                              data[index],
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          )
                  ],
                ),
              );
            },
          )
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
      decoration: AppBoxDecoration.getBoxDecoration(
        borderRadius: 10,
        border: Border.all(color: AppColors.lightGrey),
      ),
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.aliceBlue,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: Text(
              "Company Financials in Cr.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
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
                    return Text(
                      financials?[0].yearly?[index].year?.toString() ?? "",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.boulder,
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(color: Colors.black),
          ...List.generate(financials?.length ?? 0, (mainIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
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
                      return Text(
                        financials?[mainIndex].yearly?[index].value?.toStringAsFixed(2) ?? "-",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
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
    );
  }
}
