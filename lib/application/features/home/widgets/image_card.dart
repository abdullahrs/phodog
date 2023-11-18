import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../config/theme/app_text_styles.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.label,
    required this.onTapCard,
    this.imageProvider,
  });

  final ImageProvider? imageProvider;
  final String label;
  final VoidCallback onTapCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCard,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Stack(
          children: [
            if (imageProvider != null)
              Positioned.fill(
                child: Image(
                  image: imageProvider!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Placeholder();
                  },
                ),
              ),
            Positioned(
              left: 0,
              bottom: 0,
              height: 38.h,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(16).r,
                ),
                child: Container(
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.all(8).h,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.24),
                  ),
                  child: Text(
                    label.capitalizeFirstLetter(),
                    style: context.appTextTheme.defaultBody.copyWith(
                      color: context.colors.gridItemTitle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
