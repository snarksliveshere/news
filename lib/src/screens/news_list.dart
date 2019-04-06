import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    // temporary/ this is bad
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News')
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator()
          );
        }
        return ListView.builder(
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(
                  itemId: snapshot.data[index],

              );
            },
            itemCount: snapshot.data.length,
        );
      },
    );
  }
}