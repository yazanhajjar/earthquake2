import 'package:earthquake_protection/firebase_options.dart';
import 'package:earthquake_protection/home.dart';
import 'package:earthquake_protection/models/storage.dart';
import 'package:earthquake_protection/providers/auth.dart';
import 'package:earthquake_protection/providers/light.dart';
import 'package:earthquake_protection/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.initializeDefaults();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission();


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    
    // print('Got a message while in the foreground!');
    // print('Message data: ${message.data}');

    if (message.notification != null) {
      // print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // print('Message clicked!');
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('Handling a background message: ${message.messageId}');
}



class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool mode = ref.watch(lightProvider);

    ThemeData darkmode = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.grey[800]!,
          onPrimary: Colors.black,
          secondary: Colors.black54,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white70,
          surface: Colors.greenAccent,
          onSurface: Colors.white),
      useMaterial3: true,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: mode
          ? darkmode
          : ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 106, 249, 128)),
              useMaterial3: true,
            ),
      home: ref.watch(loginProvider) == true ? const Home() : Login(),
    );
  }
}
