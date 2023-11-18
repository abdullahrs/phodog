import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/platform_info_helper.dart';
import '../../../common/app_strings.dart';
import '../../../common/asset_paths.dart';
import '../../../config/theme/app_text_styles.dart';

enum SettingItem {
  help(
    leadingIcon: AssetPaths.help,
    label: AppStrings.help,
  ),
  rateUs(
    leadingIcon: AssetPaths.rateUs,
    label: AppStrings.rateUs,
  ),
  shareWith(
    leadingIcon: AssetPaths.shareWith,
    label: AppStrings.shareWithFriends,
  ),
  toe(
    leadingIcon: AssetPaths.termOfUse,
    label: AppStrings.termsOfUse,
  ),
  privacy(
    leadingIcon: AssetPaths.privacy,
    label: AppStrings.privacyPolicy,
  ),
  osVersion(
    leadingIcon: AssetPaths.osVersion,
    label: AppStrings.osVersion,
  ),
  ;

  final String leadingIcon;
  final String label;

  const SettingItem({required this.leadingIcon, required this.label});
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      child: ListView.separated(
        itemCount: SettingItem.values.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final item = SettingItem.values.elementAt(index);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12).h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(item.leadingIcon),
                    SizedBox(width: 8.w),
                    Text(item.label, style: context.appTextTheme.defaultBody),
                  ],
                ),
                item == SettingItem.osVersion
                    ? Text(
                        PlatformInfoHelper.instance.deviceVersion ?? '-',
                        style: context.appTextTheme.thinFootnote,
                      )
                    : SvgPicture.asset(AssetPaths.arrowUp),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
              height: 2.h, thickness: 2.h, color: context.colors.lilacMurmur);
        },
      ),
    );
  }
}
