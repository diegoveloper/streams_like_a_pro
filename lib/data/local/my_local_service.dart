// ignore_for_file: avoid_print

import 'package:flutter/services.dart';
import 'package:streams_like_a_pro/data/my_service.dart';
import 'package:streams_like_a_pro/domain/city.dart';

class MyLocalService implements MyService {
  @override
  Future<List<City>> getCities() async {
    print('loading cities...');
    await Future.delayed(const Duration(seconds: 2));
    final data = await rootBundle.loadString('assets/data.json');
    return cityFromJson(data);
  }

  @override
  Future<void> logAnalytics(String event) async {
    print('Logging analytics ... <$event>');
  }
}
