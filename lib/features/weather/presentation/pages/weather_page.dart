import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibx_app/features/weather/presentation/widget/abaout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ibx_app/core/utils/padding.dart';
import 'package:ibx_app/core/utils/sizedbox.dart';
import 'package:ibx_app/core/utils/textstyle.dart';
import 'package:ibx_app/core/utils/theme.dart';
import 'package:ibx_app/features/weather/presentation/manager/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _cachedCities = [];
  bool _showSearchBox = false;

  @override
  void initState() {
    super.initState();
    _loadCachedCities();
    BlocProvider.of<WeatherBloc>(context).add(FetchCurrentCityWeather());
  }

  Future<void> _loadCachedCities() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _cachedCities = prefs.getStringList('cachedCities') ?? [];
    });
  }

  Future<void> _cacheCityName(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    _cachedCities.add(cityName);
    await prefs.setStringList('cachedCities', _cachedCities);
  }

  void _onCitySelected(String cityName) {
    _controller.text = cityName;
    BlocProvider.of<WeatherBloc>(context)
        .add(FetchWeather(countryName: cityName));
    setState(() {
      _showSearchBox = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AboutWidget(),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: XPadding.allSidePadding40,
        child: Column(
          children: [
            if (_showSearchBox) ...[
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter City Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: AppColors.primary),
                    onPressed: () {
                      final cityName = _controller.text.trim();
                      if (cityName.isNotEmpty) {
                        _cacheCityName(cityName);
                        BlocProvider.of<WeatherBloc>(context).add(
                          FetchWeather(countryName: cityName),
                        );
                      }
                    },
                  ),
                ),
              ),
              XGapHeight.h15,
              Column(
                children: [
                  Text("Recently Searched",
                      style: AppTextStyle.boldtxtInterRegular16Lightblue900),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: _cachedCities.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(
                              _cachedCities[index],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color: AppColors.primary,
                            ),
                            onTap: () => _onCitySelected(_cachedCities[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              XGapHeight.h15,
            ],
            if (!_showSearchBox) ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showSearchBox = true; // Show the search box
                  });
                },
                child: Text('Search for a City'),
              ),
            ],
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WeatherLoaded) {
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: XPadding.allSidePadding40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City: ${state.weather.cityName}',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          XGapHeight.h15,
                          Text('Temperature: ${state.weather.temperature}°K',
                              style:
                                  AppTextStyle.txtInterSemiBold18Lightgreen900),
                          XGapHeight.h10,
                          Text('Weather: ${state.weather.description}',
                              style: AppTextStyle
                                  .boldtxtInterRegular16Lightblue900),
                          XGapHeight.h20,
                        ],
                      ),
                    ),
                  );
                } else if (state is WeatherError) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.red, width: 2),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: AppColors.red),
                        XGapHeight.h10,
                        Expanded(
                          child: Text(
                            state.message,
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
