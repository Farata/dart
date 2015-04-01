import "dart:async";
import "dart:collection";

main() {
  Logger.root.onRecord.listen((record) {
    print('[${record.level}] ${record.loggerName}: ${record.message}');
  });
  final logger = new Logger('MainLogger');
  logger.info('Test message');
}
bool hierarchicalLoggingEnabled = false;
Level _rootLevel = Level.INFO;
class Logger {
  final String name;
  String get fullName => (parent == null || parent.name == '') ? name : '${parent.fullName}.${name}';
  final Logger parent;
  Level _level;
  final Map<String, Logger> _children;
  final Map<String, Logger> children;
  StreamController<LogRecord> _controller_A;
  factory Logger(String name_A) {
    return _loggers.putIfAbsent(name_A, () => new Logger._named(name_A));
  }
  factory Logger._named(String name_A) {
    if (name_A.startsWith('.')) {
      throw new ArgumentError("name shouldn't start with a '.'");
    }
    int dot = name_A.lastIndexOf('.');
    Logger parent_A = null;
    String thisName;
    if (dot == -1) {
      if (name_A != '') parent_A = new Logger('');
      thisName = name_A;
    } else {
      parent_A = new Logger(name_A.substring(0, dot));
      thisName = name_A.substring(dot + 1);
    }
    return new Logger._internal_A(thisName, parent_A, new Map<String, Logger>());
  }
  Logger._internal_A(this.name, this.parent, Map<String, Logger> children_A) : this._children = children_A, this.children = new UnmodifiableMapView(children_A) {
    if (parent != null) parent._children[name] = this;
  }
  Level get level {
    if (hierarchicalLoggingEnabled) {
      if (_level != null) return _level;
      if (parent != null) return parent.level;
    }
    return _rootLevel;
  }
  Stream<LogRecord> get onRecord => _getStream();
  bool isLoggable(Level value_A) => (value_A >= level);
  void log_A(Level logLevel, message_A, [Object error_A, StackTrace stackTrace_A]) {
    if (isLoggable(logLevel)) {
      if (message_A is Function) message_A = message_A();
      if (message_A is! String) message_A = message_A.toString();
      var record = new LogRecord(logLevel, message_A, fullName, error_A, stackTrace_A);
      if (hierarchicalLoggingEnabled) {
        var target = this;
        while (target != null) {
          target._publish(record);
          target = target.parent;
        }
      } else {
        root._publish(record);
      }
    }
  }
  void info(message_A, [Object error_A, StackTrace stackTrace_A]) => log_A(Level.INFO, message_A, error_A, stackTrace_A);
  Stream<LogRecord> _getStream() {
    if (hierarchicalLoggingEnabled || parent == null) {
      if (_controller_A == null) {
        _controller_A = new StreamController<LogRecord>.broadcast(sync: true);
      }
      return _controller_A.stream;
    } else {
      return root._getStream();
    }
  }
  void _publish(LogRecord record) {
    if (_controller_A != null) {
      _controller_A.add(record);
    }
  }
  static Logger get root => new Logger('');
  static final Map<String, Logger> _loggers = <String, Logger>{};
}
class Level implements Comparable<Level> {
  final String name;
  final int value;
  const Level(this.name, this.value);
  static const Level INFO = const Level('INFO', 800);
  bool operator==(Object other) => other is Level && value == other.value;
  bool operator<(Level other) => value < other.value;
  bool operator>(Level other) => value > other.value;
  bool operator>=(Level other) => value >= other.value;
  int compareTo(Level other) => value - other.value;
  int get hashCode => value;
  String toString() => name;
}
class LogRecord {
  final Level level;
  final String message;
  final String loggerName;
  final DateTime time;
  final int sequenceNumber;
  static int _nextNumber = 0;
  final Object error;
  final StackTrace stackTrace;
  LogRecord(this.level, this.message, this.loggerName, [this.error, this.stackTrace]) : time = new DateTime.now(), sequenceNumber = LogRecord._nextNumber++;
  String toString() => '[${level.name}] ${loggerName}: ${message}';
}
