import 'package:flutter/material.dart';
import 'app_colors.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Color? primary;
  final Color? secondary;
  final Color? shadowGray;
  final Color? black;
  final Color? white;
  final Color? lilacMurmur;
  final Color? lightPensive;
  final Color? searchUnfocused;
  final Color? notFoundDesc;
  final Color? searchFocused;
  final Color? searchDetailDesc;
  final Color? settingsTitle;
  final Color? gridItemTitle;
  final Color? homeSelectedItem;
  final Color? homeUnselectedItem;
  final Color? detailTitle;
  final Color? detailSubTitle;
  final Color? detailConfirm;
  final Color? notFoundTitle;
  final Color? osVersionValue;
  final Color? bottomNavigationBorder;
  final Color? bottomNavigationDivider;

  const AppColorScheme({
    this.primary,
    this.secondary,
    this.shadowGray,
    this.black,
    this.white,
    this.lilacMurmur,
    this.lightPensive,
    this.searchUnfocused,
    this.notFoundDesc,
    this.searchFocused,
    this.searchDetailDesc,
    this.settingsTitle,
    this.gridItemTitle,
    this.homeSelectedItem,
    this.homeUnselectedItem,
    this.detailTitle,
    this.detailSubTitle,
    this.detailConfirm,
    this.notFoundTitle,
    this.osVersionValue,
    this.bottomNavigationBorder,
    this.bottomNavigationDivider,
  });
  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? primary,
    Color? secondary,
    Color? shadowGray,
    Color? black,
    Color? white,
    Color? lilacMurmur,
    Color? lightPensive,
    Color? searchUnfocused,
    Color? notFoundDesc,
    Color? searchFocused,
    Color? searchDetailDesc,
    Color? settingsTitle,
    Color? gridItemTitle,
    Color? homeSelectedItem,
    Color? homeUnselectedItem,
    Color? detailTitle,
    Color? detailSubTitle,
    Color? detailConfirm,
    Color? notFoundTitle,
    Color? osVersionValue,
    Color? bottomNavigationBorder,
    Color? bottomNavigationDivider,
  }) {
    return AppColorScheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      shadowGray: shadowGray ?? this.shadowGray,
      black: black ?? this.black,
      white: white ?? this.white,
      lilacMurmur: lilacMurmur ?? this.lilacMurmur,
      lightPensive: lightPensive ?? this.lightPensive,
      searchUnfocused: searchUnfocused ?? this.searchUnfocused,
      notFoundDesc: notFoundDesc ?? this.notFoundDesc,
      searchFocused: searchFocused ?? this.searchFocused,
      searchDetailDesc: searchDetailDesc ?? this.searchDetailDesc,
      settingsTitle: settingsTitle ?? this.settingsTitle,
      gridItemTitle: gridItemTitle ?? this.gridItemTitle,
      homeSelectedItem: homeSelectedItem ?? this.homeSelectedItem,
      homeUnselectedItem: homeUnselectedItem ?? this.homeUnselectedItem,
      detailTitle: detailTitle ?? this.detailTitle,
      detailSubTitle: detailSubTitle ?? this.detailSubTitle,
      detailConfirm: detailConfirm ?? this.detailConfirm,
      notFoundTitle: notFoundTitle ?? this.notFoundTitle,
      osVersionValue: osVersionValue ?? this.osVersionValue,
      bottomNavigationBorder:
          bottomNavigationBorder ?? this.bottomNavigationBorder,
      bottomNavigationDivider:
          bottomNavigationDivider ?? this.bottomNavigationDivider,
    );
  }

  @override
  ThemeExtension<AppColorScheme> lerp(
      covariant ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) {
      return this;
    }
    return AppColorScheme(
      primary: Color.lerp(primary, other.primary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      shadowGray: Color.lerp(shadowGray, other.shadowGray, t),
      black: Color.lerp(black, other.black, t),
      white: Color.lerp(white, other.white, t),
      lilacMurmur: Color.lerp(lilacMurmur, other.lilacMurmur, t),
      lightPensive: Color.lerp(lightPensive, other.lightPensive, t),
      searchUnfocused: Color.lerp(searchUnfocused, other.searchUnfocused, t),
      notFoundDesc: Color.lerp(notFoundDesc, other.notFoundDesc, t),
      searchFocused: Color.lerp(searchFocused, other.searchFocused, t),
      searchDetailDesc: Color.lerp(searchDetailDesc, other.searchDetailDesc, t),
      settingsTitle: Color.lerp(settingsTitle, other.settingsTitle, t),
      gridItemTitle: Color.lerp(gridItemTitle, other.gridItemTitle, t),
      homeSelectedItem: Color.lerp(homeSelectedItem, other.homeSelectedItem, t),
      homeUnselectedItem:
          Color.lerp(homeUnselectedItem, other.homeUnselectedItem, t),
      detailTitle: Color.lerp(detailTitle, other.detailTitle, t),
      detailSubTitle: Color.lerp(detailSubTitle, other.detailSubTitle, t),
      detailConfirm: Color.lerp(detailConfirm, other.detailConfirm, t),
      notFoundTitle: Color.lerp(notFoundTitle, other.notFoundTitle, t),
      osVersionValue: Color.lerp(osVersionValue, other.osVersionValue, t),
      bottomNavigationBorder:
          Color.lerp(bottomNavigationBorder, other.bottomNavigationBorder, t),
      bottomNavigationDivider:
          Color.lerp(bottomNavigationDivider, other.bottomNavigationDivider, t),
    );
  }

  static const light = AppColorScheme(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    shadowGray: AppColors.shadowGray,
    black: AppColors.black,
    white: AppColors.white,
    lilacMurmur: AppColors.lilacMurmur,
    lightPensive: AppColors.lightPensive,
    searchUnfocused: AppColors.shadowGray,
    notFoundDesc: AppColors.shadowGray,
    searchFocused: AppColors.black,
    searchDetailDesc: AppColors.black,
    settingsTitle: AppColors.black,
    gridItemTitle: AppColors.white,
    homeSelectedItem: AppColors.primary,
    homeUnselectedItem: AppColors.black,
    detailTitle: AppColors.primary,
    detailSubTitle: AppColors.primary,
    detailConfirm: AppColors.white,
    notFoundTitle: AppColors.black,
    osVersionValue: AppColors.shadowGray,
    bottomNavigationBorder: AppColors.lilacMurmur,
    bottomNavigationDivider: AppColors.lightPensive,
  );

  static const dark = AppColorScheme();
}
