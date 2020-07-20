import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//  Event
class ColorEvent {
  final Color color;
  final String title;

  ColorEvent({this.color, this.title});
}

//  State
class ColorState {
  final Color color;
  final String title;

  ColorState({this.color, this.title});
}

//  Bloc
class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc()
      : super(ColorState(
          color: Colors.blue,
          title: "Blue",
        ));

  @override
  Stream<ColorState> mapEventToState(ColorEvent event) async* {
    yield ColorState(color: event.color, title: event.title);
  }
}
