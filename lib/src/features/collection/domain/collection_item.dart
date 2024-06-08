// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';

class CollectionItem {
  final RecipeID recipeId;
  final bool isFavorite;

  CollectionItem({required this.recipeId, this.isFavorite = false});

  @override
  bool operator ==(covariant CollectionItem other) {
    if (identical(this, other)) return true;

    return other.recipeId == recipeId && other.isFavorite == isFavorite;
  }

  @override
  int get hashCode => recipeId.hashCode ^ isFavorite.hashCode;
}
