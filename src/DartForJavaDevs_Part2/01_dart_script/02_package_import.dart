// To execute explicitly provide packages root directory.
// Example: dart --package-root=/Users/amoiseev/Projects/dart_repo/dart/xcodebuild/ReleaseIA32/packages 02_package_import.dart

import 'dart:mirrors';
import 'package:logging/logging.dart';

main() {
  Logger.root.onRecord.listen((record) {
    print('[${record.level}] ${record.loggerName}: ${record.message}');
  });

  final logger = new Logger('MainLogger');
  logger.info('Test message');
}
