import 'package:flutter/material.dart';
import 'package:love_cooking_app/src/common_widgets/custom_image.dart';
import 'package:love_cooking_app/src/features/collection/presentation/update_collection_from_home_screen/update_collection_from_home_screen_widget.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Used to show a single recipe inside a card.
class RecipeCard extends ConsumerWidget {
  const RecipeCard({super.key, required this.recipe, this.onPressed});
  final Recipe recipe;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const recipeCardKey = Key('recipe-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      key: recipeCardKey,
      onTap: onPressed,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                child: CustomImage(
                  imageUrl: recipe.imageUrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: UpdateCollectionFromHomeScreenWidget(recipe: recipe),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
