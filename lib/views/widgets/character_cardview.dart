import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/app/router.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/preferences_services.dart';
import 'package:rickandmorty/views/screens/characters_view/character_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterCardView extends StatefulWidget {
  final CharacterModel characterModel;
  bool isfavorited;
  final VoidCallback? onFavoriteChanged;
  CharacterCardView({
    super.key,
    required this.characterModel,
    this.isfavorited = false,
    this.onFavoriteChanged,
  });

  @override
  State<CharacterCardView> createState() => _CharacterCardViewState();
}

class _CharacterCardViewState extends State<CharacterCardView> {
  void favoritecharacter() {
    final isCurrentlyFavorited = widget.isfavorited;
    if (isCurrentlyFavorited) {
      locator<PreferencesService>().deleteCharacter(widget.characterModel.id);
    } else {
      locator<PreferencesService>().saveCharacter(widget.characterModel.id);
    }
    widget.onFavoriteChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        AppRoutes.characterProfile,
        extra: widget.characterModel,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      widget.characterModel.image,
                      height: 100,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.characterModel.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        _infowidget(
                          type: 'Köken',
                          value: widget.characterModel.location.name,
                        ),
                        const SizedBox(height: 1),
                        _infowidget(
                          type: 'Durum',
                          value:
                              '${widget.characterModel.status} - ${widget.characterModel.species}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                favoritecharacter();
              },
              icon: Icon(
                widget.isfavorited ? Icons.bookmark : Icons.bookmark_border,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _infowidget({required String type, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //sağdan sola hizalama
      children: [
        Text(type, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
        Text(value, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
