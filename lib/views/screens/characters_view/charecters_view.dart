import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/views/screens/characters_view/character_viewmodel.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';
import 'package:rickandmorty/views/widgets/character_card_listview.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();
    context.read<CharacterViewModel>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharacterViewModel>();
    return Scaffold(
      appBar: const appBarWidget(title: 'Rick and Morty'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              _searchInputWidget(context, viewModel: viewModel),
              viewModel.charactersModel == null
                  ? const CircularProgressIndicator.adaptive()
                  : CharacterCardListView(
                      characters: viewModel.charactersModel!.characters,
                      onLoadMore: () => viewModel.getCharactersMore(),
                      loadMore: viewModel.loadMore,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInputWidget(
    BuildContext context, {
    required CharacterViewModel viewModel,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextFormField(
        //rick and morty altındaki kutunun görünümü
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) => viewModel.getCharactersByName(value),
        decoration: InputDecoration(
          labelText: 'Karakterlerde Ara',
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search), //sol kısma ikon eklemek için prefix
          suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ),
      ),
    );
  }
}
