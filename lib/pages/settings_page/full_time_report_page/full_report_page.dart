import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/pages/report_page/cubit/categories_cubit.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:go_router/go_router.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_cubit.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_state.dart';
import 'package:kitty/pages/settings_page/manage_categories_page/widgets/categories_item_list_tile.dart';

import 'package:kitty/styles/colors.dart';
import 'package:kitty/widgets/blue_bottom_button.dart';

class FullReportPage extends StatefulWidget {
  const FullReportPage({super.key});

  @override
  State<FullReportPage> createState() => _FullReportPageState();
}

class _FullReportPageState extends State<FullReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 32.0,
        titleSpacing: 0,
        backgroundColor: AppColors.greyHeaderColor,
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: GestureDetector(
            onTap: () => context.go('/settings'),
            child: SvgPicture.asset(
              'assets/icons/arrow_back_black_24dp.svg',
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Full report page",
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 34.0,
            ),
            GestureDetector(
                onTap: () async {
                  final pdf = pw.Document();
                  final allExpensesByMonth = await context
                      .read<CategoriesCubit>()
                      .groupExpensesByMonth();

                  if (allExpensesByMonth.isNotEmpty) {
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
                              pw.SizedBox(height: 10.0),
                            ],
                          );
                        },
                      ),
                    );

                    for (MapEntry<String, Map<String, dynamic>> yearMonthEntry
                        in allExpensesByMonth.entries) {
                      final yearMonth = yearMonthEntry.key;
                      final groupedExpenses = yearMonthEntry.value;

                      pdf.addPage(
                        pw.Page(
                          build: (pw.Context context) {
                            return pw.Column(
                              children: [
                                pw.Text(
                                  'Month: $yearMonth',
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                ...groupedExpenses.entries.map((categoryEntry) {
                                  final category = categoryEntry.key;
                                  final categoryDetails = categoryEntry.value;

                                  final totalSum = categoryDetails['Total'];
                                  final transactionCount =
                                      categoryDetails['count'].toString();

                                  return pw.Column(
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
                                }),
                                pw.SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                      );
                    }
                  } else {
                    pdf.addPage(
                      pw.Page(
                        build: (pw.Context context) {
                          return pw.Center(
                            child: pw.Text('No data available for the report'),
                          );
                        },
                      ),
                    );
                  }

                  final output = await getApplicationDocumentsDirectory();
                  final file = File('${output.path}/report.pdf');
                  await file.writeAsBytes(
                    await pdf.save(),
                  );
                  OpenFile.open(file.path);
                },
                child: const BlueBottomButton(buttonTitle: 'Create report'))
          ],
        ),
      ),
    );
  }
}
