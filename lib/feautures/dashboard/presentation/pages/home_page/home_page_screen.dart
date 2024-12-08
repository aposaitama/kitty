import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/feautures/dashboard/presentation/styles/colors.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

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
                  SvgPicture.asset('assets/icons/Logo.svg'),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/search_black_24dp 1.svg'),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(30)),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Container(
              width: 130,
              height: 48,
              decoration: BoxDecoration(
                  color: AppColors.blueStackButton,
                  borderRadius: BorderRadius.circular(30)),
            ),
          )
        ]),
      ),
    );
  }
}
