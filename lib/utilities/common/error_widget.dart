import 'package:flutter/material.dart';
import 'package:ipotec/utilities/common/key_value_pair_model.dart';
import 'package:ipotec/utilities/constants/assets_path.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class OnErrorWidget extends StatefulWidget {
  const OnErrorWidget({
    super.key,
    this.error,
    this.message,
  });

  final String? error;
  final String? message;

  @override
  State<OnErrorWidget> createState() => _OnErrorWidgetState();
}

class _OnErrorWidgetState extends State<OnErrorWidget> {
  late final KeyValuePairModel<String, String, void> coreKeyValuePairModel;

  final Map<String, KeyValuePairModel<String, String, void>> errorMap = {
    "500": KeyValuePairModel(
      key: "Internal Server Error",
      value: "Oops! Something went wrong on our end. Please try again later.",
      extra: AssetPath.error500,
    ),
    "404": KeyValuePairModel(
      key: "404 - Not Found",
      value: "Sorry, the page you are looking for does not exist.",
      extra: AssetPath.error404,
    ),
    "000": KeyValuePairModel(
      key: "Empty List",
      value: "No data found.",
      extra: AssetPath.error000,
    ),
  };

  late final String errorCode;

  @override
  void initState() {
    super.initState();
    errorCode = getErrorCodeFromError(widget.error);

    coreKeyValuePairModel = errorMap[errorCode]!;
  }

  String getErrorCodeFromError(String? errorMessage) {
    if (errorMessage == null) {
      return "500";
    }

    final RegExp errorCodeRegExp = RegExp(r'\b\d{3}\b');
    final match = errorCodeRegExp.firstMatch(errorMessage);
    if (match != null) {
      return match.group(0)!;
    } else {
      return "500";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          coreKeyValuePairModel.extra ?? "",
          height: 256,
          width: 256,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Text(
            widget.message ?? coreKeyValuePairModel.value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.boulder),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
