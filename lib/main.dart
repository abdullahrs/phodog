import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'application/config/theme/app_theme.dart';
import 'application/config/router/routes.dart';
import 'core/utils/platform_info_helper.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await PlatformInfoHelper.instance.getDeviceVersion();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Phodog',
          debugShowCheckedModeBanner: false,
          theme: appLightTheme,
          routerDelegate: CustomAppRouter.routerDelegate,
          routeInformationParser: CustomAppRouter.routeInformationParser,
        );
      },
    );
  }
}
