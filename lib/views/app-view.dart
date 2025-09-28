import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                );
              }
              return TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
              );
            },
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (index) {
            navigationShell.goBranch(index);
          },
          destinations: [
            _menuItem(context, 0, navigationShell.currentIndex, 'Karakterler', Icons.face),
            _menuItem(context, 1, navigationShell.currentIndex, 'Favorilerim', Icons.favorite),
            _menuItem(context, 2, navigationShell.currentIndex, 'Konumlar', Icons.location_on),
            _menuItem(context, 3, navigationShell.currentIndex, 'Bölümler', Icons.menu),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(
    BuildContext context,
    int index,
    int currentIndex,
    String label,
    IconData icon,
  ) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: currentIndex == index
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.tertiary,
      ),
      label: label,
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      title: const Text(
        'Rick and Morty',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
        ),
      ],
      iconTheme: const IconThemeData(
        color: Color(0xFF42B4CA),
      ),
    );
  }
}

