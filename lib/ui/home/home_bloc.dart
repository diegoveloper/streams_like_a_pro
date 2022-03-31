import 'dart:async';

import 'package:streams_like_a_pro/data/my_service.dart';
import 'package:streams_like_a_pro/domain/city.dart';

class HomeBloc {
  HomeBloc(this.myService);

  final MyService myService;
  final _controllerGridView = StreamController<bool>.broadcast();
  Stream<bool> get streamGridView => _controllerGridView.stream;

  final _controllerDetails = StreamController<City>();
  Stream<City> get streamDetails => _controllerDetails.stream;

  final _controllerCities = StreamController<List<City>>();
  Stream<List<City>> get streamCities => _controllerCities.stream;

  void init() {
    _controllerGridView.add(false);
    loadCities();
  }

  Future<void> loadCities() async {
    final result = await myService.getCities();
    _controllerCities.add(result);
  }

  void onChangeView(bool isGridView) {
    _controllerGridView.add(isGridView);
  }

  Future<void> onCitySelected(City city) async {
    myService.logAnalytics('City: ${city.name}');
    _controllerDetails.add(city);
  }

  void dispose() {
    _controllerGridView.close();
    _controllerDetails.close();
    _controllerCities.close();
  }
}
