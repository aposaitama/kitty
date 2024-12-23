import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/pages/add_new_page/cubit/expense_cubit.dart';
import 'package:kitty/pages/add_new_page/cubit/expense_cubit_state.dart';
import 'package:kitty/styles/colors.dart';

class CalculateTopBar extends StatefulWidget {
  const CalculateTopBar({super.key});

  @override
  State<CalculateTopBar> createState() => _CalculateTopBarState();
}

class _CalculateTopBarState extends State<CalculateTopBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ExpenseLoaded) {
          final totalExpenses = context
              .read<ExpenseCubit>()
              .calculateTotalExpenses(state.expenses);
          final totalIncome =
              context.read<ExpenseCubit>().calculateTotalIncome(state.expenses);
          final balance =
              context.read<ExpenseCubit>().calculateBalance(state.expenses);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/expense.svg',
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    totalExpenses.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'expense'.tr(),
                    style: const TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/balance.svg',
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    balance.toString(),
                    style: const TextStyle(
                      color: AppColors.greenGreyColor,
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'balance'.tr(),
                    style: const TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/income.svg',
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    totalIncome.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'income'.tr(),
                    style: const TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Inter',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
