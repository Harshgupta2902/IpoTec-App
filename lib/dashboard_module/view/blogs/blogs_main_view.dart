import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/blogs/blogs_controller.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/common/error_widget.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

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
    _blogsController.getBlogs(offset: '0', hardLoad: true);
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
      debugPrint(scrollController.position.pixels.toString());
      debugPrint(scrollController.position.maxScrollExtent.toString());
      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    debugPrint("load more start");
    var limit = 1;
    limit += _blogsController.loadMoreCount;
    _blogsController.loadMoreCount += 1;
    await _blogsController.getBlogs(
      offset: limit.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return ListView.builder(
                itemBuilder: (context, index) {
                  final blog = state?.data?[index];
                  return GestureDetector(
                    onTap: () {
                      MyNavigator.pushNamed(
                        GoPaths.webView,
                        extra: {
                          'url': "https://groww.in/blog/${blog?.slug}",
                          'title': blog?.title,
                        },
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 6),
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          CachedImageNetworkContainer(
                            width: 120,
                            height: 70,
                            decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 0),
                            url: blog?.featuredMedia ?? blog?.featuredMediaLegacy,
                            placeHolder: buildPlaceholder(
                              name: blog?.title?[0],
                              context: context,
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Column(
                                children: [
                                  Text(
                                    blog?.title?.replaceAll("&#038;", "&") ?? "",
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: AppColors.onyx,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      convertDate(blog?.publishedAt ?? ""),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: state?.data?.length ?? 0,
              );
            },
            onEmpty: const Center(child: OnErrorWidget(error: "000")),
            onError: (error) => OnErrorWidget(error: error),
          );
        },
      ),
    );
  }
}