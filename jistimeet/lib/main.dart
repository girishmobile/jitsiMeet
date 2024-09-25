import 'package:flutter/material.dart';
import 'package:jistimeet/page/main_page.dart';
import 'package:jistimeet/page/splash_screen.dart';
import 'package:jistimeet/provider/meeting_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MeetingProvider>(create: (_) => MeetingProvider()),
      ],
      child: MaterialApp(
        title: 'Jitsi Meet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

