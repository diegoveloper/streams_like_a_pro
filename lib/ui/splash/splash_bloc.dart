import 'dart:async';

class SplashBloc {
  final _controller = StreamController<double>()..add(45);
  Stream<double> get sizeStream => _controller.stream;

  Future<void> startSplashAnimation(double newSize) async {
    await Future.delayed(const Duration(seconds: 1));
    _controller.add(newSize);
  }

  void dispose() {
    _controller.close();
  }
}
