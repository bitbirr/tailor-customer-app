/// Logger that must never emit PII, measurements, photos, tokens, or exports.
class RedactingLogger {
  const RedactingLogger();

  static const _blocked = [
    'phone',
    'email',
    'address',
    'name',
    'measurement',
    'photo',
    'token',
    'secret',
    'password',
    'authorization',
  ];

  void info(String message) => _write('INFO', message);

  void warn(String message) => _write('WARN', message);

  void error(String message) => _write('ERROR', message);

  void _write(String level, String message) {
    final lower = message.toLowerCase();
    for (final word in _blocked) {
      if (lower.contains(word)) {
        // Deliberately drop the message rather than risk leaking workshop data.
        return;
      }
    }
    // ignore: avoid_print
    print('[$level] $message');
  }
}
