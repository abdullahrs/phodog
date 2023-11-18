import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../common/app_strings.dart';
import '../../../common/asset_paths.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../widgets/curved_bnb.dart';
import '../../../widgets/custom_search_bar.dart';
import '../controller/home_actions.dart';
import '../controller/home_controller_bloc.dart';
import '../controller/home_results.dart';
import '../widgets/image_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<HomeControllerBloc>()
        .add(GetDogsList(context, page: 1, limit: 10, query: ''));
  }

  @override
  void didChangeDependencies() {
    if (context.read<HomeControllerBloc>().dogs.isNotEmpty) {
      // to avoid white flash beheviours,
      // recache the images when dependcies changed
      for (var element in context.read<HomeControllerBloc>().dogs) {
        precacheImage(element.imageProvider!, context);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                top: 50.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16).w,
                  child: BlocBuilder<HomeControllerBloc, HomeActionResult>(
                    builder: (context, state) {
                      if (state is HomeActionFailure) {
                        return errorWidget(state.errorMessage);
                      }
                      if (state is GetDogsEmptyResult) {
                        return notFoundWidget();
                      }
                      if (state is GetDogsResult) {
                        return resultView(state);
                      }
                      return ListView();
                    },
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 50.h,
                child: Center(
                  child: Text(
                    AppStrings.appName,
                    style: context.appTextTheme.defaultTitle3,
                  ),
                ),
              ),
              Positioned(
                bottom: 114.h,
                left: 16.w,
                right: 16.w,
                height: 64.h,
                child: CustomSearchBar(
                  fillColor: context.colors.white,
                  borderColor: context.colors.lilacMurmur,
                  borderWidth: 2.w,
                  borderRadius: 8.r,
                  hintText: AppStrings.search,
                  hintStyle: context.appTextTheme.defaultBody,
                  focusedTextColor: context.colors.searchFocused,
                  unfocusedTextColor: context.colors.searchUnfocused,
                  onTap: context.read<HomeControllerBloc>().onTapSearchBar,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 98.h,
                child: CustomBottomNavigationBar(
                  items: [
                    const CustomBottomNavigationBarItem(
                      label: AppStrings.home,
                      iconPath: AssetPaths.home,
                    ),
                    CustomBottomNavigationBarItem(
                      label: AppStrings.settings,
                      iconPath: AssetPaths.settings,
                      onTapItem:
                          context.read<HomeControllerBloc>().onTapSettings,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView resultView(GetDogsResult state) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      children: List.generate(
        state.dogs.length + 2,
        (index) {
          // To avoid last images overflowed by bottom navigation bar
          if (state.dogs.length <= index) {
            return SizedBox(
              width: 163.5.w,
              height: 163.5.w,
            );
          }
          final dog = state.dogs[index];
          return Container(
            width: 163.5.w,
            height: 163.5.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                width: 1.w,
                color: context.colors.secondary!,
              ),
            ),
            child: ImageCard(
              label: dog.name,
              imageProvider: dog.imageProvider,
              onTapCard: () => context.read<HomeControllerBloc>().onTapDog(dog),
            ),
          );
        },
      ),
    );
  }

  Column errorWidget(String? errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.close,
          color: Colors.red,
          size: 64,
        ),
        Text(
          AppStrings.errorPrefix,
          style: context.appTextTheme.defaultHeadline.copyWith(
            color: context.colors.notFoundTitle,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          errorMessage ?? '-',
          style: context.appTextTheme.defaultHeadline.copyWith(
            color: context.colors.notFoundDesc,
          ),
        ),
      ],
    );
  }

  Column notFoundWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.emptyResult,
          style: context.appTextTheme.defaultHeadline.copyWith(
            color: context.colors.notFoundTitle,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          AppStrings.searchAnotherWord,
          style: context.appTextTheme.defaultHeadline.copyWith(
            color: context.colors.notFoundDesc,
          ),
        ),
      ],
    );
  }
}
