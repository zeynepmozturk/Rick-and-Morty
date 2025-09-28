import 'package:get_it/get_it.dart';
import 'package:rickandmorty/services/api_service.dart';
import 'package:rickandmorty/services/preferences_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<ApiService>(
    ApiService(),
  ); //classlarımızı içine kaydediyoruz.
  locator.registerSingleton<PreferencesService>(
    PreferencesService(prefs: prefs),
  ); //classlarımızı içine kaydediyoruz.
}
