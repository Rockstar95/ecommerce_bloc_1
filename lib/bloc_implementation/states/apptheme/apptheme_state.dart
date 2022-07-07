class AppThemeState {
  bool isInitializing = false;
  int themeMode = 1;

  AppThemeState({this.isInitializing = false, this.themeMode = 1});
}

class InitAppThemeState extends AppThemeState {
  bool isInitializing = false;
  int themeMode = 1;

  InitAppThemeState({this.isInitializing = false, this.themeMode = 1}) : super(themeMode: themeMode, isInitializing: isInitializing);
}

class UpdateAppThemeState extends AppThemeState {
  bool isInitializing = false;
  int themeMode = 1;

  UpdateAppThemeState({this.isInitializing = false, this.themeMode = 1}) : super(themeMode: themeMode, isInitializing: isInitializing);
}