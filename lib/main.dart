import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:streams_like_a_pro/data/local/my_local_service.dart';
import 'package:streams_like_a_pro/data/my_service.dart';
import 'package:streams_like_a_pro/main_bloc.dart';
import 'package:streams_like_a_pro/ui/splash/splash_screen.dart';

class ServicesInheritedWidget extends InheritedWidget {
  const ServicesInheritedWidget({
    required this.myService,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);
  final MyService myService;

  static ServicesInheritedWidget of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<ServicesInheritedWidget>()!;

  @override
  bool updateShouldNotify(covariant ServicesInheritedWidget oldWidget) => false;
}

class ThemeInheritedWidget extends InheritedWidget {
  const ThemeInheritedWidget({
    required Widget child,
    required this.onThemeUpdated,
    required this.isThemeDark,
    Key? key,
  }) : super(child: child, key: key);

  final ValueChanged<bool> onThemeUpdated;
  final bool isThemeDark;

  void updateTheme(bool isDark) {
    onThemeUpdated(isDark);
  }

  static ThemeInheritedWidget of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<ThemeInheritedWidget>()!;

  @override
  bool updateShouldNotify(covariant ThemeInheritedWidget oldWidget) =>
      oldWidget.isThemeDark != isThemeDark;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bloc = MainBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ServicesInheritedWidget(
      myService: MyLocalService(),
      child: StreamBuilder<bool>(
          stream: bloc.streamDark,
          initialData: true,
          builder: (context, snapshot) {
            final isDark = snapshot.data!;
            return ThemeInheritedWidget(
              onThemeUpdated: (isDark) {
                bloc.onThemeUpdated(isDark);
              },
              isThemeDark: isDark,
              child: MaterialApp(
                title: 'Streams like a Pro',
                theme: isDark ? ThemeData.dark() : ThemeData.light(),
                home: const SplashScreen(),
              ),
            );
          }),
    );
  }
}
