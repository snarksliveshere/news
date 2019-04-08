import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
          child: MaterialApp(
            title: 'News!',
            onGenerateRoute: this.routes,
          )
      )
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
          builder: (context) {
            return NewsList();
          }
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));
          commentsBloc.fetchItemWithComments(itemId);
          // extract item.id from settings.name
          return NewsDetail(
            itemId: itemId
          );
        }
      );
    }

  }
}