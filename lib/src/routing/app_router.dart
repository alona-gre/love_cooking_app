import 'package:love_cooking_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:love_cooking_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:love_cooking_app/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:love_cooking_app/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:love_cooking_app/src/features/collection/presentation/collection/collection_screen.dart';
import 'package:love_cooking_app/src/features/recipes/presentation/recipe_screen/recipe_screen.dart';
import 'package:love_cooking_app/src/features/recipes/presentation/recipes_list/recipes_home_screen.dart';
import 'package:love_cooking_app/src/routing/go_router_refresh_stream.dart';
import 'package:love_cooking_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  recipe,
  collection,
  account,
  signIn,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/signIn') {
          return '/';
        }
      } else {
        if (path == '/account') {
          return '/';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const RecipesHomeScreen(),
        routes: [
          GoRoute(
            path: 'recipe/:id',
            name: AppRoute.recipe.name,
            builder: (context, state) {
              final recipeId = state.pathParameters['id']!;
              return RecipeScreen(recipeId: recipeId);
            },
          ),
          GoRoute(
            path: 'collection',
            name: AppRoute.collection.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: CollectionScreen(),
            ),
          ),
          GoRoute(
            path: 'account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AccountScreen(),
            ),
          ),
          GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.signIn,
              ),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
