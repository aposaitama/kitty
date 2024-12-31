import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go_router/go_router.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_cubit.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_state.dart';
import 'package:kitty/pages/settings_page/manage_categories_page/widgets/categories_item_list_tile.dart';

import 'package:kitty/styles/colors.dart';

class ManageCategoriesPage extends StatefulWidget {
  const ManageCategoriesPage({super.key});

  @override
  State<ManageCategoriesPage> createState() => _ManageCategoriesPageState();
}

class _ManageCategoriesPageState extends State<ManageCategoriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<AddNewCategoryCubit>().loadCategory();
  }

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
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "manage_categories".tr(),
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: BlocBuilder<AddNewCategoryCubit, AddNewCategoryState>(
                    builder: (context, state) {
                      if (state is CategoryError) {
                        return Center(
                          child: Text(
                            'Error: ${state.message}',
                          ),
                        );
                      }
                      if (state is CategoryLoaded) {
                        final categories = state.category;
                        if (categories.isNotEmpty) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height - 142,
                            child: ReorderableListView.builder(
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  return CategoriesItemListTile(
                                    iconPath: category.icon,
                                    categoryName: category.name,
                                    key: Key(
                                      category.id.toString(),
                                    ),
                                  );
                                },
                                onReorder: (oldIndex, newIndex) async {
                                  if (oldIndex < newIndex) {
                                    newIndex -= 1;
                                  }
                                  final movedCategory = categories.removeAt(
                                    oldIndex,
                                  );
                                  categories.insert(
                                    newIndex,
                                    movedCategory,
                                  );

                                  //change order in db
                                  await context
                                      .read<AddNewCategoryCubit>()
                                      .updateCategoryOrder(
                                        categories,
                                      );
                                  setState(
                                    () {},
                                  );
                                }),
                          );
                        } else {
                          return const Text(
                            'No categories',
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 32.0,
          ),
          child: GestureDetector(
            onTap: () => context.go('/manage_categories/add_new_categories'),
            child: Container(
              height: 48.0,
              decoration: BoxDecoration(
                color: AppColors.blueStackButton,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    "add_new_category".tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
