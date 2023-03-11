import 'package:flutter/material.dart';
import 'package:news/blocs/comments_bloc.dart';
import 'package:news/blocs/comments_provider.dart';
import 'package:news/blocs/stories_provider.dart';
import 'package:news/screens/home_screen.dart';
import 'package:news/screens/news_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'Hacker News App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: const HomeScreen(),
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route? routes(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) {
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();
          return const HomeScreen();
        });
      case NewsDetails.routeName:
        return MaterialPageRoute(
          builder: (context) {
            // A fantasic location to do some initialization
            // or data fetching before the screen is shown
            final int itemId = settings.arguments as int;

            final commentsBloc = CommentsProvider.of(context);
            commentsBloc.fetchItemWithComments(itemId);
            return NewsDetails(itemId: itemId);
          },
        );

      default:
        return null;
    }
  }
}
