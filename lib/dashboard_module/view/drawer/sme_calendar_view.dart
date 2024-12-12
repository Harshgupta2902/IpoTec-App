import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ipotec/dashboard_module/controller/drawer/mainboard_calendar_controller.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _smeCalendarController = Get.put(IpoCalendarController());

class SmeCalendarView extends StatefulWidget {
  const SmeCalendarView({super.key});

  @override
  SmeCalendarViewState createState() => SmeCalendarViewState();
}

class SmeCalendarViewState extends State<SmeCalendarView> {
  final DateTime _currentMonth = DateTime.now();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _smeCalendarController.getMainboardCalendar(isSme: true);
    setState(() {
      final todayMinusOne = DateTime.now().day;
      debugPrint(todayMinusOne.toString());
      _selectedIndex = todayMinusOne >= 0 ? todayMinusOne : 0;
    });
  }

  List<DateTime> getDisplayDates(DateTime currentDate) {
    final firstDateOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    final lastDateOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

    DateTime firstDisplayDate = firstDateOfMonth;
    DateTime lastDisplayDate = lastDateOfMonth;

    while (firstDisplayDate.weekday != DateTime.sunday) {
      firstDisplayDate = firstDisplayDate.subtract(const Duration(days: 1));
    }

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

  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final daysInMonth = getDisplayDates(_currentMonth);
    final monthName = DateFormat('MMMM yyyy').format(_currentMonth);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CoreAppBar(
        title: "SME Calender",
        showBackButton: true,
        centerTitle: false,
        showActions: false,
      ),
      body: _smeCalendarController.obx((state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                monthName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
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
                      crossAxisCount: 7,
                      mainAxisExtent: 70,
                    ),
                    itemCount: daysInMonth.length,
                    itemBuilder: (context, index) {
                      DateTime now = DateTime.now();
                      final day = daysInMonth[index];
                      final today = DateFormat('yyyy-MM-dd').format(now);
                      final isToday = DateFormat('yyy-MM-dd').format(day);
                      return GestureDetector(
                        onTap: () {
                          if (day.month != _currentMonth.month) {
                            return;
                          }
                          setState(() {
                            selectedDate = day;
                            _selectedIndex = day.day - 1;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                          decoration: BoxDecoration(
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
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${day.day}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: day.month == _currentMonth.month
                                      ? (day.weekday == DateTime.sunday ? Colors.red : Colors.black)
                                      : AppColors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if ((state?.data?[(day.day - 1)].events?.length ?? 0) > 0) ...[
                                const SizedBox(height: 4),
                                Container(
                                  decoration: BoxDecoration(
                                    color: day.month == _currentMonth.month
                                        ? AppColors.shareGreen
                                        : AppColors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    '${state?.data?[(day.day - 1)].events?.length}',
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ]
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  _smeCalendarController.obx((state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd MMMM yyyy').format(selectedDate!),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.black,
                                ),
                          ),
                          const SizedBox(height: 12),
                          if (state?.data?[_selectedIndex].events?.isEmpty == true) ...[
                            Text(
                              "No Events for Today",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                            )
                          ],
                          ...List.generate(
                            state?.data?[_selectedIndex].events?.length ?? 0,
                            (index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text("• ", style: TextStyle(fontSize: 20)),
                                      Expanded(
                                        child: Text(
                                          "${state?.data?[_selectedIndex].events?[index].eventText}",
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.shuttleGrey,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
