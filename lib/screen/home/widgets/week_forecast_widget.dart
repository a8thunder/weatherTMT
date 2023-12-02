import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_tmt/provider/weather_provider.dart';

import '../../../utils/com_utils.dart';
import '../../../utils/styles/app_text_styles.dart';
import 'forecast_widget.dart';

class WeekForecastWidget extends StatelessWidget {
  const WeekForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white.withOpacity(0.05),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                  left: size.width * 0.03,
                ),
                child: Text(
                  '5-day forecast',
                  style: AppTextStyles.textStyle(
                    color: Colors.white,
                    fontSize: size.height * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            CommonUtils.appDivider,
            Padding(
              padding: EdgeInsets.all(size.width * 0.005),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: weatherProvider.weatherForecast.length,
                itemBuilder: (context, index) {
                  final item = weatherProvider.weatherForecast[index];
                  return ForecastWidget(
                    time: DateFormat('E')
                        .format(item.date ?? DateTime.now()), //day
                    minTemp:
                        item.tempMin?.celsius?.round() ?? 0, //min temperature
                    maxTemp:
                        item.tempMax?.celsius?.round() ?? 0, //max temperature
                    weatherIcon: FontAwesomeIcons.cloud, //weather icon
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
