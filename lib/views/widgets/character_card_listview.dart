import 'package:flutter/material.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/services/preferences_services.dart';
import 'package:rickandmorty/views/widgets/character_cardview.dart';
import 'package:rickandmorty/models/characters_model.dart';

class CharacterCardListView extends StatefulWidget {
  final List<CharacterModel> characters;
  final VoidCallback? onLoadMore;
  final bool loadMore;
  final VoidCallback? onFavoriteChanged;
  final bool useExternalFavoriteCheck;
  const CharacterCardListView({
    super.key,
    required this.characters,
    this.onLoadMore,
    this.loadMore = false,
    this.onFavoriteChanged,
    this.useExternalFavoriteCheck = false,
  });

  @override
  State<CharacterCardListView> createState() => _CharacterCardListViewState();
}

class _CharacterCardListViewState extends State<CharacterCardListView> {
  final _scrollController = ScrollController();
  bool isloading = true;
  List<int> _favoritedList = [];

  @override
  void initState() {
    _detectScrollBottom();
    _getFavorites();
    super.initState();
  }

  void setListLoading(bool value) {
    isloading = value;
    setState(() {});
  }

  void _getFavorites() async {
    _favoritedList = locator<PreferencesService>().getSavedCharacters();
    setListLoading(false);
    setState(() {});
  }

  void _refreshFavorites() {
    _getFavorites();
    widget.onFavoriteChanged?.call();
  }

  void _onFavoriteChanged() {
    // Favori durumu değiştiğinde listeyi yenile
    _getFavorites();
    widget.onFavoriteChanged?.call();
  }

  void _detectScrollBottom() {
    _scrollController.addListener(() {
      final maxScroll = _scrollController
          .position
          .maxScrollExtent; //ne kadar sayfa kayıyor onun değerini veriyor.
      final currentPosition = _scrollController.position.pixels; //şu anki konum
      const int delta = 200; //yaklaşması için en alta inmeden yüklemek için
      if (maxScroll - currentPosition <= delta) {
        widget.onLoadMore?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) {
      return const CircularProgressIndicator.adaptive();
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: widget.characters.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final character = widget.characters[index];
            final bool isfavorited = widget.useExternalFavoriteCheck
                ? true // Favoriler sayfasında tüm karakterler favorili
                : _favoritedList.contains(character.id);
            return Column(
              children: [
                CharacterCardView(
                  characterModel: character,
                  isfavorited: isfavorited,
                  onFavoriteChanged: _onFavoriteChanged,
                ),
                if (widget.loadMore && index == widget.characters.length - 1)
                  const CircularProgressIndicator.adaptive(),
              ],
            );
          },
        ),
      );
    }
  }
}
