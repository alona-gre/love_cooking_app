import 'dart:async';
import 'package:love_cooking_app/src/constants/test_recipes.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/utils/delay.dart';
import 'package:love_cooking_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_recipes_repository.g.dart';

class FakeRecipesRepository {
  FakeRecipesRepository({this.addDelay = true});
  final bool addDelay;

  /// Preload with the default list of recipes when the app starts
  final _recipes = InMemoryStore<List<Recipe>>(List.from(kTestRecipes));

  List<Recipe> getRecipesList() {
    return _recipes.value;
  }

  Recipe? getRecipe(String id) {
    return _getRecipe(_recipes.value, id);
  }

  Future<List<Recipe>> fetchRecipesList() async {
    return Future.value(_recipes.value);
  }

  Stream<List<Recipe>> watchRecipesList() {
    return _recipes.stream;
  }

  Stream<Recipe?> watchRecipe(String id) {
    return watchRecipesList().map((recipes) => _getRecipe(recipes, id));
  }

  /// Update recipe or add a new one
  Future<void> setRecipe(Recipe recipe) async {
    await delay(addDelay);
    final recipes = _recipes.value;
    final index = recipes.indexWhere((p) => p.id == recipe.id);
    if (index == -1) {
      // if not found, add as a new recipe
      recipes.add(recipe);
    } else {
      // else, overwrite previous recipe
      recipes[index] = recipe;
    }
    _recipes.value = recipes;
  }

  Future<void> updateRecipe(Recipe recipe) async {
    await delay(addDelay);
    final recipes = _recipes.value;
    final recipeIndex = recipes.indexWhere((rec) => rec.id == recipe.id);
    recipes.removeAt(recipeIndex);
    recipes.insert(recipeIndex, recipe);
    final updatedRecipes = recipes;

    _recipes.value = updatedRecipes;
  }

  /// Search for recipes where the title contains the search query
  Future<List<Recipe>> searchRecipes(String query) async {
    assert(
      _recipes.value.length <= 100,
      'Client-side search should only be performed if the number of recipes is small. '
      'Consider doing server-side search for larger datasets.',
    );
    // Get all recipes
    final recipesList = await fetchRecipesList();
    // Match all recipes where the title contains the query
    return recipesList
        .where((recipe) =>
            recipe.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static Recipe? _getRecipe(List<Recipe> recipes, String id) {
    try {
      return recipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }
}

@riverpod
FakeRecipesRepository recipesRepository(RecipesRepositoryRef ref) {
  // * Set addDelay to false for faster loading
  return FakeRecipesRepository(addDelay: false);
}

@riverpod
Stream<List<Recipe>> recipesListStream(RecipesListStreamRef ref) {
  final recipesRepository = ref.watch(recipesRepositoryProvider);
  return recipesRepository.watchRecipesList();
}

@riverpod
Future<List<Recipe>> recipesListFuture(RecipesListFutureRef ref) {
  final recipesRepository = ref.watch(recipesRepositoryProvider);
  return recipesRepository.fetchRecipesList();
}

@riverpod
Stream<Recipe?> recipe(RecipeRef ref, RecipeID id) {
  final recipesRepository = ref.watch(recipesRepositoryProvider);
  return recipesRepository.watchRecipe(id);
}

@riverpod
Future<List<Recipe>> recipesListSearch(
    RecipesListSearchRef ref, String query) async {
  final link = ref.keepAlive();
  // * keep previous search results in memory for 60 seconds
  final timer = Timer(const Duration(seconds: 60), () {
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  final recipesRepository = ref.watch(recipesRepositoryProvider);
  return recipesRepository.searchRecipes(query);
}
