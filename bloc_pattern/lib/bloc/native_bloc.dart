//  Event
import 'dart:async';

enum NumberEvent { increment, decrement }

//  Bloc
class NumberBloc {
  int number = 0;

//  Event
  StreamController<NumberEvent> _eventController = StreamController();

  Sink<NumberEvent> get eventSink => _eventController.sink;

//  State
  StreamController<int> _stateController = StreamController();

  StreamSink<int> get _stateSink => _stateController.sink;

  Stream<int> get stateStream => _stateController.stream;

  void _mapEventToState(NumberEvent event) {
    if (event == NumberEvent.increment) {
      number++;
    } else {
      number--;
    }

    _stateSink.add(number);
  }

  NumberBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
