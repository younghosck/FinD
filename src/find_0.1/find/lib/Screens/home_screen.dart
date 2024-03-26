import 'package:find/Screens/notification_screen.dart';
import 'package:find/Screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:find/Screens/graph_screen.dart';
import 'package:find/Screens/indicators_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectedIndex = 0;
  //Appbar Underline Loaidng
  final bool _isLoading = false;
  static final List<Widget> _widgetOptions = <Widget>[
    const WatchlistScreen(), // Placeholder for Watchlist Feature
    const GraphScreen(), // Placeholder for Graph Display Feature
    IndicatorsScreen(), // Placeholder for Indicators Feature
    const NotificationScreen(), // Placeholder for Notifications Feature
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform(
          //for Customizing UI
          transform: Matrix4.translationValues(0, -10.0, 0),
          child: Text(
            'FinD',
            style: TextStyle(color: Colors.teal[700]),
          ),
        ),
        leading: Transform(
          transform: Matrix4.translationValues(0, -5.0, 0),
          child: IconButton(
            icon: const Icon(Icons.person_outline_rounded),
            onPressed: () {
              //Handle the settings icon action
            },
          ),
        ),
        actions: <Widget>[
          Transform(
            transform: Matrix4.translationValues(0, -5.0, 0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                //Handle the search icon action
              },
            ),
          ),
        ],
        bottom: _isLoading
            ? PreferredSize(
                preferredSize: const Size.fromHeight(3.0),
                child: LinearProgressIndicator(
                  value: null,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(3.0),
                child: LinearProgressIndicator(
                  value: 1.0,
                  backgroundColor: Colors.amber[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Graphs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drag_indicator),
            label: 'Indicators',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
