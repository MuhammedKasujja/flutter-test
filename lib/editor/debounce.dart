// https://stackoverflow.com/a/55119208/497368
import 'dart:async';
import 'dart:ui';

class Debouncer {
  Debouncer({
    this.milliseconds = 500,
  });

  final int milliseconds;

  static VoidCallback? action;
  static Timer? timer;

  void run(VoidCallback action) {
    if (milliseconds == 0) {
      action();
      return;
    }

    if (timer != null) {
      timer!.cancel();
    }

    Debouncer.action = action;

    timer = Timer(Duration(milliseconds: milliseconds), () {
      action();
      Debouncer.action = null;
      Debouncer.timer = null;
    });
  }

  static void complete() {
    if (action != null) {
      action!();
      action = null;
    }
  }

  static void runOnComplete(Function callback) {
    complete();
    callback();
  }
}