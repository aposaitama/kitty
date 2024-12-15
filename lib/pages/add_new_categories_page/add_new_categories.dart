import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_cubit.dart';
import 'package:kitty/route/app_navigation.dart';
import 'package:kitty/styles/colors.dart';
import 'package:kitty/widgets/blue_bottom_button.dart';
import 'package:kitty/widgets/custom_text_field.dart';

import 'cubit/add_new_category_state.dart';

class AddNewCategories extends StatefulWidget {
  const AddNewCategories({super.key});

  @override
  State<AddNewCategories> createState() => _AddNewCategoriesState();
}

class _AddNewCategoriesState extends State<AddNewCategories> {
  final List<String> categoryIcons = [
    'assets/icons/category_icons/Cafe.svg',
    'assets/icons/category_icons/Donate.svg',
    'assets/icons/category_icons/Education.svg',
    'assets/icons/category_icons/Electronics.svg',
    'assets/icons/category_icons/Fuel.svg',
    'assets/icons/category_icons/Gifts.svg',
    'assets/icons/category_icons/Groceries.svg',
    'assets/icons/category_icons/Health.svg',
    'assets/icons/category_icons/Institute.svg',
    'assets/icons/category_icons/Laundry.svg',
    'assets/icons/category_icons/Liquor.svg',
    'assets/icons/category_icons/Maintenance.svg',
    'assets/icons/category_icons/Money.svg',
    'assets/icons/category_icons/Party.svg',
    'assets/icons/category_icons/Restaurant.svg',
    'assets/icons/category_icons/Savings.svg',
    'assets/icons/category_icons/Self development.svg',
    'assets/icons/category_icons/Sport.svg',
    'assets/icons/category_icons/Transportation.svg',
  ];

  bool isPressed = false;
  String iconPath = '';
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AddNewCategoryCubit>().loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
                            onTap: () => Navigator.pop(context),
                            child: SvgPicture.asset(
                                'assets/icons/arrow_back_black_24dp.svg')),
                        const SizedBox(
                          width: 16.0,
                        ),
                        const Text(
                          'Add new category',
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
                      height: 28.0,
                    ),
                    Row(
                      children: [
                        DottedBorder(
                          dashPattern: const [4, 4, 4, 4],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(30),
                          color: isPressed
                              ? AppColors.blueStackButton
                              : AppColors.hintText,
                          strokeWidth: isPressed ? 2 : 1,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.circleGreyColor,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPressed = !isPressed;
                                });
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 390,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Container(
                                            width: 20.0,
                                            height: 2.0,
                                            color: AppColors.hintText,
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            'Choose Category icon'
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.header),
                                          ),
                                          Expanded(
                                            child: GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                crossAxisSpacing: 0.0,
                                                mainAxisSpacing: 0.0,
                                              ),
                                              itemCount: categoryIcons.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isPressed = !isPressed;
                                                      iconPath =
                                                          categoryIcons[index];
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppColors
                                                          .circleGreyColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        categoryIcons[index],
                                                        width: 40,
                                                        height: 40,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Center(
                                child: iconPath == ''
                                    ? SvgPicture.asset(
                                        'assets/icons/add_icon.svg',
                                        width: 24,
                                        height: 24,
                                      )
                                    : SvgPicture.asset(iconPath),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: categoryController,
                            labelText: 'Category name',
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: GestureDetector(
              onTap: () {
                final categoryCubit = context.read<AddNewCategoryCubit>();
                categoryCubit.addCategory(Categories(
                    name: categoryController.text, iconPath: iconPath));
                context.go('/home');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    padding: EdgeInsets.only(
                        left: 16.0, top: 10.0, bottom: 10.0, right: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    dismissDirection: DismissDirection.up,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        bottom: MediaQuery.of(context).size.height - 200),
                    duration: const Duration(seconds: 3),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'New category addedd successfully!',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 0.1,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              if (mounted) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              }
                            },
                            child: SvgPicture.asset('assets/icons/close.svg'))
                      ],
                    )));
              },
              child: const BlueBottomButton(
                buttonTitle: 'Add new category',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
