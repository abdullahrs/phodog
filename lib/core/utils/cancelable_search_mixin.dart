import 'dart:async';

import 'package:async/async.dart';

mixin CancelableSearchOperationMixin {
  Duration delayTime = const Duration(milliseconds: 300);
  CancelableOperation<void>? _cancelableOperation;

  void startOperation(
    String query,
    FutureOr Function(String query) completeCallback, {
    FutureOr<dynamic> Function()? onCancel,
  }) {
    // If there is an ongoing operation, it will cancel it
    // else nothing happens
    _cancelableOperation?.cancel();
    // Creates a new operation if there is no operation initially setted,
    // or if the operation in progress has been canceled
    _cancelableOperation = CancelableOperation.fromFuture(
      Future.delayed(delayTime),
      onCancel: onCancel,
    );
    // If the operation is not canceled within the delayTime,
    // compleCallback function is called
    _cancelableOperation?.value.whenComplete(() async {
      await completeCallback(query);
    });
  }

  void cancelOperation() {
    _cancelableOperation?.cancel();
  }
}
