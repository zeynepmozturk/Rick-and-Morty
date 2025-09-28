import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/models/episode_model.dart';
import 'package:rickandmorty/models/location_model.dart';
import 'package:rickandmorty/views/app_view.dart';
import 'package:rickandmorty/views/screens/character_profile_view/character_profile_view.dart';
import 'package:rickandmorty/views/screens/character_profile_view/character_profile_viewmodel.dart';
import 'package:rickandmorty/views/screens/characters_view/character_viewmodel.dart';
import 'package:rickandmorty/views/screens/characters_view/charecters_view.dart';
import 'package:rickandmorty/views/screens/favourites_view/favorites_viewmodel.dart';
import 'package:rickandmorty/views/screens/favourites_view/favourites_view.dart';
import 'package:rickandmorty/views/screens/locations_view/location_viewmodel.dart';
import 'package:rickandmorty/views/screens/locations_view/locations_view.dart';
import 'package:rickandmorty/views/screens/residents_view/esident_viewmodel.dart';
import 'package:rickandmorty/views/screens/residents_view/resident_view.dart';
import 'package:rickandmorty/views/screens/section_characters_view/section_characters_view.dart';
import 'package:rickandmorty/views/screens/section_characters_view/section_characters_viewmodel.dart';
import 'package:rickandmorty/views/screens/sections_view/sections_view.dart';
import 'package:rickandmorty/views/screens/sections_view/sections_viewmodel.dart';

final _routerKey = GlobalKey<NavigatorState>();
final _shellNavigatorCharactersKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellCharacters',
);
final _shellNavigatorFavouritesKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellFavourites',
);
final _shellNavigatorLocationsKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellLocations',
);
final _shellNavigatorSectionsKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellSections',
);

class AppRoutes {
  AppRoutes._();
  static const String characters = '/';
  static const String favourites = '/favourites';
  static const String locations = '/locations';
  static const String sections = '/sections';
  static const String characterProfile = '/characterProfile';

  static const String residentsRoute = 'residents';
  static const String residents = '/locations/residents';

  static const String sectionCharactersRoute = 'characters';
  static const String sectionCharacters = '/sections/characters';
}

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.characters,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppView(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.characters,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => CharacterViewModel(),
                child: CharactersView(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.characterProfile,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => CharacterProfileViewmodel(),
                    child: CharacterProfileView(
                      characterModel: state.extra as CharacterModel,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Diğer branch’ler için de routes eklemelisin,
        // aksi takdirde navigationShell.goBranch(index) crash yapar.
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.favourites,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => FavouritesViewmodel(),
                child: const FavouritesView(),
              ),
            ),
          ],
        ),
        // Diğer branch’ler için de routes eklemelisin,
        // aksi takdirde navigationShell.goBranch(index) crash yapar.
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLocationsKey,
          routes: [
            GoRoute(
              path: AppRoutes.locations,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => LocationViewmodel(),
                child: const LocationsView(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.residentsRoute,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => ResidentViewmodel(),
                    child: ResidentsView(
                      locationItem: state.extra as LocationItem,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Diğer branch’ler için de routes eklemelisin,
        // aksi takdirde navigationShell.goBranch(index) crash yapar.
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSectionsKey,
          routes: [
            GoRoute(
              path: AppRoutes.sections,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => SectionsViewmodel(),
                child: const SectionsView(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.sectionCharactersRoute,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => SectionCharactersViewmodel(),
                    child: SectionCharactersView(
                      episodeModel: state.extra as EpisodeModel,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
