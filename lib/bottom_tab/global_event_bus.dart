import 'package:event_bus/event_bus.dart';

class GlobalEventBus {
  static EventBus _eventBus;

  static EventBus get eventBus {
    _eventBus ??= EventBus();
    return _eventBus;
  }
}

abstract class AppEvent {}

class SendEvent extends AppEvent {}
