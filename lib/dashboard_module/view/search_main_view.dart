import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/search_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/navigation/go_paths.dart';
import 'package:ipotec/utilities/navigation/navigator.dart';
import 'package:ipotec/utilities/packages/debouncer.dart';
import 'package:ipotec/utilities/theme/app_box_decoration.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _searchController = Get.put(SearchResultsController());

class SearchMainView extends StatefulWidget {
  const SearchMainView({super.key});

  @override
  State<SearchMainView> createState() => _SearchMainViewState();
}

class _SearchMainViewState extends State<SearchMainView> {
  final TextEditingController searchController = TextEditingController();
  late final Debounce debounce;

  @override
  void initState() {
    debounce = Debounce(delay: 400);
    searchController.clear();
    _searchController.state?.content?.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoreAppBar(
        showActions: false,
        centerTitle: false,
        showBackButton: true,
        titleWidget: TextField(
          controller: searchController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(Icons.search, size: 22),
            fillColor: Colors.transparent,
            hintText: "Search",
          ),
          inputFormatters: [TextOnlyFormatter()],
          onChanged: (value) {
            debounce.run(() {
              _searchController.getSearchResults(search: value);
            });
          },
        ),
      ),
      body: _searchController.obx(
        (state) {
          if (state == null) {
            return const Text("sdd");
          }

          return state.content?.isEmpty == true
              ? const Center(
                  child: Text("No Data Found"),
                )
              : ListView.separated(
                  itemCount: state.content?.length ?? 0,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: (context, index) {
                    final data = state.content?[index];
                    return GestureDetector(
                      onTap: () => MyNavigator.pushReplacementNamed(
                        GoPaths.mainBoardDetails,
                        extra: {'slug': data?.searchId, 'name': data?.title},
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: AppBoxDecoration.getBoxDecoration(),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: AppBoxDecoration.getBoxDecoration(
                                    borderRadius: 10,
                                  ),
                                  child: SvgPicture.asset(
                                    getLogoPath(data?.title?[0] ?? "-"),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    data?.title ?? "",
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.onyx, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                );
        },
      ),
    );
  }
}
