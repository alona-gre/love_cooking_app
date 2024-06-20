import 'package:love_cooking_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/features/collection/data/local/local_collection_repository.dart';
import 'package:love_cooking_app/src/features/collection/data/remote/remote_collection_repository.dart';
import 'package:love_cooking_app/src/features/collection/domain/mutable_collection.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collection_service.g.dart';

class CollectionService {
  final Ref ref;
  CollectionService(this.ref);

  /// fetch the Collection from remote or local repository
  /// depending on the user auth state
  Future<Collection> _fetchCollection() {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref
          .read(remoteCollectionRepositoryProvider)
          .fetchCollection(user.uid);
    } else {
      return ref.read(localCollectionRepositoryProvider).fetchCollection();
    }
  }

  /// sets the Collection to remote or local repository
  /// depending on the user auth state
  Future<void> _setCollection(Collection collection) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      await ref
          .read(remoteCollectionRepositoryProvider)
          .setCollection(user.uid, collection);
    } else {
      await ref
          .read(localCollectionRepositoryProvider)
          .setCollection(collection);
    }
  }

  /// adds a recipe to collection in remote or local repository
  /// depending on the user auth state
  Future<void> setCollectionRecipe(CollectionItem collectionItem) async {
    final collection = await _fetchCollection();
    final updatedCollection = collection.setFavoriteItem(collectionItem);
    await _setCollection(updatedCollection);
  }

  // removes a Recipe from collection in remote or local repository
  // depending on the user auth state
  Future<void> removeCollectionRecipe(CollectionItem collectionItem) async {
    final collection = await _fetchCollection();
    final updatedCollection =
        collection.removeFromCollectionById(collectionItem.recipeId);
    await _setCollection(updatedCollection);
  }

  // removes a Recipe from collection in remote or local repository
  // depending on the user auth state
  Future<void> removeCollectionRecipeById(RecipeID recipeId) async {
    final collection = await _fetchCollection();
    final updatedCollection = collection.removeFromCollectionById(recipeId);
    await _setCollection(updatedCollection);
  }
}

@Riverpod(keepAlive: true)
CollectionService collectionService(CollectionServiceRef ref) {
  return CollectionService(ref);
}

@Riverpod(keepAlive: true)
Stream<Collection> collection(CollectionRef ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref
        .read(remoteCollectionRepositoryProvider)
        .watchCollection(user.uid);
  } else {
    return ref.read(localCollectionRepositoryProvider).watchCollection();
  }
}

@Riverpod(keepAlive: true)
int collectionItemsCount(CollectionItemsCountRef ref) {
  return ref.watch(collectionProvider).maybeMap(
        data: (col) => col.value.items.length,
        orElse: () => 0,
      );
}

@riverpod
bool isFavorite(IsFavoriteRef ref, RecipeID recipeId) {
  final collection = ref.watch(collectionProvider).value ?? const Collection();

  return collection.items[recipeId] ?? false;
}
