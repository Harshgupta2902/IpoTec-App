import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/dashboard_module/controller/search_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/debouncer.dart';

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
    );
  }
}
