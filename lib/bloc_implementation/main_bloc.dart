
import 'package:ecommerce_bloc_1/bloc_implementation/states/apptheme/apptheme_state.dart';
import 'package:ecommerce_bloc_1/bloc_implementation/ui/home_screen/bloc_home_screen.dart';
import 'package:ecommerce_bloc_1/utils/MyPrint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/AppTheme.dart';
import 'blocs/apptheme/app_theme_bloc.dart';
import 'blocs/products/products_bloc.dart';
import 'events/apptheme/apptheme_event.dart';

class BlocMyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MyPrint.printOnConsole("MyApp called");
    // MySize().init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppThemeBloc>(create: (BuildContext context) => AppThemeBloc(),),
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
  late AppThemeBloc appThemeBloc;

  int themeMode = 1;

  @override
  void initState() {
    super.initState();
    appThemeBloc = BlocProvider.of<AppThemeBloc>(context, listen: false);
    appThemeBloc.add(InitAppThemeEvent());
  }

  @override
  Widget build(BuildContext context) {
    MainApp.mainContext = context;
    MyPrint.printOnConsole("Main called");

    if(isFirst) {
      isFirst = false;
    }

    return BlocConsumer<AppThemeBloc, AppThemeState>(
      bloc: appThemeBloc,
      listener: (BuildContext context, AppThemeState appThemeState) {
        if((appThemeState is InitAppThemeState && !appThemeState.isInitializing) || (appThemeState is UpdateAppThemeState && !appThemeState.isInitializing)) {
          themeMode = appThemeState.themeMode;
        }
      },
      builder: (BuildContext context, AppThemeState appThemeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(themeMode),
          home: BlocHomeScreen(isLightTheme: appThemeBloc.themeMode == AppTheme.themeLight),
        );
      },
    );
  }
}
