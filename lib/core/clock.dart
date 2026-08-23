/// UTC epoch milliseconds. Injectable for tests.
abstract class Clock {
  const Clock();

  int nowMs();
}

class SystemClock extends Clock {
  const SystemClock();

  @override
  int nowMs() => DateTime.now().toUtc().millisecondsSinceEpoch;
}

class FixedClock extends Clock {
  const FixedClock(this._nowMs);

  final int _nowMs;

  @override
  int nowMs() => _nowMs;
}
