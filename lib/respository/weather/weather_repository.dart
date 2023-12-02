import 'package:weather/weather.dart';
import 'package:weather_tmt/constant.dart';
import '../../utils/helper/app_log_helper.dart';

class WeatherRepository {
  WeatherFactory weatherFactory = WeatherFactory(Constant.OPEN_WEATHER_KEY);
  Future<Weather?> getWeather({
    double? lat,
    double? long,
  }) async {
    try {
      Weather weather =
          await weatherFactory.currentWeatherByLocation(lat ?? 0.0, long ?? 00);
      return weather;
    } catch (e) {
      AppLogger.error('Error getWeather: ${e.toString()}');
      return null;
    }
  }

  Future<List<Weather>> getWeatherForecast({
    double? lat,
    double? long,
  }) async {
    try {
      List<Weather> listWeatherForecast = await weatherFactory
          .fiveDayForecastByLocation(lat ?? 0.0, long ?? 00);

      return listWeatherForecast;
    } catch (e) {
      AppLogger.error('Error getWeatherForecast: ${e.toString()}');
      return [];
    }
  }

  Future<Weather?> searchWeatherByCity({
    required String city,
  }) async {
    try {
      Weather weather = await weatherFactory.currentWeatherByCityName(city);
      return weather;
    } catch (e) {
      AppLogger.error('Error searchWeatherByCity: ${e.toString()}');
      return null;
    }
  }
}
