import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hayat_eg/features/presentation/page/login/Login.dart';
import 'package:hayat_eg/features/presentation/page/on_boarding/on_bording_layout.dart';
import 'package:hayat_eg/injection_container.dart';
import 'package:hayat_eg/layout/HayatLayout/hayat_layout.dart';
import 'package:hayat_eg/shared/BlocObserver.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/DioHelper.dart';
import 'package:hayat_eg/shared/network/local/Cash_helper/cash_helper.dart';
import 'package:hayat_eg/styles/thems.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await Cash_helper.init();
  Widget? widget;
  bool? onBoarding = Cash_helper.getData(key: 'onBoarding');
  String? token = Cash_helper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const HayatLayoutScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  // widget = const TestScreen();
  runApp(HayatApp(
    startWidget: widget,
  ));
}

class HayatApp extends StatelessWidget {
  Widget startWidget;

  HayatApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThem,
      darkTheme: darkThem,
      themeMode: ThemeMode.light,
      home: startWidget,
    );
  }
}
