import 'dart:async';

import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/features/collection/application/collection_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collection_screen_controller.g.dart';

@riverpod
class CollectionScreenController extends _$CollectionScreenController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> removeFromCollectionScreenById(RecipeID recipeId) async {
    final collectionService = ref.read(collectionServiceProvider);
    state = const AsyncLoading<bool>();
    final value = await AsyncValue.guard(
        () => collectionService.removeCollectionRecipeById(recipeId));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(null);
    }
  }
}
