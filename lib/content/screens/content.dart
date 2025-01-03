import 'package:flutter/material.dart';
import 'package:jjimkong/board/screens/board.dart';
import 'package:jjimkong/common/widget/base_bottom_navigation_bar.dart';
import 'package:jjimkong/home/screens/home.dart';
import 'package:jjimkong/map/screens/map.dart';

class Content extends StatefulWidget {
  @override
  ContentState createState() => ContentState();
}

enum TabItem { home, map, board }

class ContentState extends State<Content> {
  TabItem _selectedTab = TabItem.home;
  bool _visibleNav = true;

  final Map<TabItem, Widget> _pages = {
    TabItem.home: HomeScreen(),
    TabItem.map: MapScreen(),
    TabItem.board: BoardScreen(),
  };

  @override
  void initState() {
    super.initState();
    // moveToSetNickname();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedTab = TabItem.values[index];
    });
  }

  void _onNavVisible(bool value) {
    setState(() {
      _visibleNav = value;
    });
  }

  Widget _onPageRender() {
    return _selectedTab == TabItem.board
        ? BoardScreen(onNavVisible: _onNavVisible)
        : _pages[_selectedTab]!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _onPageRender(), // 선택된 탭에 따라 페이지 변경
        bottomNavigationBar: _visibleNav
            ? BaseBottomNavigationBar(
                currentIndex: _selectedTab.index,
                onTap: _onItemTapped,
              )
            : null,
      ),
    );
  }
}
