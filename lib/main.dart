import 'package:flutter/material.dart';
import 'package:parsonskellogg/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightMode,
      darkTheme: darkMode,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('ParsonsKellogg'),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Theme Change',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
