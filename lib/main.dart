import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:switcher/screen/home_screen.dart';
import 'package:switcher/theme/theme_extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData().lightTheme(),
      dark: ThemeData().darkTheme(),
      initial: AdaptiveThemeMode.light,
      builder: (ThemeData light, ThemeData dark) {
        return MaterialApp(
          title: 'Flutter Switcher',
          darkTheme: dark,
          theme: light,
          home: const HomeScreen(),
        );
      },
    );
  }
}
