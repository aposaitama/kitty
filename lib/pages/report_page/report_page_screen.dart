import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/styles/colors.dart';

class ReportPageScreen extends StatelessWidget {
  const ReportPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Column(
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
