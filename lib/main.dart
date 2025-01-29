import 'package:earthquake_protection/home.dart';
import 'package:earthquake_protection/providers/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
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
      home: const Home(),
    );
  }
}
