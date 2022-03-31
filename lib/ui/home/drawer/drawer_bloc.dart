import 'dart:async';

enum Pages {
  page1,
  page2,
}

class DrawerBloc {
  final _controllerPages = StreamController<Pages>();
  Stream<Pages> get streamPages => _controllerPages.stream;

  void navigateToPage(Pages page) {
    // TODO: more logic
    _controllerPages.add(page);
  }

  void destroy() {
    _controllerPages.close();
  }
}
