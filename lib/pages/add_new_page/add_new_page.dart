import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/models/expense.dart';
import 'package:kitty/cubit/add_expenses/expense_cubit.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_cubit.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_state.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Container(
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
                      const SizedBox(
                        height: 12.0,
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
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return BlocProvider.value(
                                value: context.read<AddNewCategoryCubit>()
                                  ..loadCategory(),
                                child: SizedBox(
                                  height: 390,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8.0),
                                      Container(
                                        width: 20.0,
                                        height: 2.0,
                                        color: AppColors.hintText,
                                      ),
                                      const SizedBox(height: 20.0),
                                      Text(
                                        'Choose Category Icon'.toUpperCase(),
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.header,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Expanded(
                                        child: BlocBuilder<AddNewCategoryCubit,
                                            AddNewCategoryState>(
                                          builder: (context, state) {
                                            if (state is CategoryLoading) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (state
                                                is CategoryLoaded) {
                                              final categories = state.category;
                                              return GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  crossAxisSpacing: 0.0,
                                                  mainAxisSpacing: 0.0,
                                                ),
                                                itemCount: categories.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final category =
                                                      categories[index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      categoryController.text =
                                                          category.name;
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColors
                                                            .circleGreyColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Center(
                                                            child: SvgPicture
                                                                .asset(
                                                              category.iconPath,
                                                              width: 40,
                                                              height: 40,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 6.0,
                                                          ),
                                                          Text(
                                                            category.name,
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .header,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else if (state is CategoryError) {
                                              return Center(
                                                child: Text(
                                                  'Error: ${state.message}',
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                              );
                                            } else {
                                              return const Center(
                                                child: Text(
                                                    'No categories available'),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () => context.go(
                                                '/add_new/add_new_categories'),
                                            child: Container(
                                              width: 159.0,
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color:
                                                          AppColors.hintText)),
                                              child: Center(
                                                child: const Text(
                                                  'Add new category',
                                                  style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors
                                                        .blueStackButton,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: IgnorePointer(
                          child: CustomTextField(
                              labelText: 'Category name',
                              controller: categoryController),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      CustomTextField(
                          labelText: 'Enter amount',
                          controller: amountController),
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
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: GestureDetector(
              onTap: () {
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
              child: BlueBottomButton(
                buttonTitle: 'Add $expenseOrIncome',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
