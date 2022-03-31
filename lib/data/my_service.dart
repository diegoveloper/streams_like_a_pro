import 'package:streams_like_a_pro/domain/city.dart';

abstract class MyService {
  Future<List<City>> getCities();
  Future<void> logAnalytics(String event);
}
