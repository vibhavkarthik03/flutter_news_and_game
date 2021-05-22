import 'package:flutter/material.dart';
import 'package:flutter_news_and_game/screens/gameScreen.dart';
import 'package:flutter_news_and_game/screens/newsScreen.dart';
import 'package:flutter_news_and_game/widgets/newsTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newsList;
  int _selectedScreenIndex = 0;

  Widget Function() gamesScreen = () {
    return GameScreen();
  };

  Widget Function() newsScreen = () {
    return NewsScreen();
  };

  @override
  Widget build(BuildContext context) {
    List<Widget Function()> screens = [gamesScreen, newsScreen];
    return Scaffold(
      appBar: MyAppBar(),
      body: PageView.builder(
        itemCount: 2,
        itemBuilder: (context, position) {
          return Container(
            child: screens[_selectedScreenIndex](),
          );
        },
        onPageChanged: (page) {
          setState(
            () {
              _selectedScreenIndex = page;
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedScreenIndex,
        onTap: _onTabChanged,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.videogame_asset,
              ),
              label: 'Games'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
              ),
              label: 'News'),
        ],
      ),
    );
  }

  void _onTabChanged(int index) {
    setState(
      () {
        _selectedScreenIndex = index;
      },
    );
  }
}
