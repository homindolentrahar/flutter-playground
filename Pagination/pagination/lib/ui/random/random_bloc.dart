import 'package:bloc/bloc.dart';
import 'package:pagination/data/generator/random_data_source.dart';
import 'package:pagination/ui/random/random_event.dart';
import 'package:pagination/ui/random/random_state.dart';

class RandomBloc extends Bloc<RandomEvent, RandomState> {
  final RandomDataSource _dataSource;

  RandomBloc(this._dataSource) : super(RandomState.initial());

  void getNexListPage() {
    add(FetchNextPage());
  }

  @override
  Stream<RandomState> mapEventToState(RandomEvent event) async* {
    if (event is FetchNextPage) {
      try {
        final nextPageItems = await _dataSource.getNextListPage();
        yield RandomState.success(state.listItem + nextPageItems);
      } on NoNextPageException catch (_) {
        yield state.rebuild((b) => b..hasReachEndOfResult = true);
      }
    }
  }
}
