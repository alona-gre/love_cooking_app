// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:love_cooking_app/src/features/authentication/data/fake_auth_repository.dart';
// import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';

// class RecipesService {
//   final Ref ref;
//   RecipesService(this.ref);

//   Future<void> updateRecipe(Recipe recipe) async {
//     // TODO: delete
//     //final user = ref.read(authRepositoryProvider).currentUser;
//     final user = ref.watch(authStateChangesProvider).value;
//     if (user != null) {
//       await ref
//           .read(remoteRecipesRepositoryProvider)
//           .updateRecipe(user.uid, recipe);
//     } else {
//       await ref.read(localRecipesRepositoryProvider).updateRecipe(recipe);
//     }
//   }

//   static Recipe? _getRecipe(List<Recipe> recipes, String id) {
//     try {
//       return recipes.firstWhere((rec) => rec.id == id);
//     } catch (e) {
//       return null;
//     }
//   }

//   Stream<List<Recipe>> watchRecipes() {
//     //final user = ref.read(authRepositoryProvider).currentUser;
//     final user = ref.watch(authStateChangesProvider).value;
//     if (user != null) {
//       return ref.read(remoteRecipesRepositoryProvider).watchRecipes(user.uid);
//     } else {
//       return ref.read(localRecipesRepositoryProvider).watchRecipes();
//     }
//   }

//   Stream<Recipe?> watchRecipe(String recipeId) {
//     return watchRecipes().map((recipes) => _getRecipe(recipes, recipeId));
//   }

//   // Stream<List<Recipe>> searchRecipes(String query) {
//   //   // final user = ref.read(authRepositoryProvider).currentUser;
//   //   final user = ref.watch(authStateChangesProvider).value;
//   //   if (user != null) {
//   //     return ref
//   //         .read(remoteRecipesRepositoryProvider)
//   //         .searchRecipes(user.uid, query);
//   //   } else {
//   //     return ref.read(localRecipesRepositoryProvider).searchRecipes(query);
//   //   }
//   // }
// }

// final recipesServiceProvider = Provider<RecipesService>(
//   (ref) {
//     return RecipesService(ref);
//   },
// );

// final recipesProvider = StreamProvider(
//   (ref) => ref.watch(recipesServiceProvider).watchRecipes(),
// );

// final starredProvider = StreamProvider((ref) {
//   final starredRecipes = ref.watch(recipesServiceProvider).watchStarred();
//   return starredRecipes;
// });

// final completedProvider = StreamProvider((ref) {
//   final completedRecipes =
//       ref.watch(recipesServiceProvider).watchCompletedRecipesStream();
//   return completedRecipes;
// });

// final isStarredProvider = Provider.family<bool, String>((ref, recipeId) {
//   final recipes = ref.watch(recipesProvider).value;
//   final recipe = recipes!.firstWhere(
//     (tsk) => tsk.id == recipeId,
//     // orElse: () => const Recipe(),
//   );
//   final isStarred = recipe.isStarred;
//   return isStarred ?? false;
// });

// final isCompletedProvider = Provider.family<bool, String>((ref, recipeId) {
//   final recipes = ref.watch(recipesProvider).value;
//   final recipe = recipes!.firstWhere(
//     (tsk) => tsk.id == recipeId,
//     // orElse: () => const Recipe(),
//   );
//   final isCompleted = recipe.isCompleted;
//   return isCompleted ?? false;
// });

// final recipeProvider = StreamProvider.family<Recipe?, String>(
//   (ref, recipeId) {
//     return ref.watch(recipesServiceProvider).watchRecipe(recipeId);
//   },
// );

// final searchRecipesProvider =
//     StreamProvider.autoDispose.family<List<Recipe>, String>(
//   (ref, query) {
//     // ref.onDispose(() => debugPrint('onDisposed: $query'));
//     // ref.onCancel(() => debugPrint('cancel: $query'));
//     final link = ref.keepAlive();
//     Timer(const Duration(seconds: 5), () {
//       link.close();
//     });

//     // * debounce/delay network requests
//     // * only works in combination with a CancelToken
//     return ref.watch(recipesServiceProvider).searchRecipes(query);
//   },
// );
