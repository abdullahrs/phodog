import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phodog/application/config/theme/app_text_styles.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/utils/curved_bnb_painter.dart';

class CustomBottomNavigationBarItem {
  final String iconPath;
  final String label;
  final VoidCallback? onTapItem;

  const CustomBottomNavigationBarItem({
    required this.iconPath,
    required this.label,
    this.onTapItem,
  });
}

class CustomBottomNavigationBar extends StatefulWidget {
  final List<CustomBottomNavigationBarItem> items;
  const CustomBottomNavigationBar({super.key, required this.items});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(1.w, 98.h),
      painter: CurvedBNBShapePainter(
        fillColor: context.colors.secondary!,
        borderColor: context.colors.bottomNavigationBorder!,
        borderThickness: 2.w,
      ),
      child: SizedBox(
        height: 98.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            // n-1 separators are required for n items
            // n + n - 1 = 2n-1
            2 * widget.items.length - 1,
            (index) {
              if (index % 2 == 0) {
                final item = widget.items[index ~/ 2];
                return SizedBox(
                  width: 1.sw / (2 * widget.items.length - 1),
                  child: bnbItem(
                    iconAssetPath: item.iconPath,
                    title: item.label,
                    onTap: item.onTapItem ?? () {},
                    selected: index == 0,
                  ),
                );
              }
              return bnbDivider;
            },
          ),
        ),
      ),
    );
  }

  SizedBox get bnbDivider => SizedBox(
        height: 24.h,
        child: VerticalDivider(
          width: 2.w,
          color: context.colors.lightPensive,
        ),
      );

  GestureDetector bnbItem({
    required String iconAssetPath,
    required String title,
    required VoidCallback onTap,
    bool selected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconAssetPath),
          Text(
            title,
            style: context.appTextTheme.defaultCaption2.copyWith(
              color: selected ? context.colors.primary : context.colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
