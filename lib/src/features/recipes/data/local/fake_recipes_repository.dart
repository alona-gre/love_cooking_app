import 'dart:async';
import 'package:love_cooking_app/src/constants/test_recipes.dart';
import 'package:love_cooking_app/src/features/filters/application/category_filtering_service.dart';
import 'package:love_cooking_app/src/features/filters/application/diet_filtering_service.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filtering_controller/category_filtering_controller.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filtering_controller/diet_filtering_controller.dart';
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

  /// Filter all recipes where the category contains the filter(s) and booleans match the filter
  Future<List<Recipe>> filterRecipesFuture(
      Filtering categoryFiltering, Filtering dietFiltering) async {
    // Get all recipes
    final recipesList = await fetchRecipesList();

    // Convert the Filtering object to a Map<String, bool>
    final catFiltering = categoryFiltering.filters;
    final dFiltering = dietFiltering.filters;

    // Determine which category filters are enabled
    final categoryFilters = {
      'breakfast': catFiltering['breakfast'] ?? false,
      'lunch': catFiltering['lunch'] ?? false,
      'dinner': catFiltering['dinner'] ?? false,
      'dessert': catFiltering['dessert'] ?? false,
      'italian': catFiltering['italian'] ?? false,
      'Quick & Easy': catFiltering['quickEasy'] ?? false,
      'hamburgers': catFiltering['hamburgers'] ?? false,
      'german': catFiltering['german'] ?? false,
      'exotic': catFiltering['exotic'] ?? false,
      'light': catFiltering['light'] ?? false,
      'asian': catFiltering['asian'] ?? false,
      'french': catFiltering['french'] ?? false,
      'summer': catFiltering['summer'] ?? false,
      'sandwiches': catFiltering['sandwiches'] ?? false,
    };

    // Determine which diet filters are enabled
    final dietFilters = {
      'glutenFree': dFiltering['glutenFree'] ?? false,
      'lactoseFree': dFiltering['lactoseFree'] ?? false,
      'vegetarian': dFiltering['vegetarian'] ?? false,
      'vegan': dFiltering['vegan'] ?? false,
    };

    // Return the filtered list of recipes
    return recipesList.where((recipe) {
      // Check if the recipe matches any of the active category filters
      bool matchesCategory = categoryFilters.entries.any((entry) {
        return entry.value && recipe.categories.contains(entry.key);
      });

      // If no category filters are active, consider it a match (i.e., don't filter out by categories)
      if (!matchesCategory && categoryFilters.values.every((v) => !v)) {
        matchesCategory = true;
      }

      // Check if the recipe matches all active diet filters
      bool matchesDiet = dietFilters.entries.every((entry) {
        if (!entry.value) return true; // If the filter is not active, ignore it
        switch (entry.key) {
          case 'glutenFree':
            return recipe.isGlutenFree;
          case 'lactoseFree':
            return recipe.isLactoseFree;
          case 'vegetarian':
            return recipe.isVegetarian;
          case 'vegan':
            return recipe.isVegan;
          default:
            return true; // Just a fallback, should not be hit
        }
      });

      return matchesCategory && matchesDiet;
    }).toList();
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

@riverpod
Future<List<Recipe>> filteredRecipesFuture(FilteredRecipesFutureRef ref) async {
  final recipesRepository = ref.watch(recipesRepositoryProvider);

  final categoryFilters =
      ref.watch(categoryFilteringControllerProvider).value ??
          await ref.watch(categoryFilteringServiceProvider).fetchFiltering();
  final dietFilters = ref.watch(dietFilteringControllerProvider).value ??
      await ref.watch(dietFilteringServiceProvider).fetchFiltering();

  final filteredRecipes =
      await recipesRepository.filterRecipesFuture(categoryFilters, dietFilters);
  return filteredRecipes;
}
