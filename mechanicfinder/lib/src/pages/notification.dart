import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  //initialize

  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: false,
            requestSoundPermission: true);
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationPlugin.initialize(initializationSettings);
  }

  //instant notifications
  Future inistantNotification(
      int id, String name, String description) async {
    var android = AndroidNotificationDetails("id", "name", "description");
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await _flutterLocalNotificationPlugin.show(
        id, name, description, platform,
        payload: 'Welcome to Demo app');
  }

  //image notifications
  Future imageNotification() async {
    // var bigPicture = BigPictureStyleInformation(
    //     DrawableResourceAndroidBitmap("ic_launcher"),
    //     largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
    //     contentTitle: "Demo image notification",
    //     summaryText: "This",
    //     htmlFormatContent: true,
    //     htmlFormatContentTitle: true);
    // var android = AndroidNotificationDetails("id", "channel", "description",
    //     styleInformation: bigPicture);

    // // var ios = IOSNotificationDetails();
    // var platform = new NotificationDetails(
    //   android: android,
    // );
    // await _flutterLocalNotificationPlugin.show(
    //     1, "Demo Image notification", "Tap to do somethins", platform,
    //     payload: 'Welcome to Demo app');

    final String largeIconPath = await _downloadAndSaveFile(
        'https://via.placeholder.com/48x48', 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(
        'https://via.placeholder.com/400x800', 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: 'overridden <b>big</b> content title',
            htmlFormatContentTitle: true,
            summaryText: 'summary <i>text</i>',
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('big text channel id',
            'big text channel name', 'big text channel description',
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics);
  }

  //stylish notification
  Future stylishNotification() async {
    var android = AndroidNotificationDetails("id", "channel", "description",
        color: Colors.deepOrange,
        enableLights: true,
        enableVibration: true,
        largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
        styleInformation: MediaStyleInformation(
            htmlFormatContent: true, htmlFormatTitle: true));

    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(
      android: android,
    );
    await _flutterLocalNotificationPlugin.show(
      0,
      "Demo notification",
      "Tap to do somethins",
      platform,
    );

    //imagefromNetwork
    Future<String> _downloadAndSaveFile(String url, String fileName) async {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/$fileName';
      final http.Response response = await http.get(Uri.parse(url));
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    }

    Future<void> showBigPictureNotification() async {
      final String largeIconPath = await _downloadAndSaveFile(
          'https://via.placeholder.com/48x48', 'largeIcon');
      final String bigPicturePath = await _downloadAndSaveFile(
          'https://via.placeholder.com/400x800', 'bigPicture');
      final BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
              largeIcon: FilePathAndroidBitmap(largeIconPath),
              contentTitle: 'overridden <b>big</b> content title',
              htmlFormatContentTitle: true,
              summaryText: 'summary <i>text</i>',
              htmlFormatSummaryText: true);
      final AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('big text channel id',
              'big text channel name', 'big text channel description',
              styleInformation: bigPictureStyleInformation);
      final NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await _flutterLocalNotificationPlugin.show(
          0, 'big text title', 'silent body', platformChannelSpecifics);
    }

    Future<void> _showBigPictureNotificationHiddenLargeIcon() async {
      final String largeIconPath = await _downloadAndSaveFile(
          'https://via.placeholder.com/48x48', 'largeIcon');
      final String bigPicturePath = await _downloadAndSaveFile(
          'https://via.placeholder.com/400x800', 'bigPicture');
      final BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
              hideExpandedLargeIcon: true,
              contentTitle: 'overridden <b>big</b> content title',
              htmlFormatContentTitle: true,
              summaryText: 'summary <i>text</i>',
              htmlFormatSummaryText: true);
      final AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('big text channel id',
              'big text channel name', 'big text channel description',
              largeIcon: FilePathAndroidBitmap(largeIconPath),
              styleInformation: bigPictureStyleInformation);
      final NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await _flutterLocalNotificationPlugin.show(
          0, 'big text title', 'silent body', platformChannelSpecifics);
    }

    Future<void> _showNotificationMediaStyle() async {
      final String largeIconPath = await _downloadAndSaveFile(
          'https://via.placeholder.com/128x128/00FF00/000000', 'largeIcon');
      final AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'media channel id',
        'media channel name',
        'media channel description',
        largeIcon: FilePathAndroidBitmap(largeIconPath),
        styleInformation: const MediaStyleInformation(),
      );
      final NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await _flutterLocalNotificationPlugin.show(0, 'notification title',
          'notification body', platformChannelSpecifics);
    }

    Future<void> _showBigTextNotification() async {
      const BigTextStyleInformation bigTextStyleInformation =
          BigTextStyleInformation(
        'Lorem <i>ipsum dolor sit</i> amet, consectetur <b>adipiscing elit</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        htmlFormatBigText: true,
        contentTitle: 'overridden <b>big</b> content title',
        htmlFormatContentTitle: true,
        summaryText: 'summary <i>text</i>',
        htmlFormatSummaryText: true,
      );
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('big text channel id',
              'big text channel name', 'big text channel description',
              styleInformation: bigTextStyleInformation);
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await _flutterLocalNotificationPlugin.show(
          0, 'big text title', 'silent body', platformChannelSpecifics);
    }
  }

  //image notifications
  Future secheduledNotification() async {
    var interval = RepeatInterval.everyMinute;
    // var bigPicture = BigPictureStyleInformation(
    //     DrawableResourceAndroidBitmap("ic_launcher"),
    //     largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
    //     contentTitle: "Demo image notification",
    //     summaryText: "This",
    //     htmlFormatContent: true,
    //     htmlFormatContentTitle: true);

    var android = AndroidNotificationDetails(
      "id",
      "channel",
      "description",
    );

    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(
      android: android,
    );
    await _flutterLocalNotificationPlugin.periodicallyShow(
      0,
      "Demo Shedule notification",
      "Tap to do somethins",
      interval,
      platform,
    );
  }

  //cancel notification
  cancelNotificaion() async {
    await _flutterLocalNotificationPlugin.cancelAll();
  }

  //imagefromNetwork
  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

class NotificationHome extends StatefulWidget {
  @override
  _NotificationHomeState createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NotificationService>(context, listen: false).initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Consumer<NotificationService>(
        builder: (context, model, _) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => model.inistantNotification(1,'Message sent','Clear'),
                child: Text('Instant Notification')),
            ElevatedButton(
                onPressed: () => model.stylishNotification(),
                child: Text('Instant Notification')),
            ElevatedButton(
                onPressed: () => model.imageNotification(),
                child: Text('Image Notification')),
            ElevatedButton(
                onPressed: () => model.secheduledNotification(),
                child: Text('Scheduled Notification')),
            ElevatedButton(
                onPressed: () => model.cancelNotificaion(),
                child: Text('Cancel Notification'))
          ],
        ),
      )),
    );
  }
}
