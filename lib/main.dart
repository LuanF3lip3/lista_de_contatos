import 'package:flutter/material.dart';
import 'package:udemy_lista_de_contatos/modulos/contact_list/contact_list_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: const ContactListPage(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primaryColor: const Color(0xFF820BD1),
        hintColor: const Color(0xFF000000),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF820BD1),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF820BD1),
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.black,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF000000),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
        ),
        colorScheme: const ColorScheme.light(
          background: Color(0xFF000000),
          primary: Color(0xFFeeeeee),
        ),
        buttonTheme: const ButtonThemeData(
          highlightColor: Color(0xFFe1e1e1),
          buttonColor: Color(0xFFe1e1e1),
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          labelMedium: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
          titleMedium: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          titleSmall: TextStyle(
            color: Colors.black54,
            fontSize: 16.0,
          ),
        ),
      ),
    ),
  );
}
