import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:moneytronic/providers/multiprovider.dart';
import 'package:moneytronic/utils/DeviceUtil.dart';
import 'package:moneytronic/utils/constants/Themes/colors.dart';
import 'package:moneytronic/utils/constants/text.dart';
import 'package:moneytronic/views/welcomeScreen.dart';

import 'config/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  DeviceUtils.initDeviceInfo();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: ProviderWidget.blockProviders(),
      child: ScreenUtilInit(
          designSize: const Size(430, 954),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.white,
                primarySwatch: Colors.blue,
                // useMaterial3: true,
                ),
              home: splashScreen(),
            );
          }
      ),
    );
  }

  Widget splashScreen() {
    return darkStatusBar(
        AnimatedSplashScreen(
          duration: 3500,
          splash: Image.asset(
            "assets/pictures/MFG.png", width: 350.w, height: 87.h,),
          //splashIconSize: 852.h,
          centered: true,
          nextScreen: const WelcomeScreen(),
          // splashTransition: SplashTransition.fadeTransition,
          // pageTransitionType: PageTransitionType.rightToLeft,
          backgroundColor: AppColors.white,
        )
    );
  }

  AnnotatedRegion<SystemUiOverlayStyle> darkStatusBar(child) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark
      ),
      child: child,
    );
  }
}

