// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categoriesicon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CategoriesIcon _$CategoriesIconFromJson(Map<String, dynamic> json) {
  return _CategoriesIcon.fromJson(json);
}

/// @nodoc
mixin _$CategoriesIcon {
  int get backgroundColor => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;

  /// Serializes this CategoriesIcon to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoriesIcon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoriesIconCopyWith<CategoriesIcon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesIconCopyWith<$Res> {
  factory $CategoriesIconCopyWith(
          CategoriesIcon value, $Res Function(CategoriesIcon) then) =
      _$CategoriesIconCopyWithImpl<$Res, CategoriesIcon>;
  @useResult
  $Res call({int backgroundColor, String iconPath});
}

/// @nodoc
class _$CategoriesIconCopyWithImpl<$Res, $Val extends CategoriesIcon>
    implements $CategoriesIconCopyWith<$Res> {
  _$CategoriesIconCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoriesIcon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? iconPath = null,
  }) {
    return _then(_value.copyWith(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as int,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoriesIconImplCopyWith<$Res>
    implements $CategoriesIconCopyWith<$Res> {
  factory _$$CategoriesIconImplCopyWith(_$CategoriesIconImpl value,
          $Res Function(_$CategoriesIconImpl) then) =
      __$$CategoriesIconImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int backgroundColor, String iconPath});
}

/// @nodoc
class __$$CategoriesIconImplCopyWithImpl<$Res>
    extends _$CategoriesIconCopyWithImpl<$Res, _$CategoriesIconImpl>
    implements _$$CategoriesIconImplCopyWith<$Res> {
  __$$CategoriesIconImplCopyWithImpl(
      _$CategoriesIconImpl _value, $Res Function(_$CategoriesIconImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoriesIcon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? iconPath = null,
  }) {
    return _then(_$CategoriesIconImpl(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as int,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoriesIconImpl implements _CategoriesIcon {
  const _$CategoriesIconImpl(
      {required this.backgroundColor, required this.iconPath});

  factory _$CategoriesIconImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoriesIconImplFromJson(json);

  @override
  final int backgroundColor;
  @override
  final String iconPath;

  @override
  String toString() {
    return 'CategoriesIcon(backgroundColor: $backgroundColor, iconPath: $iconPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesIconImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, backgroundColor, iconPath);

  /// Create a copy of CategoriesIcon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesIconImplCopyWith<_$CategoriesIconImpl> get copyWith =>
      __$$CategoriesIconImplCopyWithImpl<_$CategoriesIconImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoriesIconImplToJson(
      this,
    );
  }
}

abstract class _CategoriesIcon implements CategoriesIcon {
  const factory _CategoriesIcon(
      {required final int backgroundColor,
      required final String iconPath}) = _$CategoriesIconImpl;

  factory _CategoriesIcon.fromJson(Map<String, dynamic> json) =
      _$CategoriesIconImpl.fromJson;

  @override
  int get backgroundColor;
  @override
  String get iconPath;

  /// Create a copy of CategoriesIcon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoriesIconImplCopyWith<_$CategoriesIconImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
