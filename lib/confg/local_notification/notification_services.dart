import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('back');

  void initializationNotification() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  Future<void> BigNotification(String title, String body) async {
    BigPictureStyleInformation bigPictureStyleInformation =
        const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('back'),
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'big_id_channel_id',
      'big_picture_channel_name',
      // color: Colors.orange,
      // category: AndroidNotificationCategory.social,
      importance: Importance.max,
      priority: Priority.high,
      icon: 'logo',
      styleInformation: bigPictureStyleInformation,
      channelShowBadge: true,
      largeIcon: const DrawableResourceAndroidBitmap('back'),
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    print('lalalal');
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

}
