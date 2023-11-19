
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/app_text_styles.dart';
import '../../../core/extensions/context_extensions.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  final Future<void> Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(double.maxFinite, 56.h)),
        elevation: MaterialStateProperty.all(0),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.all(context.colors.primary),
        surfaceTintColor: MaterialStateProperty.all(context.colors.primary),
        foregroundColor: MaterialStateProperty.all(context.colors.white),
        textStyle: MaterialStateProperty.all(context.appTextTheme.thinHeadline),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8).r,
          ),
        ),
      ),
      child: child,
    );
  }
}