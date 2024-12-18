import 'package:freezed_annotation/freezed_annotation.dart';

part 'categoriesicon.freezed.dart';
part 'categoriesicon.g.dart';

@freezed
class CategoriesIcon with _$CategoriesIcon {
  const factory CategoriesIcon({
    required int backgroundColor,
    required String iconPath,
  }) = _CategoriesIcon;

  factory CategoriesIcon.fromJson(Map<String, dynamic> json) =>
      _$CategoriesIconFromJson(json);
}
