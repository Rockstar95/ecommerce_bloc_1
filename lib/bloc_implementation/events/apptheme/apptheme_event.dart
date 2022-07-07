abstract class AppThemeEvent {}

class InitAppThemeEvent extends AppThemeEvent {

}

class UpdateAppThemeEvent extends AppThemeEvent {
  int themeMode;
  UpdateAppThemeEvent(this.themeMode);
}