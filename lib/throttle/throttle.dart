import 'dart:async';

/// 函数节流
///
/// [func]: 要执行的方法
Function throttle(
  Future Function() func,
) {
  if (func == null) {
    return func;
  }
  bool enable = true;
  Function target = () {
    if (enable == true) {
      enable = false;
      func().then((_) {
        enable = true;
      });
    }
  };
  return target;
}
