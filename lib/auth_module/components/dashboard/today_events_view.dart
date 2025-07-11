import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/controller/news_controller.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _newsController = Get.put(NewsController());

class NewsEventsView extends StatefulWidget {
  const NewsEventsView({super.key});

  @override
  State<NewsEventsView> createState() => _NewsEventsViewState();
}

class _NewsEventsViewState extends State<NewsEventsView> {
  @override
  void initState() {
    super.initState();
    _newsController.getNews(hardLoad: true, offset: "1");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "News/Events",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        _newsController.obx(
          (state) {
            return ListView.separated(
              itemCount: state?.data?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final newsData = state?.data?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.porcelain,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CachedImageNetworkContainer(
                                  height: 14,
                                  width: 14,
                                  url:
                                      "https://assets.tickertape.in/stock-logos/${newsData?.sid}.png",
                                  placeHolder:
                                      buildPlaceHolderGrowPath(assetPath: newsData?.ticker ?? ""),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  newsData?.ticker?.toUpperCase() ?? "",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.porcelain,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              newsData?.tag?.toUpperCase() ?? "",
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.shuttleGrey,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        newsData?.title ?? "",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.alabaster,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.silverChalice30),
                        ),
                        child: Text(
                          removeHtmlTags(newsData?.desc ?? "").trim(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            newsData?.date ?? "",
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.shuttleGrey,
                                ),
                          ),
                          Text(
                            newsData?.publisher?.toUpperCase() ?? "",
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.shuttleGrey,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 10),
                  child: Divider(color: AppColors.silverChalice30),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
