import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/extensions/context_extensions.dart';

Future<void> showBottomSheetScreen(BuildContext context, Widget child,
        {bool cornerRadius = true, bool isScrollControlled = true}) async =>
    await showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.secondary,
      barrierColor: context.colors.secondary,
      elevation: 0,
      useSafeArea: true, // To avoid sheet to going below the status bar
      enableDrag: true, // Allows dismissing the sheet by dragging it down
      isScrollControlled:
          isScrollControlled, // when its true,this property used for to take full screen height
      shape: RoundedRectangleBorder(
        side: cornerRadius
            ? BorderSide(width: 1.w, color: context.colors.lilacMurmur!)
            : BorderSide.none,
        borderRadius: cornerRadius
            ? BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              )
            : BorderRadius.zero,
      ),
      builder: (context) {
        return Column(
          children: [
            Container(
              width: 32.w,
              padding: const EdgeInsets.symmetric(vertical: 8).h,
              child: Divider(
                height: 4.h,
                thickness: 4.h,
                color: context.colors.lilacMurmur,
              ),
            ),
            Expanded(child: child),
          ],
        );
      },
    );
