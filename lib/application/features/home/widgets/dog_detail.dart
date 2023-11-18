import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phodog/application/common/app_strings.dart';
import 'package:phodog/application/config/theme/app_text_styles.dart';
import 'package:phodog/core/extensions/context_extensions.dart';
import 'package:phodog/core/extensions/string_extensions.dart';

import '../../../services/dogs/models/dog_model.dart';

class DogDetail extends StatelessWidget {
  final Dog dog;
  final Future<void> Function() onTapGenerate;
  const DogDetail({super.key, required this.dog, required this.onTapGenerate});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.white,
      shadowColor: context.colors.white,
      surfaceTintColor: context.colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16).w,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12).r,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12).r,
              topRight: const Radius.circular(12).r,
            ),
            child: SizedBox(
              width: 343.w,
              height: 343.w,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image(
                      image: dog.imageProvider!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Placeholder();
                      },
                    ),
                  ),
                  Positioned(
                    top: 12.w,
                    right: 12.w,
                    height: 32.w,
                    width: 32.w,
                    child: GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: CircleAvatar(
                        backgroundColor: context.colors.white,
                        child: Icon(
                          Icons.close_rounded,
                          color: context.colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32).w,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 12).h,
                  child: Text(
                    AppStrings.breed,
                    style: context.appTextTheme.defaultTitle3.copyWith(
                      color: context.colors.detailTitle,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.w,
                  height: 1.w,
                  color: context.colors.secondary,
                ),
                Text(
                  dog.name.capitalizeFirstLetter(),
                  style: context.appTextTheme.defaultBody,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 12).h,
                  child: Text(
                    AppStrings.subBreed,
                    style: context.appTextTheme.defaultTitle3.copyWith(
                      color: context.colors.detailSubTitle,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.w,
                  height: 1.w,
                  color: context.colors.secondary,
                ),
                if (dog.subBreeds.isEmpty)
                  Text(
                    '-',
                    style: context.appTextTheme.defaultBody,
                  ),
                ...List.generate(
                  dog.subBreeds.length,
                  (index) => Text(
                    dog.subBreeds.elementAt(index),
                    style: context.appTextTheme.defaultBody,
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: onTapGenerate,
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.maxFinite, 56.h)),
                    elevation: MaterialStateProperty.all(0),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    backgroundColor:
                        MaterialStateProperty.all(context.colors.primary),
                    surfaceTintColor:
                        MaterialStateProperty.all(context.colors.primary),
                    foregroundColor:
                        MaterialStateProperty.all(context.colors.white),
                    textStyle: MaterialStateProperty.all(
                        context.appTextTheme.thinHeadline),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8).r,
                      ),
                    ),
                  ),
                  child: const Text(AppStrings.generate),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
