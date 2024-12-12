import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipotec/dashboard_module/modal/ipo_details_model.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key, this.news});

  final List<News>? news;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(news?.length ?? 0, (index) {
          return GestureDetector(
            onTap: () {
              MyNavigator.pushNamed(
                GoPaths.webView,
                extra: {
                  'title': news?[index].title,
                  'url': news?[index].url,
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 6),
              child: Column(
                children: [
                  Text(
                    news?[index].title ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    news?[index].subtitle ?? "",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.black,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        news?[index].timestamp ?? "",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.boulder,
                            ),
                      ),
                      Text(
                        news?[index].publishedBy ?? "",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.boulder,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
