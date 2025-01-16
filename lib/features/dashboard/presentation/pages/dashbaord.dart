import 'package:flutter/material.dart';
import 'package:ibx_app/features/weather/presentation/pages/weather_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
        children: [
          WeatherPage(),
        ],
      ),
    );
  }
}
