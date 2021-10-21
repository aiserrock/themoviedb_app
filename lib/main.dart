import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:themoviedb/presentation/pages/app/provider/my_app_model.dart';
import 'package:themoviedb/presentation/navigator/router.dart';
import 'package:themoviedb/theme/theme.dart';

import 'data/helpers/custom_provider.dart';

void main() async {
  // т.к функция мейн теперь ассинхронная, необходимо добавить следующую
  // строку для корректной работы
  WidgetsFlutterBinding.ensureInitialized();
  // Передаем сюда модель
  final model = MyAppModel();
  // до запуска приложения проверяем авторизацию пользователя
  await model.checkAuth();
  final app = MyApp();
  final widget = Provider(model: model, child: app);
  runApp(widget);
}

class MyApp extends StatelessWidget {

  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.read<MyAppModel>(context);
    return MaterialApp(
      title: 'themoviedb',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', 'RU'), Locale('en', 'US')],
      theme: ThemeData(
        appBarTheme: buildAppBarTheme(),
        bottomNavigationBarTheme: buildBottomNavigationBarThemeData(),
      ),
      routes: routes,
      initialRoute: Routs.initialRoute(model?.isAuth == true),
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
