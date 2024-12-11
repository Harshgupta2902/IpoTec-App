import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

class SmeCalendarView extends StatefulWidget {
  const SmeCalendarView({super.key});

  @override
  SmeCalendarViewState createState() => SmeCalendarViewState();
}

class SmeCalendarViewState extends State<SmeCalendarView> {
  DateTime _currentMonth = DateTime.now();
  int _selectedIndex = 0;

  List<DateTime> getDisplayDates(DateTime currentDate) {
    final firstDateOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    final lastDateOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

    DateTime firstDisplayDate = firstDateOfMonth;
    DateTime lastDisplayDate = lastDateOfMonth;

    while (firstDisplayDate.weekday != DateTime.sunday) {
      firstDisplayDate = firstDisplayDate.subtract(const Duration(days: 1));
    }

    // Adjust to the end of the week (Saturday)
    while (lastDisplayDate.weekday != DateTime.saturday) {
      lastDisplayDate = lastDisplayDate.add(const Duration(days: 1));
    }

    // Generate all dates within the range
    List<DateTime> dates = [];
    for (DateTime date = firstDisplayDate;
        date.isBefore(lastDisplayDate);
        date = date.add(const Duration(days: 1))) {
      dates.add(date);
    }

    return dates;
  }

  _getDates(int index) {
    setState(() {
      final previousMonth = _currentMonth;
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + index);
      if (index == 0) {
        _currentMonth = DateTime.now();
        setState(() {
          _selectedIndex = index;
        });
        debugPrint("-----------| _selectedIndex : $_selectedIndex ");
        return;
      }
      if (index != 0) {
        if (_currentMonth.isAfter(previousMonth)) {
          _selectedIndex++;
        } else if (_currentMonth.isBefore(previousMonth)) {
          _selectedIndex--;
        }
      }

      debugPrint("---------- index : $index $_currentMonth  -| _selectedIndex : $_selectedIndex ");

      getDisplayDates(_currentMonth);
    });
  }

  DateTime? selectedDate = DateTime.now();

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = getDisplayDates(_currentMonth);
    final monthName = DateFormat('MMMM yyyy').format(_currentMonth);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CoreAppBar(
        title: "Mainboard Calender",
        showBackButton: true,
        centerTitle: false,
        showActions: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    monthName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _getDates(-1);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          _getDates(1);
                        },
                        child: const Icon(Icons.arrow_forward),
                      ),
                      const SizedBox(width: 14),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                          backgroundColor: AppColors.primaryColor,
                          minimumSize: const Size(60, 36),
                        ),
                        onPressed: () {
                          _getDates(0);

                          DateTime now = DateTime.now();
                          setState(() {
                            selectedDate = DateTime(now.year, now.month, now.day);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Today",
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    letterSpacing: 0.15,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      7,
                      (index) {
                        List<String> weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
                        return Flexible(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            color: AppColors.primaryColor.withOpacity(0.5),
                            child: Text(
                              weekdays[index],
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7, mainAxisExtent: 80
                        // childAspectRatio: 0.6,
                        ),
                    itemCount: daysInMonth.length,
                    itemBuilder: (context, index) {
                      DateTime now = DateTime.now();
                      final day = daysInMonth[index];
                      final today = DateFormat('yyyy-MM-dd').format(now);
                      final isToday = DateFormat('yyy-MM-dd').format(day);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = day;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                          color: isToday == today
                              ? AppColors.primaryColor.withOpacity(0.2)
                              : day.month != _currentMonth.month
                                  ? Colors.white
                                  : selectedDate != null &&
                                          day.day == selectedDate!.day &&
                                          day.month == selectedDate!.month &&
                                          day.year == selectedDate!.year
                                      ? AppColors.primaryColor.withOpacity(0.5)
                                      : Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${day.day}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: day.month == _currentMonth.month
                                      ? (day.weekday == DateTime.sunday ? Colors.red : Colors.black)
                                      : Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  if (selectedDate != null) ...[
                    const Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Date:  ",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                              children: [
                                TextSpan(
                                  text: DateFormat('dd MMMM yyyy').format(selectedDate!),
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              text: "Orders Delivered:  ",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                              children: [
                                TextSpan(
                                  text: "25",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              text: "Orders Earning:  ",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                              children: [
                                TextSpan(
                                  text: "₹1200",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600, color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: selectedDate != null && !isToday(selectedDate!)
          ? FloatingActionButton(
              shape: const CircleBorder(side: BorderSide.none),
              foregroundColor: AppColors.primaryColor,
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                _getDates(0);
                setState(() {
                  selectedDate = DateTime.now();
                });
              },
              child: Text(
                DateFormat('dd').format(DateTime.now()),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white),
              ))
          : null,
    );
  }
}
