import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/mainboard_ipo_details_controller.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _mainBoardIpoDetailsController = Get.put(MainBoardDetailsController());

class MainboardIpoDetailsView extends StatefulWidget {
  const MainboardIpoDetailsView({super.key, required this.slug, required this.name});
  final String slug;
  final String name;

  @override
  State<MainboardIpoDetailsView> createState() => _MainboardIpoDetailsViewState();
}

class _MainboardIpoDetailsViewState extends State<MainboardIpoDetailsView> {
  @override
  void initState() {
    _mainBoardIpoDetailsController.getMainboardDetails(slug: widget.slug);
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
      body: _mainBoardIpoDetailsController.obx(
        (state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: AppBoxDecoration.getBoxDecoration(),
                  child: Row(
                    children: [
                      state?.logoUrl?.contains("http") == true
                          ? CachedImageNetworkContainer(
                              height: 45,
                              width: 45,
                              decoration: AppBoxDecoration.getBoxDecoration(
                                borderRadius: 10,
                              ),
                              url: state?.logoUrl,
                              placeHolder:
                                  buildPlaceholder(name: state?.growwShortName, context: context),
                            )
                          : Container(
                              height: 45,
                              width: 45,
                              decoration: AppBoxDecoration.getBoxDecoration(
                                borderRadius: 10,
                              ),
                              child: SvgPicture.asset(
                                getLogoPath(state?.growwShortName ?? "-"),
                              ),
                            ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state?.companyName ?? "-",
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                            ),
                            if (state?.listing != null ||
                                state?.listing?.listedOn?.isNotEmpty == true) ...[
                              ...List.generate(
                                state?.listing?.listedOn?.length ?? 0,
                                (index) {
                                  return Text(state?.listing?.listedOn?[index] ?? "-");
                                },
                              )
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
