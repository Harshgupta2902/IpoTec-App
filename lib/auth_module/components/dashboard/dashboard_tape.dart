import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/controller/tape_controller.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _tapeController = Get.put(TapeController());

class DashboardTape extends StatefulWidget {
  const DashboardTape({super.key});

  @override
  State<DashboardTape> createState() => _DashboardTapeState();
}

class _DashboardTapeState extends State<DashboardTape> {
  late ScrollController _scrollController;
  late Timer _timer;

  void startContinuousScroll() {
    const scrollDuration = Duration(milliseconds: 50); // Smooth scrolling
    const scrollStep = 2.0; // Small scroll step for seamless movement

    _timer = Timer.periodic(scrollDuration, (timer) {
      if (_scrollController.hasClients) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double currentScrollOffset = _scrollController.offset;

        if (currentScrollOffset >= maxScrollExtent) {
          // Reset to the start for seamless scrolling
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            currentScrollOffset + scrollStep,
            duration: scrollDuration,
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tapeController.getTape();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startContinuousScroll();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _tapeController.obx(
      (state) {
        return SizedBox(
          height: 44,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (state?.data?.length ?? 0) * 100,
            itemBuilder: (context, index) {
              final indexes = index % (state?.data?.length ?? 1);
              final item = state?.data?[indexes];

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?.symbol == "1"
                          ? "BSE BANKEX"
                          : item?.symbol == "14"
                              ? "BSE SENSEX"
                              : item?.symbol ?? "",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      "${item?.price?.toStringAsFixed(2)} (${item?.dayChangePerc?.toStringAsFixed(2)}%)",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: "${item?.dayChange.toString()}".contains("-")
                                ? AppColors.cadmiumRed
                                : Colors.green,
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      onLoading: const SizedBox.shrink(),
    );
  }
}
