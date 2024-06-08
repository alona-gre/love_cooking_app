import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/features/authentication/data/fake_auth_repository.dart';

// Import your providers and other dependencies here.

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;

    //
    //TODO final bool isHomePage = GoRouter.of(context).location == '/';
    // final String userName = user?.displayName ?? 'Guest';

    return AppBar(
      leading:
          // isHomePage  ?
          IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      //   : null,
      title: Text(user != null ? 'Hi, Username' : 'Hi'),
      centerTitle: false, // Aligns title to the start
      actions: [
        IconButton(
            key: const Key('filters'),
            icon: const Icon(Icons.tune),
            onPressed: () {
              // TODO: show modal screen
            }),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
