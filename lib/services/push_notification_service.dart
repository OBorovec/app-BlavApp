import 'package:blavapp/firebase_options.dart';
import 'package:blavapp/services/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static final PushNotificationService _service =
      PushNotificationService._internal();

  factory PushNotificationService() {
    return _service;
  }

  PushNotificationService._internal();

  Future<void> init() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance.subscribeToTopic('main');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        LocalNotificationService().showNotification(
          notificationId: 0,
          title: message.notification?.title ?? '---',
          body: message.notification?.body ?? '---',
        );
      });
    }
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await LocalNotificationService().init();
    LocalNotificationService().showNotification(
      notificationId: 0,
      title: message.notification?.title ?? '---',
      body: message.notification?.body ?? '---',
    );
  }

  void subscribeTo(String topic) {
    FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  void unsubscribeFrom(String topic) {
    FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  void unsubscribeAll() {
    FirebaseMessaging.instance.deleteToken();
  }
}
