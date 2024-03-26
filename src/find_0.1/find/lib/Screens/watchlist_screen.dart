import 'package:flutter/material.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  //Appbar Underline Loaidng
  final bool _isLoading = false;

  // Dummy data for the stock market list
  final List<Map<String, dynamic>> _marketData = [
    {
      'name': 'NASDAQ',
      'value': '56.97',
      'change': '+0.78%',
      'volume': 'Vol 3.2M',
    },
    // Add other market data...
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    const WatchlistScreen(), // Placeholder for Watchlist Feature
    const Text('Graph Display'), // Placeholder for Graph Display Feature
    const Text('Indicators'), // Placeholder for Indicators Feature
    const Text('Notifications'), // Placeholder for Notifications Feature
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // This will be your TabBar or Row of List options
          Container(
            color: Colors.grey[200], // Color for the tab bar container
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //User Data에 바뀌도록 변경해야 함.
                // Use FlatButton or TextButton for your List1, List2, List3...
                TextButton(
                  onPressed: () {
                    // Handle navigation or state update
                  },
                  child: const Text('List1'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle navigation or state update
                  },
                  child: const Text('List2'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle navigation or state update
                  },
                  child: const Text('List3'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _marketData.length,
              itemBuilder: (context, index) {
                final item = _marketData[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text(item['value']),
                  trailing: Text(item['change']),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle add indicators action
            },
            child: const Text('ADD Indicators'),
          ),
        ],
      ),
    );
  }
}
