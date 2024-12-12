import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/models/expense.dart';
import 'package:kitty/cubit/add_expenses/expense_cubit.dart';
import 'package:kitty/styles/colors.dart';
import 'package:kitty/widgets/blue_bottom_button.dart';
import 'package:kitty/widgets/custom_text_field.dart';
import 'package:kitty/widgets/drop_down_list_item.dart';

class AddNewExpenseScreen extends StatefulWidget {
  const AddNewExpenseScreen({super.key});

  @override
  State<AddNewExpenseScreen> createState() => _AddNewExpenseScreenState();
}

class _AddNewExpenseScreenState extends State<AddNewExpenseScreen> {
  String expenseOrIncome = 'Expense';
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 72.0,
            color: AppColors.lightGreyHeaderColor,
            child: Column(
              children: [
                const SizedBox(
                  height: 38.0,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 16.0,
                    ),
                    GestureDetector(
                        onTap: () => context.go('/home'),
                        child: SvgPicture.asset(
                            'assets/icons/arrow_back_black_24dp.svg')),
                    const SizedBox(
                      width: 16.0,
                    ),
                    const Text(
                      'Add new',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 24.0,
                ),
                DropDownListItem(
                  text: 'Expense or Income',
                  items: ['Expense', 'Income'],
                  onChanged: (value) {
                    setState(() {
                      expenseOrIncome = value ?? 'Income';
                    });
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                CustomTextField(
                    labelText: 'Category name', controller: categoryController),
                const SizedBox(
                  height: 24.0,
                ),
                CustomTextField(
                    labelText: 'Enter amount', controller: amountController),
                const SizedBox(
                  height: 24.0,
                ),
                CustomTextField(
                    labelText: 'Description (Optional)',
                    controller: descriptionController),
                const SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                final expenseCubit = context.read<ExpenseCubit>();
                expenseCubit.addExpense(
                  Expense(
                      type: expenseOrIncome,
                      category: categoryController.text,
                      amount: amountController.text,
                      description: descriptionController.text,
                      date: DateTime.now()),
                );
                context.go('/home');
              },
              child: const Text('Add Expense'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                context.go('/add_new/add_new_categories');
              },
              child: const Text('Add new categories'),
            ),
          ),
          GestureDetector(
            onTap: () => print(expenseOrIncome),
            child: const BlueBottomButton(
              buttonTitle: 'Add income',
            ),
          )
        ],
      ),
    );
  }
}
