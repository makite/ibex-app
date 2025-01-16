import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ibx_app/core/routes.dart';
import 'package:ibx_app/features/dashboard/presentation/manager/dashboard_bloc.dart';
import 'package:ibx_app/features/weather/presentation/manager/weather_bloc.dart';
import 'package:ibx_app/injection.dart';
import 'core/navigator_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await dotenv.load(fileName: '.env'); // Load environment variables
  configureDependencies(); // Set up dependency injection
  runApp(const MyApp()); // Run the app
}

final storage = new FlutterSecureStorage();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => DashboardBloc()),
            BlocProvider(create: (context) => WeatherBloc()),
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splashScreen,
            routes: AppRoutes.routes,
          ),
        );
      },
    );
  }
}
