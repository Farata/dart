import 'package:logging/logging.dart';

main() {
  Logger.root.onRecord.listen((record) {
    print('[${record.level}] ${record.loggerName}: ${record.message}');
  });

  final logger = new Logger('MainLogger');
  logger.info('Printed from package');
}
