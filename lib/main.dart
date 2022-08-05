import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_abdallah/cubit/cubit.dart';
import 'package:shop_app_abdallah/cubit/states.dart';
import 'package:shop_app_abdallah/sereen/shop_layout/shop_layout.dart';
import 'package:shop_app_abdallah/shared/component.dart';
import 'file:///S:/Games/flutter_project/shop_app_abdallah/lib/sereen/login/login.dart';
import 'package:shop_app_abdallah/shared/network/local/cash_helper.dart';
import 'package:shop_app_abdallah/shared/network/remote.dart';
import 'package:shop_app_abdallah/shared/themes.dart';

import 'sereen/on_boarding/on_boarding_screen.dart';

main() async {
  //بيتاكد ان كل حاجه هنا فى الميثود خلصت وبعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  bool onBoarding = CachHelper.getData(key: 'onBoarding');
  print('onBoarding is $onBoarding');
  token = CachHelper.getData(key: 'token');
  print('token is $token');
  Widget widget;

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    onBoarding: onBoarding,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Widget startWidget;

  MyApp({
    this.onBoarding,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopLoginCubit, Shopstate>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}

//onBoarding ? LoginScreen() : OnBoardingScreen(),

//startWidget

//ShopLayout(),
