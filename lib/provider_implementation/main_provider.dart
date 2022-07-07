import 'package:ecommerce_bloc_1/provider_implementation/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/AppTheme.dart';
import '../utils/MyPrint.dart';
import 'ui/home_screen/provider_home_screen.dart';

class ProviderMyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MyPrint.printOnConsole("MyApp called");
    // MySize().init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>(create: (_) => ProductsProvider()),
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
      theme: AppTheme.getThemeFromThemeMode(AppTheme.themeLight),
      home: const ProviderHomeScreen(),
    );
  }
}
