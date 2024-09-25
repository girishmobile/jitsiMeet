import 'package:flutter/material.dart';
import 'package:jistimeet/core/string_utils.dart';
import 'package:jistimeet/core/theme/theme.dart';

import 'package:jistimeet/page/splash_screen.dart';
import 'package:jistimeet/provider/ThemeProvider.dart';
import 'package:jistimeet/provider/meeting_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MeetingProvider>(create: (_) => MeetingProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
          builder: (context,themeProvider,child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title:appName,
              themeMode: themeProvider.themeMode,
              theme: lightMode,
              darkTheme: darkMode,

              //theme: ThemeData.light(),
              home:const SplashScreen() ,
            );
          }
      ),
    );
  }
}

