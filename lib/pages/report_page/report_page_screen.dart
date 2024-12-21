import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kitty/pages/home_page/widget/month_item_tile.dart';
import 'package:kitty/pages/report_page/cubit/categories_cubit.dart';
import 'package:kitty/pages/report_page/cubit/statistics_date_cubit.dart';
import 'package:kitty/pages/report_page/widgets/details_item_tile.dart';
import 'package:kitty/pages/report_page/widgets/statistics_widget.dart';
import 'package:kitty/styles/colors.dart';

class ReportPageScreen extends StatefulWidget {
  const ReportPageScreen({super.key});

  @override
  State<ReportPageScreen> createState() => _ReportPageScreenState();
}

class _ReportPageScreenState extends State<ReportPageScreen> {
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

  final testSummary = {
    'Groceries': {
      'Total': -10112.0,
      'count': 3,
      'iconPath': 'assets/icons/category_icons/Groceries.svg',
      'percentage': 20.0,
      'backgroundColor': 0xFFC8E6C9
    },
    'TV': {
      'Total': -4000.0,
      'count': 2,
      'iconPath': 'assets/icons/category_icons/Electronics.svg',
      'percentage': 20.0,
      'backgroundColor': 0xFFD7CCC8
    },
    'Cheers': {
      'Total': -100000.0,
      'count': 1,
      'iconPath': 'assets/icons/category_icons/Party.svg',
      'percentage': 60.0,
      'backgroundColor': 0xFFFFCCBC
    }
  };

  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  String getCurrentMonthYear() {
    final now = DateTime.now();
    Intl.defaultLocale = 'en_US';
    final formatter = DateFormat('MMMM, yyyy');
    return formatter.format(now);
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
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 140),
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
                        child: BlocBuilder<StatisticsCubit, String?>(
                          builder: (context, selectedMonth) {
                            return GridView.builder(
                              padding: const EdgeInsets.all(0.0),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 2.5,
                                      crossAxisSpacing: 22.0,
                                      mainAxisSpacing: 16.0),
                              itemCount: month.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<StatisticsCubit>()
                                        .selectMonth(month[index]);
                                    // _removeOverlay(); // Закриваємо оверлей після вибору
                                  },
                                  child: MonthItemTile(
                                      month: month[index].substring(0, 3),
                                      isSelected:
                                          selectedMonth == month[index]),
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
  void initState() {
    super.initState();

    context.read<CategoriesCubit>().groupTransactionsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Statistics',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.header),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/search_black_24dp 1.svg'),
                      const SizedBox(
                        width: 16.0,
                      ),
                      SvgPicture.asset(
                          'assets/icons/more_vert_black_24dp 1.svg')
                    ],
                  )
                ],
              ),
              const SizedBox(height: 31.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: context.read<StatisticsCubit>().decrementYear,
                      child: Transform.rotate(
                          angle: 3.1415,
                          child: SvgPicture.asset('assets/icons/right.svg')),
                    ),
                    GestureDetector(
                      onTap: () => _showCalendarOverlay(context),
                      child: Container(
                        height: 32.0,
                        decoration: BoxDecoration(
                            color: AppColors.circleGreyColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/icons/calendar_icon.svg'),
                              const SizedBox(
                                width: 8.0,
                              ),
                              BlocBuilder<StatisticsCubit, String?>(
                                builder: (context, selectedMonth) {
                                  final currentYear = context
                                      .read<StatisticsCubit>()
                                      .currentYear;
                                  String monthToDisplay = selectedMonth != null
                                      ? '$selectedMonth, $currentYear'
                                      : getCurrentMonthYear();
                                  return Text(
                                    monthToDisplay,
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
                        onTap: context.read<StatisticsCubit>().decrementYear,
                        child: SvgPicture.asset('assets/icons/right.svg'))
                  ],
                ),
              ),
              const Text(
                'OVERVIEW',
                style: TextStyle(
                  color: AppColors.introMainText,
                  fontFamily: 'Inter',
                  fontSize: 10.0,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              BlocBuilder<CategoriesCubit, Map<String, Map<String, dynamic>>>(
                builder: (context, summary) {
                  print(summary);
                  if (summary.isEmpty) {
                    return const Center(
                        child: Text('Нет данных для отображения.'));
                  } else
                    return StatisticsWidget(
                      testSummary: testSummary,
                    );
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'DETAILS',
                style: TextStyle(
                  color: AppColors.introMainText,
                  fontFamily: 'Inter',
                  fontSize: 10.0,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              BlocBuilder<CategoriesCubit, Map<String, Map<String, dynamic>>>(
                builder: (context, summary) {
                  if (summary.isEmpty) {
                    return const Center(
                        child: Text('Нет данных для отображения.'));
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: summary.length,
                      itemBuilder: (context, index) {
                        final category = summary.keys.elementAt(index);

                        final data = summary[category]!;

                        final total = data['Total'] as double;

                        final int count = data['count'];

                        final percent = data['percentage'];

                        final icon = data['iconPath'] as String;

                        return DetailsItemTile(
                          categoryName: category,
                          percent: percent,
                          totalSum: total,
                          transactionCount: count.toString(),
                          iconPath: icon,
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Container(
              width: 182,
              height: 48,
              decoration: BoxDecoration(
                  color: AppColors.blueStackButton,
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/download.svg'),
                  const SizedBox(
                    width: 6.0,
                  ),
                  const Text(
                    'Download report',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
