import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_tmt/base/view/base_provider_view.dart';
import 'package:weather_tmt/provider/weather_provider.dart';
import 'package:weather_tmt/utils/styles/app_text_styles.dart';
import '../../utils/helper/image_helper.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController _searchCityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchCityController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    weatherProvider.weatherPlace = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseProviderView(
      provider: weatherProvider,
      builder: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: ImageHelper.appIcon(
                        icon: FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              ImageHelper.appIcon(
                                  icon: FontAwesomeIcons.magnifyingGlass,
                                  color: Colors.grey),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                    controller: _searchCityController,
                                    decoration: const InputDecoration(
                                        hintText: 'Input city name',
                                        border: InputBorder.none),
                                    onSubmitted: (value) {},
                                    onChanged: (value) {
                                      weatherProvider.getSearchPlace(value);
                                    }),
                              ),
                              if (_searchCityController.text.isNotEmpty)
                                InkWell(
                                    onTap: () {
                                      _searchCityController.clear();
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                    ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<WeatherProvider>(
                            builder: (_, provider, child) {
                          final weatherPlace = provider.weatherPlace;
                          if (provider.isLoadingSearchPlace) {
                            return Text(
                              'wait a minute...',
                              style: AppTextStyles.textStyle(fontSize: 16),
                            );
                          }
                          if (weatherPlace != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'CITY:',
                                  style: AppTextStyles.textStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      weatherProvider.reloadWeatherInHome();
                                    },
                                    child: Row(
                                      children: [
                                        ImageHelper.appIcon(
                                          icon: FontAwesomeIcons.locationDot,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          weatherPlace.areaName ?? '',
                                          style: AppTextStyles.textStyle(
                                              fontSize: 16),
                                        ),
                                      ],
                                    )),
                              ],
                            );
                          }
                          if (weatherPlace == null &&
                              _searchCityController.text.isNotEmpty) {
                            return Text(
                              'city not found',
                              style: AppTextStyles.textStyle(fontSize: 16),
                            );
                          }
                          return const SizedBox();
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
