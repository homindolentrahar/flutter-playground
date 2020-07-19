// GENERATED CODE - DO NOT MODIFY BY HAND

part of list_item;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RandomItem extends RandomItem {
  @override
  final String title;
  @override
  final int randomNumber;
  @override
  final int colorInt;

  factory _$RandomItem([void Function(RandomItemBuilder) updates]) =>
      (new RandomItemBuilder()..update(updates)).build();

  _$RandomItem._({this.title, this.randomNumber, this.colorInt}) : super._() {
    if (title == null) {
      throw new BuiltValueNullFieldError('RandomItem', 'title');
    }
    if (randomNumber == null) {
      throw new BuiltValueNullFieldError('RandomItem', 'randomNumber');
    }
    if (colorInt == null) {
      throw new BuiltValueNullFieldError('RandomItem', 'colorInt');
    }
  }

  @override
  RandomItem rebuild(void Function(RandomItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RandomItemBuilder toBuilder() => new RandomItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RandomItem &&
        title == other.title &&
        randomNumber == other.randomNumber &&
        colorInt == other.colorInt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, title.hashCode), randomNumber.hashCode), colorInt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RandomItem')
          ..add('title', title)
          ..add('randomNumber', randomNumber)
          ..add('colorInt', colorInt))
        .toString();
  }
}

class RandomItemBuilder implements Builder<RandomItem, RandomItemBuilder> {
  _$RandomItem _$v;

  String _title;

  String get title => _$this._title;

  set title(String title) => _$this._title = title;

  int _randomNumber;

  int get randomNumber => _$this._randomNumber;

  set randomNumber(int randomNumber) => _$this._randomNumber = randomNumber;

  int _colorInt;

  int get colorInt => _$this._colorInt;

  set colorInt(int colorInt) => _$this._colorInt = colorInt;

  RandomItemBuilder();

  RandomItemBuilder get _$this {
    if (_$v != null) {
      _title = _$v.title;
      _randomNumber = _$v.randomNumber;
      _colorInt = _$v.colorInt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RandomItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RandomItem;
  }

  @override
  void update(void Function(RandomItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RandomItem build() {
    final _$result = _$v ??
        new _$RandomItem._(
            title: title, randomNumber: randomNumber, colorInt: colorInt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
