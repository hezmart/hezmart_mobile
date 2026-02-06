
// import 'package:plain_notification_token/plain_notification_token.dart';

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hezmart/features/notificationss/data/repo_impl/Notification_impl.dart';
import 'package:hezmart/features/notificationss/domain/notification_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/authentication/data/data/repo_impl/authrepositoryimpl.dart';
import '../../../features/authentication/presentations/authbloc/auth_bloc.dart';
import '../../../features/authentication/presentations/user_bloc/user_bloc.dart';
import '../../../features/notificationss/data/models/token_payload.dart';
import '../../../features/notificationss/presentationss/bloc/notification_bloc.dart';
import '../../di/injector.dart';
import '../../theme/pallets.dart';
import '../network/network_service.dart';

final NotificationService notificationService = NotificationService();
// final authbloc = AuthBloc(AuthRepositoryImpl(NetworkService()));

String notiToken = '';
String tokensave = '';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Define a top-level named handler which background/terminated messages will
/// call.

/// To verify things are working, check out the native platform logs.
///
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.i('Handling a background message ${message.data}');
  await notificationService.initializeNotification();

  notificationService.triggerHeadsUp(
    message.notification.hashCode,
    message.notification?.title ?? message.data['title'],
    message.notification?.body ?? message.data['body'],
  );
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

class NotificationService {
  NotificationService();

  /// get users device token
  String? token;
  final tokenbloc = MyNotificationBloc(NotificationRepositoryImpl(NetworkService()));

