import 'package:flutter/material.dart';

class CustomSearchBar extends SearchBar {
  CustomSearchBar({
    super.key,
    Color? fillColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    String? hintText,
    TextStyle? hintStyle,
    VoidCallback? onTap,

    /// It only works with given hintStyle
    Color? focusedTextColor,

    /// It only works with given hintStyle
    Color? unfocusedTextColor,
  }) : super(
          onTap: onTap,
          hintText: hintText,
          hintStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.focused)) {
              return hintStyle?.copyWith(color: focusedTextColor);
            }
            return hintStyle?.copyWith(color: unfocusedTextColor);
          }),
          elevation: MaterialStateProperty.all(0),
          surfaceTintColor: MaterialStateProperty.all(fillColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                  color: borderColor ?? Colors.grey, width: borderWidth ?? 2),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
        );
}
