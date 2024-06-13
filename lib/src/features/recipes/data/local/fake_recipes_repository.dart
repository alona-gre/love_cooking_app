import 'dart:async';
import 'package:love_cooking_app/src/constants/test_recipes.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filters_controller.dart';
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
  Future<List<Recipe>> filterRecipes(Map<Filter, bool> filters) async {
    // Get all recipes
    final recipesList = await fetchRecipesList();

    // Determine which category filters are enabled
    final categoryFilters = {
      'breakfast': filters[Filter.breakfast] ?? false,
      'lunch': filters[Filter.lunch] ?? false,
      'dinner': filters[Filter.dinner] ?? false,
      'dessert': filters[Filter.dessert] ?? false,
      'italian': filters[Filter.italian] ?? false,
      'Quick & Easy': filters[Filter.quickEasy] ?? false,
      'hamburgers': filters[Filter.hamburgers] ?? false,
      'german': filters[Filter.german] ?? false,
      'exotic': filters[Filter.exotic] ?? false,
      'light': filters[Filter.light] ?? false,
      'asian': filters[Filter.asian] ?? false,
      'french': filters[Filter.french] ?? false,
      'summer': filters[Filter.summer] ?? false,
      'sandwiches': filters[Filter.sandwiches] ?? false,
    };

    // Determine which boolean filters are enabled
    final booleanFilters = {
      Filter.glutenFree: filters[Filter.glutenFree] ?? false,
      Filter.lactoseFree: filters[Filter.lactoseFree] ?? false,
      Filter.vegetarian: filters[Filter.vegetarian] ?? false,
      Filter.vegan: filters[Filter.vegan] ?? false,
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

      // Check if the recipe matches all active boolean filters
      bool matchesBoolean = booleanFilters.entries.every((entry) {
        if (!entry.value) return true; // If the filter is not active, ignore it
        switch (entry.key) {
          case Filter.glutenFree:
            return recipe.isGlutenFree;
          case Filter.lactoseFree:
            return recipe.isLactoseFree;
          case Filter.vegetarian:
            return recipe.isVegetarian;
          case Filter.vegan:
            return recipe.isVegan;
          default:
            return true; // Just a fallback, should not be hit
        }
      });

      return matchesCategory && matchesBoolean;
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
Future<List<Recipe>> filteredRecipes(FilteredRecipesRef ref) async {
  final recipesRepository = ref.watch(recipesRepositoryProvider);
  final filters = ref.watch(filtersProvider);
  final filtererdRecipes = await recipesRepository.filterRecipes(filters);
  return filtererdRecipes;
}
