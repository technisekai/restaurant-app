import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    final NotificationHelper _notificationHelper = NotificationHelper();
    return Scaffold(
      body: SafeArea(
        /* for responsive */
        child: SingleChildScrollView(
          /* padding screen */
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFc80064),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  /* widget align */
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    /* title */
                    Text(
                      'Settings',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'DM Sans',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    /* desc */
                    Text(
                      'Enable/Unable notification',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Dancing Script',
                          fontSize: 16,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              /* line space */
              const SizedBox(
                height: 16,
              ),
              /* switch button to en or dis notify */
              Consumer<PreferencesProvider>(
                  builder: (context, provider, child) {
                return Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Enable/disable daily restaurant: ',
                          style: TextStyle(
                              color: Color(0xFF6b7280),
                              fontFamily: 'Open Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        /* line space */
                        const SizedBox(
                          width: 10,
                        ),
                        Switch.adaptive(
                          value: provider.isDailyRestaurantActive,
                          onChanged: (value) async {
                            scheduled.scheduledRestaurant(value);
                            provider.enableDailyRestaurant(value);
                          },
                        ),
                      ],
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
