import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/pages/report_page/cubit/categories_cubit.dart';
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

    context.read<CategoriesCubit>().groupTransactionsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
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
                  Text(
                    "statistics".tr(),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.header,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/search_black_24dp 1.svg',
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      SvgPicture.asset(
                        'assets/icons/more_vert_black_24dp 1.svg',
                      )
                    ],
                  )
                ],
              ),
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
              }),
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
            child: GestureDetector(
              onTap: () async {
                final pdf = pw.Document();
                final summary = context.read<CategoriesCubit>().state;

                if (summary.isNotEmpty) {
                  pdf.addPage(
                    pw.Page(
                      build: (pw.Context context) {
                        return pw.Column(
                          children: [
                            pw.Text(
                              'Report Overview',
                              style: pw.TextStyle(
                                fontSize: 24,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            ...summary.entries.map((categoryEntry) {
                              final category = categoryEntry.key;
                              final categoryDetails = categoryEntry.value;

                              final backgroundColor =
                                  categoryDetails['backgroundColor'];
                              final categoryName = category;
                              final percent = categoryDetails['percentage'];
                              final totalSum = categoryDetails['Total'];
                              final transactionCount =
                                  categoryDetails['count'].toString();
                              final iconPath = categoryDetails['iconPath'];

                              return pw.Column(
                                children: [
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Row(
                                        children: [
                                          pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                categoryName,
                                                style: pw.TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                ),
                                              ),
                                              pw.Text(
                                                '$transactionCount transactions',
                                                style: const pw.TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.end,
                                        children: [
                                          pw.Text(
                                            totalSum.toStringAsFixed(0),
                                            style: pw.TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                          ),
                                          pw.Text(
                                            '${percent.toStringAsFixed(0)}%',
                                            style: const pw.TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 16.0),
                                ],
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  pdf.addPage(pw.Page(
                    build: (pw.Context context) {
                      return pw.Center(
                        child: pw.Text('No data available for the report'),
                      );
                    },
                  ));
                }

                final output = await getApplicationDocumentsDirectory();
                final file = File('${output.path}/report.pdf');
                await file.writeAsBytes(await pdf.save());
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
                      SvgPicture.asset('assets/icons/download.svg'),
                      const SizedBox(width: 6.0),
                      Text(
                        "downloadReport".tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
