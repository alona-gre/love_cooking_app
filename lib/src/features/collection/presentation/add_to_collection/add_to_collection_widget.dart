import 'package:love_cooking_app/src/common_widgets/add_to_collection_light_button.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/features/collection/application/collection_service.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection_item.dart';
import 'package:love_cooking_app/src/features/collection/presentation/add_to_collection/add_to_collection_controller.dart';
import 'package:love_cooking_app/src/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that shows an [Icon] on top of the recipe image on the home page,
/// and next to the recipe title on teh RecipeScreen.
/// Used to add a recipe to collection.
class AddToCollectionWidget extends ConsumerWidget {
  final Recipe recipe;
  const AddToCollectionWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addToCollectionControllerProvider);
    // debugPrint(state.toString());
    final isFavorite = ref.watch(isFavoriteProvider(recipe.id));

    return AddToCollectionLightButton(
      isLoading: state.isLoading,
      isFavorite: isFavorite,
      onPressed: !isFavorite && !state.isLoading
          ? () {
              ref
                  .read(addToCollectionControllerProvider.notifier)
                  .addRecipeToCollection(
                    CollectionItem(
                      recipeId: recipe.id,
                    ),
                  );
              !state.hasError && !state.isLoading
                  ? showSnackBar(context, 'Added to Collection')
                  : null;
            }
          : () {
              ref
                  .read(addToCollectionControllerProvider.notifier)
                  .removeRecipeFromCollection(
                    CollectionItem(
                      recipeId: recipe.id,
                    ),
                  );

              !state.hasError && !state.isLoading
                  ? showSnackBar(context, 'Removed from Collection')
                  : null;
            },
    );
  }
}
