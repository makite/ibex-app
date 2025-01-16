import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibx_app/core/routes.dart';
import 'package:ibx_app/core/utils/image_constant.dart';
import 'package:ibx_app/core/utils/textstyle.dart';
import 'package:ibx_app/core/utils/theme.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
      pages: [
        PageViewModel(
            title: 'Weather Forecast App',
            body:
                'With this app, you can get real-time weather forecasts and updates.',
            image: buildImage(AppImages.weatherImage),
            decoration: getPageDecoration()),
        PageViewModel(
            title: 'Weather Forecast App',
            body:
                'Enjoy accurate weather information tailored to your location.',
            image: buildImage(AppImages.weatherImage),
            decoration: getPageDecoration()),
      ],
      done: InkWell(
        child:
            Text('Get Started', style: AppTextStyle.txtInterSemiBold14Primary),
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.homePage);
        },
      ),
      onDone: () {},
      next: Icon(Icons.arrow_forward, color: AppColors.primary),
      showNextButton: true,
      showBackButton: false,
      showSkipButton: true,
      dotsDecorator: getDotDecoration(),
      onChange: (index) {
        print('page$index selected');
      },
      skip: Text('Skip', style: AppTextStyle.txtInterSemiBold14Primary),
    ));
  }

  Widget buildImage(String Path) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 30.h, 0, 0),
      child: Center(
        child: Image.asset(
          Path,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: AppTextStyle.txtInterBold28Primary,
        imagePadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
        pageColor: AppColors.whiteA700,
      );

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
        color: AppColors.black9003f,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        activeColor: AppColors.primary);
  }
}
