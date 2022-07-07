import 'dart:async';

import 'package:ecommerce_bloc_1/bloc_implementation/main_bloc.dart';
import 'package:ecommerce_bloc_1/provider_implementation/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      runApp(BlocMyApp());
      //runApp(ProviderMyApp());
    },
    (Object exception, StackTrace stackTrace) async {

    },
  );
}
