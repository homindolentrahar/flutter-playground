library list_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:pagination/data/model/random_model.dart';

part 'random_state.g.dart';

abstract class RandomState implements Built<RandomState, RandomStateBuilder> {
  BuiltList<RandomItem> get listItem;

  bool get loading;

  bool get completed;

  bool get hasReachEndOfResult;

  RandomState._();

  factory RandomState([updates(RandomStateBuilder b)]) = _$RandomState;

  factory RandomState.initial() {
    return RandomState((b) => b
      ..listItem.replace(BuiltList<RandomItem>())
      ..loading = true
      ..completed = false
      ..hasReachEndOfResult = false);
  }

  factory RandomState.success(BuiltList<RandomItem> items) {
    return RandomState((b) => b
      ..listItem.replace(items)
      ..loading = false
      ..completed = true
      ..hasReachEndOfResult = false);
  }
}
