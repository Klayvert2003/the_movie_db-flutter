import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_consumer/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lançamentos',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromRGBO(3, 37, 65, 1.0),
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(3, 37, 65, 1.0))
          .copyWith(
            onPrimaryContainer: Colors.white,
            primaryContainer: const Color.fromRGBO(27, 210, 175, 1.0)
        ),
      ),
      home: const HomePage(),
    );
  }
}