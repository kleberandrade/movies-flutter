import 'package:flutter/material.dart';
import 'core/theme_app.dart';
import 'pages/movie_page.dart';

import 'core/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: themeApp,
      home: MoviePage(),
    );
  }
}
