import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipotec/dashboard_module/modal/drawer/ipo_forms_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class IpoFormsCard extends StatelessWidget {
  const IpoFormsCard({
    super.key,
    this.state,
  });

  final Forms? state;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: AppBoxDecoration.getBoxDecoration(),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => MyNavigator.pushNamed(
              GoPaths.commonDetails,
              extra: {
                'slug': state?.slug,
                'name': state?.companyName,
              },
            ),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: AppBoxDecoration.getBoxDecoration(
                    borderRadius: 10,
                  ),
                  child: SvgPicture.asset(
                    getLogoPath(state?.companyName ?? "-"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${state?.companyName}",
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.onyx, fontWeight: FontWeight.w500),
                      ),
                      if (state?.date != null)
                        Text(
                          state?.date ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppColors.boulder),
                        )
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                SvgPicture.asset(AssetPath.viewSvg),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () => linkOnTap(link: state?.bseLink, title: state?.companyName),
                  child: Container(
                    decoration: AppBoxDecoration.getBoxDecoration(
                        color: AppColors.porcelain, borderRadius: 4),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "BSE FORM LINK",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: state?.bseLink != null ? AppColors.primaryColor : Colors.black,
                          decoration: state?.bseLink != null ? TextDecoration.underline : null,
                          decorationColor: AppColors.primaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Flexible(
                child: GestureDetector(
                  onTap: () => linkOnTap(link: state?.nseLink, title: state?.companyName),
                  child: Container(
                    decoration: AppBoxDecoration.getBoxDecoration(
                        color: AppColors.porcelain, borderRadius: 4),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "NSE FORM LINK",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: state?.nseLink != null ? AppColors.primaryColor : Colors.black,
                          decoration: state?.nseLink != null ? TextDecoration.underline : null,
                          decorationColor: AppColors.primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

void linkOnTap({String? link, String? title}) {
  if (link == null) {
    return;
  }
  MyNavigator.pushNamed(
    GoPaths.webView,
    extra: {
      'url': link,
      'title': title,
    },
  );
}
