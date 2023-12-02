import 'package:weather/weather.dart';
import 'package:weather_tmt/service/position_service.dart';
import '../base/provider/base_provider.dart';
import '../respository/weather/weather_repository.dart';
import '../utils/helper/app_log_helper.dart';

final WeatherProvider weatherProvider = WeatherProvider();

class WeatherProvider extends BaseProvider {
  final weatherRepository = WeatherRepository();
  Weather? weatherToday;
  Weather? weatherPlace;
  List<Weather> weatherForecast = [];
  //Loading
  bool isLoadingSearchPlace = false;

  Future getDataWeatherInHome({
    double? lat,
    double? long,
  }) async {
    try {
      loading();
      await getWeather(lat: lat, long: long);
      await getWeatherForecast(lat: lat, long: long);
      dismissLoading();
    } catch (e) {
      dismissLoading();
      AppLogger.error(
          'Error WeatherProvider -> getDataWeatherInHome: ${e.toString()}');
    }
  }

  Future getWeather({
    double? lat,
    double? long,
  }) async {
    try {
      weatherToday = await weatherRepository.getWeather(
        lat: lat ?? positionService.lat,
        long: long ?? positionService.lng,
      );
      AppLogger.info(weatherToday.toString());
      notify();
    } catch (e) {
      AppLogger.error('Error WeatherProvider -> getWeather: ${e.toString()}');
    }
  }

  Future getWeatherForecast({
    double? lat,
    double? long,
  }) async {
    try {
      final data = await weatherRepository.getWeatherForecast(
        lat: lat ?? positionService.lat,
        long: long ?? positionService.lng,
      );
      if (data.isEmpty) return;
      int dateNow = DateTime.now().day;
      for (var item in data) {
        final date = item.date!.day;
        if (date != dateNow) {
          if (!weatherForecast.any((element) => element.date!.day == date)) {
            weatherForecast.add(item);
          }
        }
      }
      AppLogger.info(weatherForecast.toString());
      notify();
    } catch (e) {
      AppLogger.error(
          'Error WeatherProvider -> getWeatherForecast: ${e.toString()}');
    }
  }

  Future getSearchPlace(String city) async {
    try {
      setLoadingSearch(true);
      weatherPlace = await weatherRepository.searchWeatherByCity(city: city);
      AppLogger.info(weatherPlace.toString());
      setLoadingSearch(false);
      notify();
    } catch (e) {
      AppLogger.error(
          'Error WeatherProvider -> getSearchPlace: ${e.toString()}');
      setLoadingSearch(false);
    }
  }

  Future reloadWeatherInHome() async {
    resetData();
    await getDataWeatherInHome(
        lat: weatherPlace?.latitude, long: weatherPlace?.longitude);
  }

  void setLoadingSearch(bool value) {
    isLoadingSearchPlace = value;
    notify();
  }

  void resetData() {
    weatherToday = null;
    weatherForecast = [];
  }
}
