import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_cubit.dart';
import 'package:kitty/pages/add_new_categories_page/cubit/add_new_category_state.dart';

import 'package:kitty/styles/colors.dart';
import 'package:kitty/widgets/blue_bottom_button.dart';
import 'package:kitty/widgets/custom_text_field.dart';

class AddNewCategories extends StatefulWidget {
  const AddNewCategories({super.key});

  @override
  State<AddNewCategories> createState() => _AddNewCategoriesState();
}

class _AddNewCategoriesState extends State<AddNewCategories> {
  bool isPressed = false;
  String iconPath = '';
  int backgroundColor = 0;
  TextEditingController categoryController = TextEditingController();

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
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/icons/arrow_back_black_24dp.svg',
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "blue_gesture_button".tr(),
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
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
                            width: 48.0,
                            height: 48.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.circleGreyColor,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    isPressed = !isPressed;
                                  },
                                );
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
                                              color: AppColors.header,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 32.0,
                                              ),
                                              child: BlocBuilder<
                                                  AddNewCategoryCubit,
                                                  AddNewCategoryState>(
                                                builder: (context, state) {
                                                  if (state is CategoryLoaded) {
                                                    final icons =
                                                        state.categoryIcons;
                                                    return GridView.builder(
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4,
                                                        crossAxisSpacing: 45.0,
                                                        mainAxisSpacing: 24.0,
                                                      ),
                                                      itemCount: icons.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(
                                                              () {
                                                                isPressed =
                                                                    !isPressed;
                                                                backgroundColor =
                                                                    icons[index]
                                                                        .backgroundColor;

                                                                iconPath = icons[
                                                                        index]
                                                                    .iconPath;
                                                              },
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            width: 40.0,
                                                            height: 40.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                icons[index]
                                                                    .backgroundColor,
                                                              ),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                                icons[index]
                                                                    .iconPath,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else if (state
                                                      is CategoryLoading) {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  } else if (state
                                                      is CategoryError) {
                                                    return Center(
                                                      child: Text(
                                                        'Error: ${state.message}',
                                                      ),
                                                    );
                                                  }
                                                  return const SizedBox(); // Пустий стан
                                                },
                                              ),
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
                                    : Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(
                                            backgroundColor,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              iconPath,
                                              height: 24.0,
                                              width: 24.0,
                                            )
                                          ],
                                        ),
                                      ),
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

                categoryCubit.addCategory(
                    categoryController.text, iconPath, backgroundColor);
                context.go('/home');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        6.0,
                      ),
                    ),
                    dismissDirection: DismissDirection.up,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: MediaQuery.of(context).size.height - 200,
                    ),
                    duration: const Duration(
                      seconds: 3,
                    ),
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
                          child: SvgPicture.asset(
                            'assets/icons/close.svg',
                          ),
                        )
                      ],
                    ),
                  ),
                );
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
