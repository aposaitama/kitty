import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/pages/report_page/cubit/categories_cubit.dart';
import 'package:kitty/pages/report_page/cubit/statistics_date_cubit.dart';
import 'package:kitty/pages/report_page/widgets/categories_list.dart';
import 'package:kitty/pages/report_page/widgets/stat_date_picker_overlay.dart';
import 'package:kitty/pages/report_page/widgets/statistics_widget.dart';
import 'package:kitty/styles/colors.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPageScreen extends StatefulWidget {
  const ReportPageScreen({super.key});

  @override
  State<ReportPageScreen> createState() => _ReportPageScreenState();
}

class _ReportPageScreenState extends State<ReportPageScreen> {
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentYear = now.year;
    context
        .read<CategoriesCubit>()
        .groupTransactionsByCategory(currentYear, currentMonth);

    context.read<CategoriesCubit>().startListeningToMonthChanges(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "statistics".tr(),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 20.0,
            letterSpacing: 0.18,
            fontWeight: FontWeight.w900,
            color: AppColors.header,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 31.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: StatDatePickerOverlay(),
              ),
              Text(
                "overview".tr(),
                style: const TextStyle(
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
                  if (summary.isEmpty) {
                    return const Center(
                      child: Text(
                        'No data.',
                      ),
                    );
                  } else {
                    return StatisticsWidget(
                      summary: summary,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                "details".tr(),
                style: const TextStyle(
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
              const CategoriesList()
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: BlocBuilder<StatisticsCubit, Map<String, dynamic>>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () async {
                    final pdf = pw.Document();

                    // Отримуємо поточний рік та місяць зі StatisticsCubit
                    final statsState = context.read<StatisticsCubit>().state;
                    final selectedYear = statsState['year'] as int;
                    final selectedMonth = statsState['month'] as int;

                    // Отримуємо витрати за обраний місяць і рік
                    final groupedExpenses = await context
                        .read<CategoriesCubit>()
                        .getGroupedTransactionsByCategory(
                            selectedYear, selectedMonth);

                    // Генеруємо PDF звіт
                    pdf.addPage(
                      pw.Page(
                        build: (pw.Context context) {
                          return pw.Column(
                            children: [
                              pw.Text(
                                'Kitty',
                                style: pw.TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 20.0),
                              pw.Text(
                                'Report for $selectedMonth/$selectedYear',
                                style: pw.TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 10.0),
                              ...groupedExpenses.entries.map((categoryEntry) {
                                final category = categoryEntry.key;
                                final categoryDetails = categoryEntry.value;

                                final totalSum = categoryDetails['Total'];
                                final transactionCount =
                                    categoryDetails['count'].toString();

                                return pw.Column(
                                  // Переконайтесь, що тут є `return`
                                  children: [
                                    pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text(
                                          category,
                                          style: pw.TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        pw.Text(
                                          '$transactionCount transactions',
                                          style: const pw.TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        pw.Text(
                                          totalSum.toStringAsFixed(0),
                                          style: pw.TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(height: 16.0),
                                  ],
                                );
                              }).toList(), // Додайте `.toList()` до кінця map
                            ],
                          );
                        },
                      ),
                    );

                    // Збереження PDF
                    final output = await getApplicationDocumentsDirectory();
                    final file = File('${output.path}/report.pdf');
                    await file.writeAsBytes(await pdf.save());

                    // Відкриваємо файл
                    OpenFile.open(file.path);
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.blueStackButton,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/download.svg',
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            "downloadReport".tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
