import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:pagination/data/model/random_model.dart';

class RandomDataSource {
  static const int ITEMS_PER_PAGE = 10;
  static const int PAGE_COUNT = 5;
  static final _randomGenerator = Random();

  int _showPagesCount = 0;

  Future<BuiltList<RandomItem>> getNextListPage() async {
    if (_showPagesCount >= PAGE_COUNT) {
      throw NoNextPageException();
    }

    _showPagesCount++;

    await Future.delayed(Duration(milliseconds: 750));

    return BuiltList.of(List.generate(
      ITEMS_PER_PAGE,
      _generateListItem,
    ));
  }

  RandomItem _generateListItem(int index) {
    return RandomItem(
      (b) => b
        ..title = "Data ke-$index"
        ..randomNumber = _randomGenerator.nextInt(500)
        ..colorInt = _randomGenerator.nextInt(0xFFFFFFFF),
    );
  }
}

class NoNextPageException implements Exception {}
