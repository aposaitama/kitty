import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/pages/home_page/widget/month_item_tile.dart';
import 'package:kitty/pages/report_page/cubit/statistics_date_cubit.dart';
import 'package:kitty/styles/colors.dart';

class StatDatePickerOverlay extends StatefulWidget {
  const StatDatePickerOverlay({super.key});

  @override
  State<StatDatePickerOverlay> createState() => _StatDatePickerOverlayState();
}

class _StatDatePickerOverlayState extends State<StatDatePickerOverlay> {
  List month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  int? selectedMonth;
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _showCalendarOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: GestureDetector(
          onTap: () {
            _removeOverlay();
          },
          child: Material(
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 140,
                ),
                child: Container(
                  height: 262,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PICK A MONTH',
                            style: TextStyle(
                              color: AppColors.introMainText,
                              fontFamily: 'Inter',
                              fontSize: 10.0,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Expanded(
                        child:
                            BlocBuilder<StatisticsCubit, Map<String, dynamic>>(
                          builder: (context, selectedMonth) {
                            print(selectedMonth);
                            return GridView.builder(
                              padding: const EdgeInsets.all(0.0),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.5,
                                crossAxisSpacing: 22.0,
                                mainAxisSpacing: 16.0,
                              ),
                              itemCount: month.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<StatisticsCubit>()
                                        .selectMonth(index);
                                    final indexMonth =
                                        selectedMonth['month'] + 1;
                                    print(indexMonth);
                                    // _removeOverlay();
                                  },
                                  child: MonthItemTile(
                                    month: month[index].substring(0, 3),
                                    isSelected:
                                        selectedMonth['month'] == month[index],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: context.read<StatisticsCubit>().decrementYear,
          child: Transform.rotate(
            angle: 3.1415,
            child: SvgPicture.asset(
              'assets/icons/right.svg',
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _showCalendarOverlay(context),
          child: Container(
            height: 32.0,
            decoration: BoxDecoration(
              color: AppColors.circleGreyColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/calendar_icon.svg',
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  BlocBuilder<StatisticsCubit, Map<String, dynamic>>(
                    builder: (context, state) {
                      final monthName =
                          context.read<StatisticsCubit>().getMonthName();
                      final year = state['year'];

                      return Text(
                        '$monthName, $year',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: context.read<StatisticsCubit>().incrementYear,
          child: SvgPicture.asset(
            'assets/icons/right.svg',
          ),
        )
      ],
    );
  }
}
