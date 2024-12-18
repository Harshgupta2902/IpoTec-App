import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/bottom/blogs_controller.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/default_app_drawer.dart';
import 'package:ipotec/utilities/common/error_widget.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';
import 'package:share_plus/share_plus.dart';

final _blogsController = Get.put(BlogsController());

class BlogsMainView extends StatefulWidget {
  const BlogsMainView({super.key});

  @override
  State<BlogsMainView> createState() => _BlogsMainViewState();
}

class _BlogsMainViewState extends State<BlogsMainView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _blogsController.getBlogs(offset: '1', hardLoad: true);
    _blogsController.loadMoreCount = 1;
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    debugPrint("load more start");
    var limit = 2;
    limit += _blogsController.loadMoreCount;
    _blogsController.loadMoreCount += 1;
    await _blogsController.getBlogs(
      offset: limit.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CoreAppBar(
        title: "Blogs",
        centerTitle: false,
        showBackButton: false,
      ),
      body: Builder(
        builder: (context) {
          final controller = PrimaryScrollController.of(context);
          controller.addListener(() {
            if (controller.position.maxScrollExtent == controller.position.pixels) {
              if (_blogsController.isLoading.value == false) {
                _loadMoreData();
              }
            }
          });
          return _blogsController.obx(
            (state) {
              return Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                thickness: 6,
                radius: const Radius.circular(8),
                child: ListView.separated(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    final blog = state?.articles?[index];
                    return GestureDetector(
                      onTap: () {
                        MyNavigator.pushNamed(
                          GoPaths.webView,
                          extra: {
                            'url': blog?.link,
                            'title': blog?.title,
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedImageNetworkContainer(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.22,
                              decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 16),
                              url: blog?.image,
                              placeHolder: buildNetworkPlaceholder(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    blog?.title?.replaceAll("&#038;", "&") ?? "",
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: AppColors.onyx,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CachedImageNetworkContainer(
                                            width: 22,
                                            height: 22,
                                            decoration: AppBoxDecoration.getBoxDecoration(
                                              borderRadius: 16,
                                            ),
                                            url: blog?.logo,
                                            placeHolder: buildNetworkPlaceholder(),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            blog?.watermark ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            blog?.date ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Share.share(blog?.link ?? "");
                                        },
                                        child: SvgPicture.asset(
                                          AssetPath.share,
                                          height: 18,
                                          width: 18,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state?.articles?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return const Divider(color: AppColors.silverChalice30);
                  },
                ),
              );
            },
            onError: (error) => TryAgainWidget(
              onTap: () => _blogsController.getBlogs(hardLoad: true, offset: "1"),
            ),
          );
        },
      ),
    );
  }
}
