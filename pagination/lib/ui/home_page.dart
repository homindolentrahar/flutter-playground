import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pagination/data/model/random_model.dart';
import 'package:pagination/ui/random/random_bloc.dart';
import 'package:pagination/ui/random/random_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _randomBloc = KiwiContainer().resolve<RandomBloc>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    _randomBloc.getNexListPage();
    super.initState();
  }

  @override
  void dispose() {
    _randomBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pagination Lab",
        ),
      ),
      body: BlocBuilder<RandomBloc, RandomState>(
        bloc: _randomBloc,
        builder: (ctx, state) {
          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.completed) {
            return NotificationListener(
              onNotification: _handleScrollNotification,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                separatorBuilder: (ctx, index) => Divider(),
                itemCount: calculateListItemCount(state),
                itemBuilder: (ctx, index) => index >= state.listItem.length
                    ? _buildLoaderListItem()
                    : _buildDataListItem(state.listItem[index]),
              ),
            );
          } else {
            return Center(
              child: Text("Unknown :("),
            );
          }
        },
      ),
    );
  }

  Widget _buildLoaderListItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDataListItem(RandomItem item) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Color(item.colorInt),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        item.randomNumber.toString(),
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _randomBloc.getNexListPage();
    }

    return false;
  }

  int calculateListItemCount(RandomState state) {
    if (state.hasReachEndOfResult) {
      return state.listItem.length;
    } else {
      return state.listItem.length + 1;
    }
  }
}
