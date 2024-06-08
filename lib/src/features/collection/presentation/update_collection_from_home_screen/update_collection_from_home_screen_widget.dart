import 'package:love_cooking_app/src/common_widgets/add_to_collection_dark_button.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/features/collection/application/collection_service.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection_item.dart';
import 'package:love_cooking_app/src/features/collection/presentation/update_collection_from_home_screen/update_collection_from_home_screen_controller.dart';
import 'package:love_cooking_app/src/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that shows an [Icon] on top of the recipe image on the home page,
/// and next to the recipe title on teh RecipeScreen.
/// Used to add a recipe to collection.
class UpdateCollectionFromHomeScreenWidget extends ConsumerWidget {
  final Recipe recipe;
  const UpdateCollectionFromHomeScreenWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(updateCollectionFromHomeScreenControllerProvider);
    // debugPrint(state.toString());
    final isFavorite = ref.watch(isFavoriteProvider(recipe.id));

    return AddToCollectionDarkButton(
      isLoading: state.isLoading,
      isFavorite: isFavorite,
      onPressed: !isFavorite && !state.isLoading
          ? () {
              ref
                  .read(
                      updateCollectionFromHomeScreenControllerProvider.notifier)
                  .addRecipeToCollectionFromHomeScreen(
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
                  .read(
                      updateCollectionFromHomeScreenControllerProvider.notifier)
                  .removeRecipeFromCollectionFromHomeScreen(recipe.id);

              !state.hasError && !state.isLoading
                  ? showSnackBar(context, 'Removed from Collection')
                  : null;
            },
    );
  }
}
