import 'package:alejandria/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegationModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegation(),
      ),
    );
  }
}

class _Navegation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegationModel = Provider.of<_NavegationModel>(context);
    return BottomNavigationBar(
        currentIndex: navegationModel.currentScreen,
        onTap: (i) => navegationModel.currentScreen = i,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 27), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 27), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined, size: 35), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications, size: 27), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 27), label: ''),
        ]);
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegationModel = Provider.of<_NavegationModel>(context);
    return PageView(
      controller: navegationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        HomeScreen(),
        ExplorerScreen(),
        NewPostScreen(),
        NotificationsScreen(),
        UserScreen()
      ],
    );
  }
}

class _NavegationModel with ChangeNotifier {
  int _currentScreen = 0;
  PageController _pageController = PageController();

  int get currentScreen => _currentScreen;

  set currentScreen(int value) {
    _currentScreen = value;
    _pageController.animateToPage(value,
        curve: Curves.linear, duration: Duration(microseconds: 50));
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
