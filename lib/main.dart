import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:weather_tmt/screen/home/home_screen.dart';

import 'provider/weather_provider.dart';
import 'service/position_service.dart';
import 'utils/styles/app_text_styles.dart';

void main() {
  _configLoading();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<WeatherProvider>(
      create: (context) => WeatherProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: positionService.determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return Scaffold(
            body: Container(
              color: Colors.black,
              child: Center(
                  child: Text(
                'QUERY CURRENT LOCATION',
                style: AppTextStyles.textStyle(fontSize: 20),
              )),
            ),
          );
        },
      ),
    );
  }
}

void _configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 8000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..maskType = EasyLoadingMaskType.black
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..userInteractions = false;
}