  /// Initialize notification
  Future<void> initializeNotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android:AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableLights: true,
        showBadge: true,
        playSound: true,
      );

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // await FirebaseMessaging.instance
    //     .subscribeToTopic("all"); //subscribe firebase message on topic

    // await FirebaseMessaging.instance.subscribeToTopic('kusnap');
    _triggerAllSetUp();
  }

  static void onNotificationTap(NotificationResponse notificationResponse) {
    ///
  }

  /// Triggers all notification
  void _triggerAllSetUp() async {
    _requestPermission();
    getInitialMessage();
    _listenToMessage();
    _openMessageApp();
    _getToken();
    _refreshToken();
  }

  _requestPermission() {
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      FirebaseMessaging.instance.requestPermission();

    }

    /// initialize
    ///
  }

  /// Get initialize messages
  Future<RemoteMessage?> getInitialMessage() async {
    RemoteMessage? message =
    await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      logger.i(message);

      return message;
    }

    return null;
  }

  /// Get initialize messages
  void _listenToMessage() async {
    // await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.i('Got a message whilst in the foreground!');
      logger.i('Message data: ${message.data}');
      //
      triggerHeadsUp(
          message.notification.hashCode,
          message.notification?.title ?? message.data['title'],
          message.notification?.body ?? message.data['body']);
    });
  }

  void _openMessageApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i(
          'A new onMessageOpenedApp event was published! ${message.data['test']}');
    });
  }

  /// Get users token
  ///
  // void _getToken() async {
  //   try {
  //     // final plainNotificationToken = PlainNotificationToken();
  //
  //     token = await FirebaseMessaging.instance.getToken();
  //
  //     notiToken = token ?? '';
  //     // logger.e(notiToken);
  //     logger.i('My Token: $token');
  //
  //     final payload = SendTokenPayload(
  //       token: token!,
  //       platform: Platform.isIOS ? "ios" : "android",
  //     );
  //
  //     _sendTokenToBackend(payload);
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     final device_platform = prefs.getInt('device_token');
  //     if ( device_platform!= null  || injector.get<UserBloc>().appUser== null) {
  //       tokensave =device_platform.toString();
  //     }else{
  //       tokensave =device_platform.toString();
  //     }
  //     await prefs.setString(
  //       'device_token',
  //       tokensave.toString(),
  //     );
  //
  //
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }
  void _getToken() async {
    try {
      token = await FirebaseMessaging.instance.getToken();
      notiToken = token ?? '';
      logger.i('Device token fetched: $notiToken');

      final prefs = await SharedPreferences.getInstance();

      // Save token locally
      await prefs.setString('device_token', notiToken);
      tokensave = notiToken;

      logger.i('Device token saved locally.');

      // Prepare payload
      final payload = SendTokenPayload(
        token: notiToken,
        platform: Platform.isIOS ? "ios" : "android",
        userId: null,
      );

      // Listen to bloc states for logging success/failure
      tokenbloc.stream.listen((state) {
        if (state is NotificationLoadingState) {
          logger.i('Sending token to backend...');
        } else if (state is NotificationSuccessState) {
          logger.i('Token sent to backend successfully!');
        } else if (state is NotificationFailiureState) {
          logger.e('Failed to send token to backend: ${state.error}');
        }
      });

      // Send token
      _sendTokenToBackend(payload);
    } catch (e) {
      logger.e('Error fetching token: $e');
    }
  }

  /// Resend token if user logs in later
  Future<void> resendTokenToBackend({ SendTokenPayload? payload,String? userId}) async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('device_token');

    if (savedToken != null) {
      final payload = SendTokenPayload(
        token: savedToken,
        platform: Platform.isIOS ? "ios" : "android",
        userId: userId, // might be null, that's okay
      );

      _sendTokenToBackend(payload);
      logger.i('Resent token to backend for userId: $userId');
    } else {
      logger.w('No device token found to resend.');
    }
  }



  void _sendTokenToBackend(SendTokenPayload payload) {
    tokenbloc.add(NotiTokenSentEvent(payload));
  }



  ///
  // void _getToken() async {
  //   try {
  //     // Get Firebase token
  //     token = await FirebaseMessaging.instance.getToken();
  //     notiToken = token ?? '';
  //     logger.i('Device Token: $token');
  //
  //     // Get SharedPreferences instance
  //     final prefs = await SharedPreferences.getInstance();
  //
  //     // Save token locally
  //     await prefs.setString('device_token', notiToken);
  //
  //     // Generate a simple device ID if not exists
  //     String? device_token = prefs.getString('device_token');
  //     if (device_token == null) {
  //       device_token = DateTime.now().millisecondsSinceEpoch.toString();
  //       await prefs.setString('device_token', device_token);
  //     }
  //
  //     tokensave = notiToken;
  //     logger.i('Device ID: $device_token');
  //
  //     // Prepare payload
  //     final payload = SendTokenPayload(
  //       token: notiToken,
  //       platform: Platform.isIOS ? "ios" : "android",
  //     );
  //
  //     // Send token to backend
  //     // _sendTokenToBackend(payload);
  //
  //     // If user logs in later, call resendTokenToBackend()
  //   } catch (e) {
  //     logger.e('Error fetching token: $e');
  //   }
  // }
  //
  // /// Call this whenever user logs in to resend token/device ID
  // Future<void> resendTokenToBackend() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final savedToken = prefs.getString('device_token');
  //   final savedDeviceId = prefs.getString('device_id');
  //
  //   if (savedToken != null && savedDeviceId != null) {
  //     final payload = SendTokenPayload(
  //       token: savedToken,
  //       platform: Platform.isIOS ? "ios" : "android",
  //     );
  //
  //     // _sendTokenToBackend(payload);
  //     logger.i('Resent token and device ID to backend');
  //   }
  // }


  ///
//
// final bloc=MyNotificationBloc(NotificationRepositoryImpl(NetworkService()))
// ;  void _sendTokenToBackend(SendTokenPayload payload) {
//
//     bloc.add(NotiTokenSentEvent(payload));
//   }

  /// Refresh users token
  void _refreshToken() {
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      logger.d('Refresh: $event');
    });
  }

  void triggerHeadsUp(int hashCode, data, data2) {
    flutterLocalNotificationsPlugin.show(
      hashCode,
      data,
      data2,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: "@mipmap/launcher_icon",
          importance: Importance.high,
          priority: Priority.high,
          enableLights: true,
          color: Pallets.primary,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }
}