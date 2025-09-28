//state yönetimi yapacaz yani görünüm modeli
import 'package:flutter/material.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/api_service.dart';

class CharacterViewModel extends ChangeNotifier {
  // api ya istek atacak kodu yazıyoruz.
  final _apiService = locator<ApiService>();
  CharactersModel? _charactersModel;
  CharactersModel? get charactersModel => _charactersModel;

  void clearCharacters() {
    _charactersModel = null;
    notifyListeners();
  }

  void getCharacters() async {
    _charactersModel = await _apiService.getCharacters();
    notifyListeners();
  }

  //karakter modulunu view modulle baglamamız lazım.
  bool loadMore = false;
  int currentPageIndex = 1;
  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  }

  void getCharactersMore() async {
    //eğerki zaten yükleniyorsa tekrar istek atma
    if (loadMore) {
      return;
    }
    //eğer ki son sayfa ise tekrar istek atma
    if (_charactersModel!.info!.pages == currentPageIndex) return;
    setLoadMore(true);
    final data = await _apiService.getCharacters(
      url: _charactersModel?.info?.next,
    );
    setLoadMore(false);

    currentPageIndex++;

    // Create a new CharactersModel with updated info and combined characters
    final updatedCharacters = List<CharacterModel>.from(
      _charactersModel!.characters,
    );
    updatedCharacters.addAll(data.characters);

    _charactersModel = CharactersModel(
      characters: updatedCharacters,
      info: data.info,
    );

    notifyListeners();
  }

  void getCharactersByName(String name) async {
    clearCharacters();
    notifyListeners();
    _charactersModel = await _apiService.getCharacters(args: {'name': name});
    notifyListeners();
  }
}
