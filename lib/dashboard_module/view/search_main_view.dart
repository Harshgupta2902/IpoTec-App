import 'package:flutter/material.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/constants/functions.dart';
import 'package:ipotec/utilities/packages/debouncer.dart';

class SearchMainView extends StatefulWidget {
  const SearchMainView({super.key});

  @override
  State<SearchMainView> createState() => _SearchMainViewState();
}

class _SearchMainViewState extends State<SearchMainView> {
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
              // _coreSearchController.getSearchResult(
              //   filter: {},
              //   searchValue: value,
              // );
            });
            // _filteredCountries = widget.countryList.stringSearch(value)
            //   ..sort(
            //     (a, b) => a
            //         .localizedName(widget.languageCode)
            //         .compareTo(b.localizedName(widget.languageCode)),
            //   );
            // if (mounted) setState(() {});
          },
        ),
      ),
    );
  }
}
