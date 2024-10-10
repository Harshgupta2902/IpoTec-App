import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/drawer/common_details_controller.dart';
import 'package:ipotec/dashboard_module/modal/drawer/common_details_model.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
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
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NameCard(name: widget.name),
                ...List.generate(
                  state?.ulAfterHeadingsResult?.length ?? 0,
                  (index) {
                    return CompanyDetailsCard(
                      header: state?.ulAfterHeadingsResult?[index].heading,
                      companyDetails: state?.ulAfterHeadingsResult?[index].items,
                    );
                  },
                ),
                ...List.generate(
                  state?.tables?.length ?? 0,
                  (index) {
                    return FinancialAllocationCard(
                      tables: state?.tables?[index],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CompanyDetailsCard extends StatelessWidget {
  const CompanyDetailsCard({
    super.key,
    required this.companyDetails,
    required this.header,
  });

  final List<String>? companyDetails;
  final String? header;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width,
      decoration: AppBoxDecoration.getBoxDecoration(
        borderRadius: 10,
        border: Border.all(color: AppColors.lightGrey),
      ),
      margin: const EdgeInsets.only(bottom: 16),
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
              "$header",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 8),
          ...List.generate(
            companyDetails?.length ?? 0,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4, right: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right, color: Colors.black, size: 18),
                    const SizedBox(width: 4),
                    (companyDetails?[index].length ?? 0) > 60
                        ? Flexible(child: ReadMoreText(subtitle: companyDetails?[index]))
                        : Flexible(
                            child: Text(
                              companyDetails?[index] ?? "",
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
  const FinancialAllocationCard({super.key, this.tables});

  final List<Tables>? tables;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width,
      decoration: AppBoxDecoration.getBoxDecoration(
        borderRadius: 10,
        border: Border.all(color: AppColors.lightGrey),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              tables?.length ?? 0,
              (index) {
                return Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        tables?[index].column1 ?? "",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: tables?[index].column3 != null
                          ? 100
                          : MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        tables?[index].column2 ?? "",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    if (tables?[index].column3 != null)
                      SizedBox(
                        width: 100,
                        child: Text(
                          tables?[index].column3 ?? "",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    if (tables?[index].column4 != null)
                      SizedBox(
                        width: 100,
                        child: Text(
                          tables?[index].column4 ?? "",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    if (tables?[index].column5 != null)
                      SizedBox(
                        width: 100,
                        child: Text(
                          tables?[index].column5 ?? "",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    if (tables?[index].column6 != null)
                      SizedBox(
                        width: 100,
                        child: Text(
                          tables?[index].column6 ?? "",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NameCard extends StatelessWidget {
  const NameCard({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppBoxDecoration.getBoxDecoration(),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: AppBoxDecoration.getBoxDecoration(
              borderRadius: 10,
            ),
            child: SvgPicture.asset(
              getLogoPath(name),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
