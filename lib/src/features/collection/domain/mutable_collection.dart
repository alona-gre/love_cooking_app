import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection_item.dart';

/// Helper extension used to mutate the items in the collection.
extension MutableCollection on Collection {
  /// set a recipe as favorite
  Collection setFavoriteItem(CollectionItem collectionItem) {
    final copy = Map<RecipeID, bool>.from(items);
    copy[collectionItem.recipeId] = true;
    return Collection(copy);
  }

  /// if an item with the given recipeId is found, remove it
  Collection removeFromCollectionById(RecipeID recipeId) {
    final copy = Map<RecipeID, bool>.from(items);
    copy.remove(recipeId);
    return Collection(copy);
  }

  /// adds a list of collectionItems by updating isFavorite value
  /// used when syncing local to remote collection
  Collection addCollectionItems(List<CollectionItem> itemsToAdd) {
    final copy = Map<RecipeID, bool>.from(items);
    for (var item in itemsToAdd) {
      copy.update(
        item.recipeId,
        // if there is already a value, update it by adding the isFavorite value
        (value) => item.isFavorite,
        ifAbsent: () => item.isFavorite,
      );
    }
    return Collection(copy);
  }
}
