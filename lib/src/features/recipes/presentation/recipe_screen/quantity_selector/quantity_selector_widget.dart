import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/common_widgets/item_quantity_selector.dart';
import 'package:love_cooking_app/src/constants/app_sizes.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/features/recipes/presentation/recipe_screen/quantity_selector/quantity_selector_controller.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:love_cooking_app/src/utils/async_value_ui.dart';

/// A widget that shows an [ItemQuantitySelector] along with a [PrimaryButton]
/// to calculate ingredients for the selected number of servings.
class QuantitySelectorWidget extends ConsumerWidget {
  const QuantitySelectorWidget({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      recipeIngredientsControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(recipeIngredientsControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Serves:'.hardcoded),
            gapW16,
            ItemQuantitySelector(
              quantity: recipe.portion,
              // let the user choose how many portions needed
              onChanged: state.isLoading
                  ? null
                  : (quantity) {
                      ref
                          .read(itemQuantityControllerProvider.notifier)
                          .updateQuantity(quantity);

                      final updatedIngredients =
                          recipe.ingredients.map((ingredient) {
                        if (ingredient.quantity != null) {
                          return ingredient.copyWith(
                              quantity: ingredient.quantity! /
                                  recipe.portion *
                                  quantity);
                        } else {
                          return ingredient;
                        }
                      }).toList();

                      final Recipe updatedRecipe = recipe.copyWith(
                        id: recipe.id,
                        ingredients: updatedIngredients,
                        portion: quantity,
                      );

                      ref
                          .read(recipeIngredientsControllerProvider.notifier)
                          .updateRecipeIngredients(updatedRecipe);
                    },
            ),
          ],
        ),
      ],
    );
  }
}
