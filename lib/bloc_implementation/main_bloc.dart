import 'package:ecommerce_bloc_1/bloc_implementation/ui/home_screen/bloc_home_screen.dart';
import 'package:ecommerce_bloc_1/utils/MyPrint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/AppTheme.dart';
import 'blocs/products/products_bloc.dart';

class BlocMyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MyPrint.printOnConsole("MyApp called");
    // MySize().init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(create: (BuildContext context) => ProductsBloc(),),
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  static late BuildContext mainContext;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isFirst = true;

  int themeMode = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainApp.mainContext = context;
    MyPrint.printOnConsole("Main called");

    if(isFirst) {
      isFirst = false;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getThemeFromThemeMode(themeMode),
      home: BlocHomeScreen(isLightTheme: themeMode == AppTheme.themeLight),
    );
  }
}
