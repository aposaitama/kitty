import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/models/expense/expense.dart';
import 'package:kitty/pages/home_page/widget/type_list_tile_item.dart';
import 'package:kitty/pages/search_page/cubit/categories_cubit.dart';
import 'package:kitty/pages/search_page/cubit/type_by_category_cubit.dart';
import 'package:kitty/pages/search_page/widgets/search_categories_item_tile.dart';
import 'package:kitty/pages/search_page/widgets/sorted_categoty_item_tile.dart';
import 'package:kitty/styles/colors.dart';
import 'package:kitty/widgets/custom_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? categoryName;
  List<String> selectedCategories = [];
  @override
  void initState() {
    super.initState();
    context.read<SearchCategoriesCubit>().fetchCategories();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 35.0,
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
              Expanded(
                child: TextField(
                  controller: searchController,
                  readOnly: false,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintText: 'Search for notes, categories or labels',
                    hintStyle: TextStyle(
                        color: AppColors.hintText,
                        fontFamily: 'Inter',
                        fontSize: 15.0),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          BlocBuilder<SearchCategoriesCubit, List<Categories>>(
            builder: (context, categories) {
              return Padding(
                padding: const EdgeInsets.only(left: 54.0),
                child: SizedBox(
                  height: 33,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected =
                          selectedCategories.contains(category.name);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              //remove category selecting
                              selectedCategories.remove(category.name);
                            } else {
                              //add category selecting
                              selectedCategories.add(category.name);
                            }
                          });
                          context
                              .read<TypeByCategoryCubit>()
                              .fetchItemByCategory(selectedCategories);
                        },
                        child: Row(
                          children: [
                            SearchCategoriesItemTile(
                              name: category.name,
                              iconPath: category.iconPath,
                              backgroundColor: isSelected
                                  ? AppColors.blueBackgroundSelectedColor
                                  : Colors.transparent,
                              borderColor: isSelected
                                  ? AppColors.blueStackButton
                                  : AppColors.categoryBorderColor, // Колір фону
                            ),
                            const SizedBox(width: 10.0),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            height: 1.0,
            decoration: const BoxDecoration(color: AppColors.borderColor),
          ),
          Expanded(
            child: BlocBuilder<TypeByCategoryCubit, Map<String, List<Expense>>>(
              builder: (context, groupedExpenses) {
                if (groupedExpenses.isEmpty) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    itemCount: groupedExpenses.keys.length,
                    itemBuilder: (context, index) {
                      final groupKey = groupedExpenses.keys.elementAt(index);
                      final expenses = groupedExpenses[groupKey]!;

                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1.0, color: AppColors.borderColor),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          groupKey.toUpperCase(),
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 7.0),
                                          child: Text(
                                            expenses
                                                .fold<double>(
                                                  0,
                                                  (sum, item) =>
                                                      item.type == 'Expense'
                                                          ? sum -
                                                              double.parse(
                                                                  item.amount)
                                                          : sum +
                                                              double.parse(
                                                                  item.amount),
                                                )
                                                .toStringAsFixed(0),
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 10.0,
                                              letterSpacing: 1.5,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    ...expenses.map((expense) {
                                      return TypeListTileItem(
                                        categoryIcon: expense.categoryIcon,
                                        type: expense.type,
                                        description: expense.description!,
                                        amount: expense.amount,
                                        name: expense.category,
                                      );
                                    }),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
