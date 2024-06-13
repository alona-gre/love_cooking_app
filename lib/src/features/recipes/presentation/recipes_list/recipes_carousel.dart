import 'package:carousel_slider/carousel_slider.dart';
import 'package:love_cooking_app/src/common_widgets/async_value_widget.dart';
import 'package:love_cooking_app/src/constants/breakpoints.dart';
import 'package:love_cooking_app/src/features/recipes/data/local/fake_recipes_repository.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/features/recipes/presentation/recipes_list/recipe_card.dart';
import 'package:love_cooking_app/src/features/recipes/presentation/recipes_list/recipes_search_state_provider.dart';
import 'package:love_cooking_app/src/features/collection/presentation/update_collection_from_home_screen/update_collection_from_home_screen_controller.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:love_cooking_app/src/routing/app_router.dart';
import 'package:love_cooking_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A widget that displays the list of recipes that match the search query.
class RecipesCarousel extends ConsumerWidget {
  const RecipesCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      updateCollectionFromHomeScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    // final recipesListValue = ref.watch(recipesSearchResultsProvider);
    // TODO: re-enable search
    final filteredRecipesListValue = ref.watch(filteredRecipesProvider);
    return AsyncValueWidget<List<Recipe>>(
      value: filteredRecipesListValue,
      data: (recipes) => recipes.isEmpty
          ? Center(
              child: Text(
                'No recipes found'.hardcoded,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : RecipesCarouselSlider(
              itemCount: recipes.length,
              itemBuilder: (_, index) {
                final recipe = recipes[index];
                return RecipeCard(
                  recipe: recipe,
                  onPressed: () => context.goNamed(
                    AppRoute.recipe.name,
                    pathParameters: {'id': recipe.id},
                  ),
                );
              },
            ),
    );
  }
}

/// Carousel slider widget with recipe items.
class RecipesCarouselSlider extends StatelessWidget {
  const RecipesCarouselSlider({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display.
  final int itemCount;

  /// Function used to build a widget for a given index in the carousel.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: itemBuilder(context, index),
        );
      },
      options: CarouselOptions(
        height: 360.0,
        enlargeCenterPage: false,
        autoPlay: false,
        aspectRatio: 16 / 9,
        viewportFraction: (screenWidth < Breakpoint.tablet) ? 1 : 0.4,
      ),
    );
  }
}
