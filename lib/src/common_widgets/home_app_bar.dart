import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/common_widgets/collection_icon.dart';
import 'package:love_cooking_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filters_bottom_sheet.dart';
import 'package:love_cooking_app/src/routing/app_router.dart';

// Import your providers and other dependencies here.

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;

    final currentPage = ref.read(goRouterProvider);
    bool isHomePage =
        currentPage.routeInformationProvider.value.uri.path == '/';
    // final String userName = user?.displayName ?? 'Guest';

    return AppBar(
      leading: isHomePage
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )
          : null,
      title: Text(user != null ? 'Hi, Username' : 'Hi, Guest'),
      centerTitle: false,
      actions: [
        const CollectionIcon(),
        if (isHomePage || isHomePage && user != null)
          IconButton(
            key: const Key('filters'),
            icon: const Icon(Icons.tune),
            onPressed: () => showFilterBottomSheet(context),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
