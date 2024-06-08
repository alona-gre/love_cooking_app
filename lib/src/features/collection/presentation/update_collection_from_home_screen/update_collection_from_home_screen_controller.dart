import 'dart:async';

import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/features/collection/application/collection_service.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'update_collection_from_home_screen_controller.g.dart';

@riverpod
class UpdateCollectionFromHomeScreenController
    extends _$UpdateCollectionFromHomeScreenController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  CollectionService get collectionService =>
      ref.read(collectionServiceProvider);

  Future<void> addRecipeToCollectionFromHomeScreen(
      CollectionItem collectionItem) async {
    state = const AsyncLoading<void>();
    // state = const AsyncLoading<bool>().copyWithPrevious(state);
    final value = await AsyncValue.guard(
      () => collectionService.setCollectionRecipe(collectionItem),
    );
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(null);
    }
  }

  Future<void> removeRecipeFromCollectionFromHomeScreen(
      RecipeID recipeId) async {
    state = const AsyncLoading<void>();
    //state = const AsyncLoading<bool>().copyWithPrevious(state);
    final value = await AsyncValue.guard(
      () => collectionService.removeCollectionRecipeById(recipeId),
    );
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(null);
    }
  }
}
