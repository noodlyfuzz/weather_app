import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.grey[850],
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.today), label: 'today'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cloud_circle_sharp), label: 'forecast'),
            // BottomNavigationBarItem(icon: Icon(Icons.today), label: ':D'),
          ],
          onTap: onSelectedTab,
        ),
        appBar: AppBar(
          title: Text('Weather app'),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _selectedTab,
          children: [
            // ThisDayWidget(),
            // ForecastWidget(),
          ],
        ));
  }
}
