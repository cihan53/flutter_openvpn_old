import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

/// Assumes the given path is a text-file-asset.
Future<String> getFileData(String path) async {
  try {
    return await rootBundle.loadString(path);
  } catch (_) {
    return null;
  }
}
