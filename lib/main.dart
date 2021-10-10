import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:themoviedb/presentation/pages/app/provider/my_app_model.dart';
import 'package:themoviedb/presentation/navigator/router.dart';
import 'package:themoviedb/theme/theme.dart';

void main() async {
  // т.к функция мейн теперь ассинхронная, необходимо добавить следующую
  // строку для корректной работы
  WidgetsFlutterBinding.ensureInitialized();
  // Передаем сюда модель
  final model = MyAppModel();
  // до запуска приложения проверяем авторизацию пользователя
  await model.checkAuth();
  runApp(MyApp(model: model));
}

class MyApp extends StatelessWidget {
  final MyAppModel model;

  const MyApp({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'themoviedb',
      localizationsDelegates: const[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const[
        Locale('ru','RU'),
        Locale('en','US')
      ],
      theme: ThemeData(
        appBarTheme: buildAppBarTheme(),
        bottomNavigationBarTheme: buildBottomNavigationBarThemeData(),
      ),
      routes: routes,
      initialRoute: Routs.initialRoute(model.isAuth),
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
