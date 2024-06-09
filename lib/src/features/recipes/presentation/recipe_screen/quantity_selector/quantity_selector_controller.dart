import 'dart:async';

import 'package:love_cooking_app/src/features/recipes/data/local/fake_recipes_repository.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'quantity_selector_controller.g.dart';

@riverpod
class RecipeIngredientsController extends _$RecipeIngredientsController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> updateRecipeIngredients(Recipe recipe) async {
    state = const AsyncLoading<void>();

    final updatedRecipe = recipe.copyWith(ingredients: recipe.ingredients);

    final value = await AsyncValue.guard(
      () => ref.read(recipesRepositoryProvider).updateRecipe(updatedRecipe),
    );

    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData<void>(null);
    }
  }
}

@riverpod
class ItemQuantityController extends _$ItemQuantityController {
  @override
  int build() {
    return 1;
  }

  void updateQuantity(int quantity) {
    state = quantity;
  }
}
