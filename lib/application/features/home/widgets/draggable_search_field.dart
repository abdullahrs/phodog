import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phodog/application/config/theme/app_text_styles.dart';
import 'package:phodog/core/extensions/context_extensions.dart';

import '../../../common/app_strings.dart';

class DraggableSearchField extends StatefulWidget {
  const DraggableSearchField({
    super.key,
    this.draggableScrollableController,
    this.textEditingController,
    this.focusNode,
    this.onKeyboardStateChange,
  });

  final DraggableScrollableController? draggableScrollableController;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final Function? onKeyboardStateChange;

  @override
  State<DraggableSearchField> createState() => _DraggableSearchFieldState();
}

class _DraggableSearchFieldState extends State<DraggableSearchField>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (MediaQuery.of(context).viewInsets.bottom == 0) {
        widget.onKeyboardStateChange?.call();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: widget.draggableScrollableController,
      initialChildSize: 0,
      minChildSize: 0,
      // (total height - appbar height)/total height
      maxChildSize: (1.sh - 50.h) / 1.sh,
      builder: (context, scrollController) {
        return Material(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16).w,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 12).h,
                    child: SizedBox(
                      height: 3.h,
                      width: 32.w,
                      child: Divider(
                        thickness: 3.h,
                        color: context.colors.secondary,
                      ),
                    ),
                  ),
                  TextField(
                    controller: widget.textEditingController,
                    focusNode: widget.focusNode,
                    maxLines: null,
                    style: context.appTextTheme.defaultBody.copyWith(
                      color: context.colors.searchFocused,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStrings.search,
                      hintStyle: context.appTextTheme.defaultBody.copyWith(
                        color: context.colors.searchUnfocused,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
