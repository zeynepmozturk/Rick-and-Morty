import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/views/screens/favourites_view/favorites_viewmodel.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';
import 'package:rickandmorty/views/widgets/character_card_listview.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  void initState() {
    super.initState();
    context.read<FavouritesViewmodel>().getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavouritesViewmodel>();
    return Scaffold(
      appBar: const appBarWidget(title: 'Favorilerim'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: viewModel.characters.isEmpty
              ? const CircularProgressIndicator.adaptive()
              : Column(
                  children: [
                    CharacterCardListView(characters: viewModel.characters),
                  ],
                ),
        ),
      ),
    );
  }
}
