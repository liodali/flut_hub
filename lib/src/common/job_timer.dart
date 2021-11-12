import 'dart:async';

/// [JobTimer]
/// this class for role to make timer job when it need like Thread in java
/// with combination of hookWidget,
/// you can instantiate this class with default constructor JobTimer
/// or minimum required attribute `minimum` named constructor
/// contain 3 method  : dispose , run , setJobCallback
/// dispose : to cancel current Timer it timer not null
/// setJobCallback : to change job need it to be run or to initialize the job
/// run : should be run after setJobCallback it callback not initialized
/// [duration] : waiting duration of the job before it start running
///
/// [callback] : job that will be executed
class JobTimer {
  final Duration duration;
  late Function callback;
  Timer? _timer;

  JobTimer({
    required this.duration,
    required this.callback,
  });

  JobTimer.minimum({
    required this.duration,
  });

  /// setJobCallback
  /// this method should be called before run method
  /// if AppTimer initialized with minimum constructor
  /// take Function as parameter that illustrate the job
  /// that will run in timer callback
  /// throw late init exception
  void setJobCallback(Function function) {
    callback = function;
  }

  void dispose() {
    _timer?.cancel();
  }

  void run() {
    if (_timer != null && _timer!.isActive) {
      dispose();
    }
    _timer = Timer(duration, () => callback());
  }
}