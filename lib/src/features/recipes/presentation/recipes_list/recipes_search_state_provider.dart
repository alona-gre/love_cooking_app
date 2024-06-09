import 'package:love_cooking_app/src/features/recipes/data/local/fake_recipes_repository.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipes_search_state_provider.g.dart';

final recipesSearchQueryStateProvider = StateProvider<String>((ref) {
  return '';
});

@riverpod
Future<List<Recipe>> recipesSearchResults(RecipesSearchResultsRef ref) {
  final searchQuery = ref.watch(recipesSearchQueryStateProvider);
  return ref.watch(recipesListSearchProvider(searchQuery).future);
}
