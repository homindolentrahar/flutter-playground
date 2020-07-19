import 'package:kiwi/kiwi.dart';
import 'package:pagination/data/generator/random_data_source.dart';
import 'package:pagination/ui/random/random_bloc.dart';

void initKiwi() {
  KiwiContainer().registerSingleton((container) => RandomDataSource());
  KiwiContainer()
      .registerSingleton((container) => RandomBloc(container.resolve()));
}
