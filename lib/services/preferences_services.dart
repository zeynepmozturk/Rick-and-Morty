import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final SharedPreferences prefs;

  PreferencesService({required this.prefs});
  final String _characterkey = 'characters';

  void storeCharacters(List<String> characters) async {
    await prefs.setStringList(_characterkey, characters);
  }

  void saveCharacter(int id) async {
    final _charactersList = prefs.getStringList(_characterkey) ?? [];
    _charactersList.add(id.toString());
    storeCharacters(_charactersList);
  }

  void deleteCharacter(int id) async {
    final _charactersList = prefs.getStringList(_characterkey) ?? [];
    _charactersList.remove(id.toString());
    storeCharacters(_charactersList);
  }

  List<int> getSavedCharacters() {
    final _charactersList = prefs.getStringList(_characterkey) ?? [];
    return _charactersList.map((e) => int.parse(e)).toList();
  }
}
