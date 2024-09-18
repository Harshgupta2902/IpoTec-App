import 'package:ipotec/utilities/constants/assets_path.dart';

String getLogoPath(String word) {
  String firstLetter = word[0].toUpperCase();
  switch (firstLetter) {
    case 'A':
      return AssetPath.aLogo;
    case 'B':
      return AssetPath.bLogo;
    case 'D':
      return AssetPath.dLogo;
    case 'E':
      return AssetPath.eLogo;
    case 'G':
      return AssetPath.gLogo;
    case 'I':
      return AssetPath.iLogo;
    case 'K':
      return AssetPath.kLogo;
    case 'N':
      return AssetPath.nLogo;
    case 'O':
      return AssetPath.oLogo;
    case 'P':
      return AssetPath.pLogo;
    case 'R':
      return AssetPath.rLogo;
    case 'S':
      return AssetPath.sLogo;
    case 'T':
      return AssetPath.tLogo;
    case 'W':
      return AssetPath.wLogo;
    default:
      return "Icon not available for the given letter.";
  }
}

String formatBidDates(String bidText) {
  // Check if the dates are announced
  if (bidText.toLowerCase().contains("yet to be announced")) {
    return "NA";
  }

  // Split the string based on "on" and "at" to extract date and time
  List<String> splitOn = bidText.split("on");
  if (splitOn.length > 1) {
    List<String> dateAndTime = splitOn[1].trim().split("at");

    if (dateAndTime.length == 2) {
      String date = dateAndTime[0].trim(); // e.g., 20 Sep
      String time = dateAndTime[1].trim(); // e.g., 10 AM

      // Return formatted string as "Sep 20, 10 AM"
      List<String> dateParts = date.split(" ");
      if (dateParts.length == 2) {
        String day = dateParts[0]; // e.g., 20
        String month = dateParts[1]; // e.g., Sep

        // Format the date as "Sep 20" and return with time
        return "$month $day, $time";
      }
    }
  }

  return "NA"; // Return "NA" if the date or time cannot be parsed
}
