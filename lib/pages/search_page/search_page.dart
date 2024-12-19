import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/pages/search_page/cubit/categories_cubit.dart';
import 'package:kitty/pages/search_page/widgets/search_categories_item_tile.dart';
import 'package:kitty/styles/colors.dart';
import 'package:kitty/widgets/custom_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    context.read<SearchCategoriesCubit>().fetchCategories();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
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
              height: 16.0,
            ),
            BlocBuilder<SearchCategoriesCubit, List<Categories>>(
              builder: (context, categories) {
                return SizedBox(
                  height: 33,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return GestureDetector(
                        onTap: () {
                          // context
                          //     .read<SelectedCategoryCubit>()
                          //     .selectCategory(category);
                        },
                        child: Row(
                          children: [
                            SearchCategoriesItemTile(
                                name: category.name,
                                iconPath: category.iconPath),
                            const SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 6.0,
            ),
            Container(
              height: 1.0,
              decoration: BoxDecoration(color: AppColors.borderColor),
            )
          ],
        ),
      ),
    );
  }
}
