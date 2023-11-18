import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RandomDogDialogContent extends StatelessWidget {
  final String imageURL;
  const RandomDogDialogContent({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12).r,
            child: Image.network(
              imageURL,
              height: 256.w,
              width: 256.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: Navigator.of(context).pop,
            child: Container(
              height: 32.w,
              width: 32.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2).r,
              ),
              child: const Icon(Icons.close_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
