import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../events/apptheme/apptheme_event.dart';
import '../../repositories/apptheme/apptheme_repository.dart';
import '../../states/apptheme/apptheme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeRepository appThemeRepository = AppThemeRepository();
  int themeMode = 1;

  AppThemeBloc() : super(AppThemeState(themeMode: 1, isInitializing: false)) {
    on<InitAppThemeEvent>(onEventHandler);
    on<UpdateAppThemeEvent>(onEventHandler);
  }

  FutureOr<void> onEventHandler(AppThemeEvent event, Emitter emit) async {
    print("AppThemeBloc onEventHandler called for ${event.runtimeType}");
    Stream<AppThemeState> stream = mapEventToState(event);

    bool isDone = false;

    StreamSubscription streamSubscription = stream.listen(
      (AppThemeState authState) {
        emit(authState);
      },
      cancelOnError: true,
      onDone: () {
        isDone = true;
      },
    );

    while (!isDone) {
      await Future.delayed(Duration(milliseconds: 10));
    }

    streamSubscription.cancel();
  }

  @override
  Stream<AppThemeState> mapEventToState(event) async* {
    if(event is InitAppThemeEvent) {
      yield InitAppThemeState(isInitializing: true, themeMode: themeMode);

      int newThemeMode = await appThemeRepository.initTheme();
      themeMode = newThemeMode;

      yield InitAppThemeState(isInitializing: false, themeMode: themeMode);
    }
    else if(event is UpdateAppThemeEvent) {
      yield UpdateAppThemeState(isInitializing: true, themeMode: themeMode);

      bool isUpdationSuccessfull = await appThemeRepository.updateTheme(event.themeMode);
      if(isUpdationSuccessfull) {
        themeMode = event.themeMode;
      }

      yield UpdateAppThemeState(isInitializing: false, themeMode: themeMode);
    }
  }
}