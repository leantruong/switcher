import 'package:flutter/material.dart';

extension ThemeDataExt on ThemeData {
  ThemeData lightTheme() => ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      );
  ThemeData darkTheme() => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[850],
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
          elevation: 0,
          titleTextStyle:
              const TextStyle(color: Colors.tealAccent, fontSize: 20),
          iconTheme: const IconThemeData(color: Colors.tealAccent),
        ),
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.tealAccent,
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.tealAccent,
        ),
      );
}
