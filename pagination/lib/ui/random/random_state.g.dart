// GENERATED CODE - DO NOT MODIFY BY HAND

part of list_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RandomState extends RandomState {
  @override
  final BuiltList<RandomItem> listItem;
  @override
  final bool loading;
  @override
  final bool completed;
  @override
  final bool hasReachEndOfResult;

  factory _$RandomState([void Function(RandomStateBuilder) updates]) =>
      (new RandomStateBuilder()..update(updates)).build();

  _$RandomState._(
      {this.listItem, this.loading, this.completed, this.hasReachEndOfResult})
      : super._() {
    if (listItem == null) {
      throw new BuiltValueNullFieldError('RandomState', 'listItem');
    }
    if (loading == null) {
      throw new BuiltValueNullFieldError('RandomState', 'loading');
    }
    if (completed == null) {
      throw new BuiltValueNullFieldError('RandomState', 'completed');
    }
    if (hasReachEndOfResult == null) {
      throw new BuiltValueNullFieldError('RandomState', 'hasReachEndOfResult');
    }
  }

  @override
  RandomState rebuild(void Function(RandomStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RandomStateBuilder toBuilder() => new RandomStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RandomState &&
        listItem == other.listItem &&
        loading == other.loading &&
        completed == other.completed &&
        hasReachEndOfResult == other.hasReachEndOfResult;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, listItem.hashCode), loading.hashCode),
            completed.hashCode),
        hasReachEndOfResult.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RandomState')
          ..add('listItem', listItem)
          ..add('loading', loading)
          ..add('completed', completed)
          ..add('hasReachEndOfResult', hasReachEndOfResult))
        .toString();
  }
}

class RandomStateBuilder implements Builder<RandomState, RandomStateBuilder> {
  _$RandomState _$v;

  ListBuilder<RandomItem> _listItem;

  ListBuilder<RandomItem> get listItem =>
      _$this._listItem ??= new ListBuilder<RandomItem>();

  set listItem(ListBuilder<RandomItem> listItem) => _$this._listItem = listItem;

  bool _loading;

  bool get loading => _$this._loading;

  set loading(bool loading) => _$this._loading = loading;

  bool _completed;

  bool get completed => _$this._completed;

  set completed(bool completed) => _$this._completed = completed;

  bool _hasReachEndOfResult;

  bool get hasReachEndOfResult => _$this._hasReachEndOfResult;

  set hasReachEndOfResult(bool hasReachEndOfResult) =>
      _$this._hasReachEndOfResult = hasReachEndOfResult;

  RandomStateBuilder();

  RandomStateBuilder get _$this {
    if (_$v != null) {
      _listItem = _$v.listItem?.toBuilder();
      _loading = _$v.loading;
      _completed = _$v.completed;
      _hasReachEndOfResult = _$v.hasReachEndOfResult;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RandomState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RandomState;
  }

  @override
  void update(void Function(RandomStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RandomState build() {
    _$RandomState _$result;
    try {
      _$result = _$v ??
          new _$RandomState._(
              listItem: listItem.build(),
              loading: loading,
              completed: completed,
              hasReachEndOfResult: hasReachEndOfResult);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'listItem';
        listItem.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'RandomState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
