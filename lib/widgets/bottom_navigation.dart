import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/route/cubit/navigation_cubit.dart';
import 'package:kitty/styles/colors.dart';

class CustomButtomNavigationBar extends StatefulWidget {
  const CustomButtomNavigationBar({super.key});

  @override
  _CustomButtomNavigationBarState createState() =>
      _CustomButtomNavigationBarState();
}

int _getSelectedIndex(String currentRoute) {
  switch (currentRoute) {
    case '/report':
      return 0;
    case '/home':
      return 1;
    case '/settings':
      return 2;
    default:
      return 0;
  }
}

String _getRouteByIndex(int index) {
  switch (index) {
    case 0:
      return '/report';
    case 1:
      return '/home';
    case 2:
      return '/settings';
    default:
      return '/home';
  }
}

Widget _buildSvgIcon(String currentRoute, String routeName, String inactivePath,
    String activePath) {
  return SvgPicture.asset(
    currentRoute == routeName ? activePath : inactivePath,
  );
}

class _CustomButtomNavigationBarState extends State<CustomButtomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, String>(
      builder: (context, currentRoute) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 202, 202, 202),
                width: 1.0,
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.introMainText,
            unselectedItemColor: AppColors.introMainText,
            backgroundColor: Colors.white,
            unselectedLabelStyle: const TextStyle(
              color: AppColors.introMainText,
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
            selectedLabelStyle: const TextStyle(
              color: AppColors.introMainText,
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
            currentIndex: _getSelectedIndex(currentRoute),
            onTap: (index) {
              String routeName = _getRouteByIndex(index);
              context.read<NavigationCubit>().updateRoute(routeName);
              GoRouter.of(context).go(routeName);
            },
            items: [
              BottomNavigationBarItem(
                icon: _buildSvgIcon(
                    currentRoute,
                    '/report',
                    'assets/icons/Category name=Report, Status=inactive.svg',
                    'assets/icons/Category name=Report, Status=active.svg'),
                label: 'Report',
              ),
              BottomNavigationBarItem(
                icon: _buildSvgIcon(
                    currentRoute,
                    '/home',
                    'assets/icons/Category name=Home, Status=inactive.svg',
                    'assets/icons/Category name=Home, Status=active.svg'),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildSvgIcon(
                    currentRoute,
                    '/settings',
                    'assets/icons/Category name=Settings, Status=inactive.svg',
                    'assets/icons/Category name=Settings, Status=active.svg'),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
