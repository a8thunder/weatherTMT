import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_tmt/base/view/base_provider_view.dart';
import 'package:weather_tmt/provider/weather_provider.dart';
import '../../utils/com_utils.dart';
import '../../utils/helper/image_helper.dart';
import '../../utils/styles/app_text_styles.dart';
import '../seach_location/search_location_screen.dart';
import 'widgets/week_forecast_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cityName = "Ho Chi Minh"; //city name
  int currTemp = 30; // current temperature
  int maxTemp = 30; // today max temperature
  int minTemp = 2; // today min temperature

  @override
  void initState() {
    weatherProvider.getDataWeatherInHome();
    super.initState();
  }

  Widget cityNameWidget(Size size) => Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.01,
        ),
        child: Align(
          child: Text(
            weatherProvider.weatherToday?.areaName ?? '',
            style: AppTextStyles.textStyle(
              color: Colors.white,
              fontSize: size.height * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseProviderView(
      provider: weatherProvider,
      builder: Scaffold(
        body: Center(
          child: Container(
            height: size.height,
            width: size.height,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Consumer<WeatherProvider>(builder: (_, provider, child) {
              return SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.01,
                              horizontal: size.width * 0.05,
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchLocationScreen(),
                                  ),
                                ),
                                child: ImageHelper.appIcon(
                                    icon: FontAwesomeIcons.magnifyingGlass),
                              ),
                            ),
                          ),
                          cityNameWidget(size),
                          ...weatherToday(size),
                          WeekForecastWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  List<Widget> weatherToday(Size size) {
    return [
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.005,
        ),
        child: Align(
          child: Text(
            'Today', //day
            style: AppTextStyles.textStyle(
              color: Colors.white54,
              fontSize: size.height * 0.035,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.03,
        ),
        child: Align(
          child: Text(
            '${weatherProvider.weatherToday?.temperature?.celsius?.round() ?? 0}˚C', //curent temperature
            style: AppTextStyles.textStyle(
              color: currTemp <= 0
                  ? Colors.blue
                  : currTemp > 0 && currTemp <= 15
                      ? Colors.indigo
                      : currTemp > 15 && currTemp < 30
                          ? Colors.deepPurple
                          : Colors.pink,
              fontSize: size.height * 0.13,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
        child: CommonUtils.appDivider,
      ),
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.005,
        ),
        child: Align(
          child: Text(
            weatherProvider.weatherToday?.weatherMain ?? '', // weather
            style: AppTextStyles.textStyle(
              color: Colors.white54,
              fontSize: size.height * 0.03,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.03,
          bottom: size.height * 0.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${weatherProvider.weatherToday?.tempMin?.celsius?.round() ?? 0}˚C', // min temperature
              style: AppTextStyles.textStyle(
                color: minTemp <= 0
                    ? Colors.blue
                    : minTemp > 0 && minTemp <= 15
                        ? Colors.indigo
                        : minTemp > 15 && minTemp < 30
                            ? Colors.deepPurple
                            : Colors.pink,
                fontSize: size.height * 0.03,
              ),
            ),
            Text(
              '/',
              style: AppTextStyles.textStyle(
                color: Colors.white54,
                fontSize: size.height * 0.03,
              ),
            ),
            Text(
              '${weatherProvider.weatherToday?.tempMax?.celsius?.round() ?? 0}˚C', //max temperature
              style: AppTextStyles.textStyle(
                color: maxTemp <= 0
                    ? Colors.blue
                    : maxTemp > 0 && maxTemp <= 15
                        ? Colors.indigo
                        : maxTemp > 15 && maxTemp < 30
                            ? Colors.deepPurple
                            : Colors.pink,
                fontSize: size.height * 0.03,
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
