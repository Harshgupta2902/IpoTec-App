import 'package:flutter/material.dart';
import 'package:ipotec/main.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

enum MessageScaffoldType {
  success,
  error,
  warning,
  information,
}

messageScaffold({
  required String content,
  int duration = 3,
  Enum messageScaffoldType = MessageScaffoldType.information,
  bool isTop = false,
}) {
  Color backgroundColor = AppColors.whiteFrost;
  Color mainColor = AppColors.primaryColor;
  IconData stateIcon = Icons.info_outline;

  switch (messageScaffoldType) {
    case MessageScaffoldType.success:
      backgroundColor = AppColors.hintOfGreen;
      mainColor = AppColors.shareGreen;
      stateIcon = Icons.check;
      break;

    case MessageScaffoldType.error:
      mainColor = AppColors.red;
      backgroundColor = AppColors.bgRed;
      stateIcon = Icons.cancel_outlined;
      break;

    case MessageScaffoldType.warning:
      backgroundColor = AppColors.bgYellow;
      mainColor = AppColors.yellow;
      stateIcon = Icons.warning_amber;
      break;

    case MessageScaffoldType.information:
      backgroundColor = AppColors.whiteFrost;
      mainColor = AppColors.primaryColor;
      stateIcon = Icons.info_outline;
      break;
  }

  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      elevation: 2,
      closeIconColor: Colors.grey,
      showCloseIcon: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: mainColor, width: 0.4),
      ),
      content: Row(
        children: [
          Icon(stateIcon, color: mainColor),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              content,
              style: TextStyle(
                color: mainColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}
