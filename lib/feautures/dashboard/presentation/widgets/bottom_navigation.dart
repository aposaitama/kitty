import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/feautures/dashboard/presentation/cubit/navigation_cubit.dart';

class CustomButtomNavigationBar extends StatefulWidget {
  const CustomButtomNavigationBar({super.key});

  @override
  _CustomButtomNavigationBarState createState() =>
      _CustomButtomNavigationBarState();
}

class _CustomButtomNavigationBarState extends State<CustomButtomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, String>(
      builder: (context, currentRoute) {
        return Container(
          height: 70,
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color.fromARGB(255, 202, 202, 202),
                  width: 1.0,
                ),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  context,
                  currentRoute,
                  'assets/icons/Category name=Report, Status=inactive.svg',
                  'assets/icons/Category name=Report, Status=active.svg',
                  '/report',
                ),
                _buildNavItem(
                  context,
                  currentRoute,
                  'assets/icons/Category name=Home, Status=inactive.svg',
                  'assets/icons/Category name=Home, Status=active.svg',
                  '/home',
                ),
                _buildNavItem(
                  context,
                  currentRoute,
                  'assets/icons/Category name=Settings, Status=inactive.svg',
                  'assets/icons/Category name=Settings, Status=active.svg',
                  '/settings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String currentRoute,
    String path,
    String selectedPath,
    String routeName,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<NavigationCubit>().updateRoute(routeName);
        GoRouter.of(context).go(routeName);
      },
      child: SvgPicture.asset(
        currentRoute == routeName ? selectedPath : path,
      ),
    );
  }
}
