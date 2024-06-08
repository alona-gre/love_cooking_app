import 'package:love_cooking_app/src/common_widgets/add_to_collection_dark_button.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/features/collection/application/collection_service.dart';
import 'package:love_cooking_app/src/features/collection/presentation/collection/collection_screen_controller.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:love_cooking_app/src/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that shows an [Icon] on top of the recipe image on the home page,
/// and next to the recipe title on teh RecipeScreen.
/// Used to add a recipe to collection.
class RemoveFromCollectionScreenWidget extends ConsumerWidget {
  final Recipe recipe;
  const RemoveFromCollectionScreenWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(collectionScreenControllerProvider);
    final isFavorite = ref.watch(isFavoriteProvider(recipe.id));

    return AddToCollectionDarkButton(
      isLoading: state.isLoading,
      isFavorite: isFavorite,
      onPressed: state.isLoading
          ? null
          : () {
              ref
                  .read(collectionScreenControllerProvider.notifier)
                  .removeFromCollectionScreenById(recipe.id);

              state.copyWithPrevious(state).hasError
                  ? null
                  : showSnackBar(context, 'Removed from Collection'.hardcoded);
            },
    );
  }
}
