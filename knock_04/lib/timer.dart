import 'dart:async';

class CountdownTimer {
  late DateTime _timerValue;
  late Timer? _timer;

  CountdownTimer({int hours = 0, int minutes = 0, int seconds = 0}) {
    _timerValue = DateTime(0, 0, 0, hours, minutes, seconds);
    _timer = Timer(Duration.zero, () {});
  }

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerValue.hour == 0 &&
          _timerValue.minute == 0 &&
          _timerValue.second == 0) {
        _timer!.cancel();
      } else {
        // -1秒する
        _timerValue = _timerValue.subtract(const Duration(seconds: 1));
      }
    });
  }

  void pause() {
    _timer!.cancel();
  }

  void reset({int hours = 0, int minutes = 0, int seconds = 0}) {
    _timer!.cancel();
    _timerValue = DateTime(0, 0, 0, hours, minutes, seconds);
  }

  timerValueInfo() {
    return _timerValue;
  }
}
