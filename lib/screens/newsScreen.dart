import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_and_game/utils/fetchNews.dart';
import 'package:flutter_news_and_game/widgets/newsTile.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _loading;
  var newsList;
  int _currentMax = 5;
  ScrollController _scrollController = new ScrollController();

  void getNews() async {
    News news = News();
    await news.getNews();
    newsList = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    getNews();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getNextFiveNews();
      }
    });
  }

  _getNextFiveNews() async {
    print('reached end');
    if (_currentMax == newsList.length) {
      _currentMax = newsList.length;
    } else {
      Timer(
          Duration(seconds: 1),
          () => setState(() {
                _currentMax = _currentMax + 5;
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: _currentMax + 1,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == _currentMax) {
                  return _currentMax == newsList.length
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoActivityIndicator(),
                        );
                }
                return NewsTile(
                  imgUrl: newsList[index].urlToImage ?? "",
                  title: newsList[index].title ?? "",
                  desc: newsList[index].description ?? "",
                  content: newsList[index].content ?? "",
                  posturl: newsList[index].articleUrl ?? "",
                );
              }),
    );
  }
}
