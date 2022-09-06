import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/services/local_notification_service.dart';
import 'package:blavapp/utils/model_helper.dart';
import 'package:flutter/material.dart';

class DevelopmentPage extends StatelessWidget {
  const DevelopmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
      titleText: 'Development',
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              LocalNotificationService().showNotification(
                notificationId: stringIdToIntId('test-now'),
                title: 'Test title',
                body: 'Test body',
              );
            },
            child: const Text('Trigger notification'),
          ),
          ElevatedButton(
            onPressed: () {
              LocalNotificationService().scheduleNotification(
                notificationId: stringIdToIntId('test-5'),
                title: 'Test title',
                body: 'Test body',
                triggerAt: DateTime.now().add(
                  const Duration(seconds: 5),
                ),
              );
            },
            child: const Text('Schedule notification (5s)'),
          ),
        ],
      ),
    );
  }
}
