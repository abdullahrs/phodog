import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

void logMessage(String msg, {bool show = false}) {
  if (kDebugMode || show) {
    dev.log(msg);
  }
}
