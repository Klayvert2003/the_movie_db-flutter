import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_db_consumer/repositories/movie_repository_impl.dart';
import 'package:movie_db_consumer/services/http_manager.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => Dio()),
        Provider(create: (context) => HttpManager(dio: context.read())),
        Provider(
            create: (context) =>
                MovieRepositoryImpl(httpManager: context.read()))
      ],
      child: const App(),
    ),
  );
}
