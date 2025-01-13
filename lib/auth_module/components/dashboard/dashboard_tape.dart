import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipotec/auth_module/controller/tape_controller.dart';
import 'package:ipotec/utilities/theme/app_colors.dart';

final _tapeController = Get.put(TapeController());

class DashboardTape extends StatefulWidget {
  const DashboardTape({super.key, this.textColor, this.isBlur = false});

  final Color? textColor;
  final bool? isBlur;

  @override
  State<DashboardTape> createState() => _DashboardTapeState();
}

class _DashboardTapeState extends State<DashboardTape> {
  late ScrollController _scrollController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tapeController.getTape();
      startContinuousScroll();
    });
  }

  void startContinuousScroll() {
    const scrollDuration = Duration(milliseconds: 50); // Smooth scrolling
    const scrollStep = 2.0;

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
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (state?.data?.length ?? 0) * 1000,
            itemBuilder: (context, index) {
              final indexes = index % (state?.data?.length ?? 1);
              final item = state?.data?[indexes];

              final child = Container(
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
                            color: widget.textColor,
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

              if (widget.isBlur == true) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteFrost.withOpacity(0.2),
                      ),
                      child: child,
                    ),
                  ),
                );
              }
              return child;
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
          ),
        );
      },
      onLoading: const SizedBox.shrink(),
    );
  }
}

class BlurryContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double elevation;
  final double blur;
  final EdgeInsetsGeometry padding;
  final Color color;
  final BorderRadius borderRadius;

  const BlurryContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.blur = 5,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  const BlurryContainer.square({
    super.key,
    required this.child,
    double? dimension,
    this.blur = 5,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  })  : width = dimension,
        height = dimension;

  const BlurryContainer.expand({
    super.key,
    required this.child,
    this.blur = 5,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.transparent,
    this.borderRadius = BorderRadius.zero,
  })  : width = double.infinity,
        height = double.infinity;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            height: height,
            width: width,
            padding: padding,
            color: color,
            child: child,
          ),
        ),
      ),
    );
  }
}
