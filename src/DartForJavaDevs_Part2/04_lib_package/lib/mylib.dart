library mylib;

import 'package:logging/logging.dart';

myPrint(dynamic any) {
  Logger.root.onRecord.listen((record) {
    print('[${record.level}] ${record.loggerName}: ${record.message}');
  });

  final logger = new Logger('MainLogger');
  logger.info(any);
}
