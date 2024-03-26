// import 'package:flutter/material.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   List<Indicator> indicators = [
//     Indicator(name: '한국 소비자물가지수 (YoY)', isSwitched: false, currency: 'KRW'),
//     Indicator(name: '한국 외환보유고 (미국달러)', isSwitched: false, currency: 'KRW'),
//     // Add other indicators...
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notifications'),
//       ),
//       body: ListView.builder(
//         itemCount: indicators.length,
//         itemBuilder: (context, index) {
//           return SwitchListTile(
//             title: Text(indicators[index].name),
//             subtitle: Text(indicators[index].currency),
//             value: indicators[index].isSwitched,
//             secondary: Icon(
//               Icons.notifications,
//               color: indicators[index].isSwitched
//                   ? Colors.amber[800]
//                   : Colors.grey,
//             ),
//             activeColor: Colors.amber,
//             onChanged: (bool value) {
//               setState(() {
//                 indicators[index].isSwitched = value;
//               });
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class Indicator {
//   String name;
//   String currency;
//   bool isSwitched;

//   Indicator(
//       {required this.name, required this.currency, this.isSwitched = false});
// }
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:find/main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Indicator> indicators = [
    Indicator(
        name: '한국 소비자물가지수 (YoY)', isSwitched: false, currency: 'KRW', id: 1),
    Indicator(
        name: '한국 외환보유고 (미국달러)', isSwitched: false, currency: 'KRW', id: 2),
    // Add other indicators...
  ];

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _scheduleNotification(int id) async {
    var androidDetails = const AndroidNotificationDetails(
        'channelId', 'channelName',
        channelDescription: 'channelDescription');
    var iosDetails = const IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Scheduled Alert',
        'An event for ${indicators.firstWhere((indicator) => indicator.id == id).name} is due!',
        tz.TZDateTime.now(tz.local).add(const Duration(
            seconds: 5)), // This schedules the notification 5 seconds from now
        generalNotificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: indicators.length,
        itemBuilder: (context, index) {
          return SwitchListTile(
            title: Text(indicators[index].name),
            subtitle: Text(indicators[index].currency),
            value: indicators[index].isSwitched,
            secondary: Icon(
              Icons.notifications,
              color: indicators[index].isSwitched
                  ? Colors.amber[800]
                  : Colors.grey,
            ),
            activeColor: Colors.amber,
            onChanged: (bool value) {
              setState(() {
                indicators[index].isSwitched = value;
                if (value) {
                  _scheduleNotification(indicators[index].id);
                } else {
                  flutterLocalNotificationsPlugin.cancel(indicators[index]
                      .id); // Cancel the notification if the switch is turned off
                }
              });
            },
          );
        },
      ),
    );
  }
}

class Indicator {
  String name;
  String currency;
  bool isSwitched;
  int id; // Added an ID for the indicator

  Indicator(
      {required this.name,
      required this.currency,
      this.isSwitched = false,
      required this.id});
}
