import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_cooking_app/src/common_widgets/alert_dialogs.dart';
import 'package:love_cooking_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:love_cooking_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filtering_controller/category_filtering_controller.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filtering_controller/diet_filtering_controller.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:love_cooking_app/src/routing/app_router.dart';
import 'package:love_cooking_app/src/utils/async_value_ui.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final user = ref.watch(authStateChangesProvider).value;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              accountName: Text(user?.email ?? 'Guest'),
              accountEmail: Text(user?.email ?? ''),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.grey,
              )),
          ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(user != null ? 'Profile' : 'Log In'),
              onTap: () => user != null
                  ? {
                      Scaffold.of(context).closeDrawer(),
                      context.goNamed(AppRoute.account.name),
                    }
                  : {
                      Scaffold.of(context).closeDrawer(),
                      context.goNamed(AppRoute.signIn.name),
                    }),
          if (user != null)
            ListTile(
              leading: const Icon(Icons.card_membership),
              title: Text('Membership'.hardcoded),
              onTap: () => showNotImplementedAlertDialog(context: context),
            ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text('Settings'.hardcoded),
            onTap: () => showNotImplementedAlertDialog(context: context),
          ),
          ListTile(
            leading: const Icon(Icons.new_releases),
            title: Text("What's new".hardcoded),
            onTap: () => showNotImplementedAlertDialog(context: context),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text('Help'.hardcoded),
            onTap: () => showNotImplementedAlertDialog(context: context),
          ),
          if (user != null)
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Log out'.hardcoded),
              onTap: () async {
                final logout = await showAlertDialog(
                  context: context,
                  title: 'Are you sure?'.hardcoded,
                  cancelActionText: 'Cancel'.hardcoded,
                  defaultActionText: 'Logout'.hardcoded,
                );
                if (logout == true) {
                  ref
                      .read(accountScreenControllerProvider.notifier)
                      .signOut()
                      .then(
                        (_) => Scaffold.of(context).closeDrawer(),
                      );
                  // trigger the build method of filtering controllers
                  await ref
                      .read(categoryFilteringControllerProvider.notifier)
                      .reloadState();
                  await ref
                      .read(dietFilteringControllerProvider.notifier)
                      .reloadState();
                }
              },
            )
        ],
      ),
    );
  }
}
