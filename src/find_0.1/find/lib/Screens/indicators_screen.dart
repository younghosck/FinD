import 'package:flutter/material.dart';

class IndicatorsScreen extends StatelessWidget {
  IndicatorsScreen({super.key});

  final List<String> categories = [
    'Employment',
    'Consumption',
    'Price',
    'Production',
    'Government/Bank',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Economic Indicators'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(categories[index]),
              onTap: () {
                // Handle the tap event and navigate to corresponding detail screen
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailScreen(category: categories[index])));
              },
            ),
          );
        },
      ),
    );
  }
}
