import 'package:flutter/material.dart';
import 'package:themoviedb/presentation/navigator/router.dart';
import 'package:themoviedb/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: buildAppBarTheme(),
        bottomNavigationBarTheme: buildBottomNavigationBarThemeData(),
      ),
      routes: routes,
      initialRoute: Routs.AUTH,
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
