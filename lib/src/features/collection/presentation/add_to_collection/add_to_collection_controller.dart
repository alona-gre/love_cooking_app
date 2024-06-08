import 'dart:async';

import 'package:love_cooking_app/src/features/collection/application/collection_service.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_to_collection_controller.g.dart';

@riverpod
class AddToCollectionController extends _$AddToCollectionController {
  @override
  FutureOr<bool> build() {
    return false;
  }

  CollectionService get collectionService =>
      ref.read(collectionServiceProvider);

  Future<void> addRecipeToCollection(CollectionItem collectionItem) async {
    state = const AsyncLoading<bool>().copyWithPrevious(state);
    final value = await AsyncValue.guard(
      () => collectionService.setCollectionRecipe(collectionItem),
    );
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(true);
    }
  }

  Future<void> removeRecipeFromCollection(CollectionItem collectionItem) async {
    state = const AsyncLoading<bool>().copyWithPrevious(state);
    final value = await AsyncValue.guard(
      () => collectionService.removeCollectionRecipe(collectionItem),
    );
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(false);
    }
  }
}
