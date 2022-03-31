import 'dart:async';

class MainBloc {
  final _controllerDark = StreamController<bool>();
  Stream<bool> get streamDark => _controllerDark.stream;

  void onThemeUpdated(bool isDark) {
    _controllerDark.add(isDark);
  }

  void dispose() {
    _controllerDark.close();
  }
}
