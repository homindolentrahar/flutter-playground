library list_item;

import 'package:built_value/built_value.dart';

part 'random_model.g.dart';

abstract class RandomItem implements Built<RandomItem, RandomItemBuilder> {
  String get title;

  int get randomNumber;

  int get colorInt;

  RandomItem._();

  factory RandomItem([updates(RandomItemBuilder b)]) = _$RandomItem;
}
