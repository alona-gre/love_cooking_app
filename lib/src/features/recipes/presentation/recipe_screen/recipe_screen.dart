import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/common_widgets/async_value_widget.dart';
import 'package:love_cooking_app/src/common_widgets/custom_image.dart';
import 'package:love_cooking_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:love_cooking_app/src/common_widgets/home_app_bar.dart';
import 'package:love_cooking_app/src/common_widgets/responsive_center.dart';
import 'package:love_cooking_app/src/common_widgets/responsive_two_column_layout.dart';
import 'package:love_cooking_app/src/constants/app_sizes.dart';
import 'package:love_cooking_app/src/constants/breakpoints.dart';
import 'package:love_cooking_app/src/features/collection/presentation/add_to_collection/add_to_collection_controller.dart';
import 'package:love_cooking_app/src/features/collection/presentation/add_to_collection/add_to_collection_widget.dart';
import 'package:love_cooking_app/src/features/recipes/data/local/fake_recipes_repository.dart';
import 'package:love_cooking_app/src/features/recipes/domain/ingredient.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:love_cooking_app/src/features/recipes/presentation/recipe_screen/quantity_selector/quantity_selector_widget.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:love_cooking_app/src/utils/async_value_ui.dart';

//// Shows the Recipe page for a given Recipe ID.
class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key, required this.recipeId});
  final RecipeID recipeId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          final recipeValue = ref.watch(recipeProvider(recipeId));
          return AsyncValueWidget<Recipe?>(
            value: recipeValue,
            data: (recipe) => recipe == null
                ? EmptyPlaceholderWidget(
                    message: 'Recipe not found'.hardcoded,
                  )
                : CustomScrollView(
                    slivers: [
                      ResponsiveSliverCenter(
                        color: Colors.black,
                        maxContentWidth: screenWidth,
                        child: RecipePreview(recipe: recipe),
                      ),
                      ResponsiveSliverCenter(
                        maxContentWidth: screenWidth,
                        child: RecipeDetails(recipe: recipe),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

/// Shows the main details of the recipe:
/// - image
/// - title, description
/// - buttons to add to collection and planner
class RecipePreview extends ConsumerWidget {
  const RecipePreview({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      addToCollectionControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    // TODO: add once implemented
    // ref.listen<AsyncValue<void>>(
    //   addToPlannerControllerProvider,
    //   (_, state) => state.showAlertDialogOnError(context),
    // );

    final screenWidth = MediaQuery.of(context).size.width;
    return ResponsiveTwoColumnLayout(
      startContent: CustomImage(imageUrl: recipe.imageUrl),
      spacing: Sizes.p16,
      endContent: SizedBox(
        height: screenWidth >= Breakpoint.tablet ? 300 : null,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                  ),
                  gapH8,
                  Text(
                    recipe.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              gapH16,
              if (screenWidth >= Breakpoint.tablet) const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: Colors.white,
                        ),
                        gapW4,
                        Flexible(
                          child: Text(
                            '${recipe.duration} min',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AddToCollectionWidget(recipe: recipe),
                  // TODO: AddToPlannerWidget(recipe: recipe),
                ],
              ),
              gapH8,
            ],
          ),
        ),
      ),
    );
  }
}

/// Shows the other details of the recipe:
/// - instructions
/// - ingredients
/// - nutritions (will be added later)
class RecipeDetails extends ConsumerWidget {
  const RecipeDetails({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveTwoColumnLayoutWithSwitch(
      startContent: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            gapH8,
            QuantitySelectorWidget(recipe: recipe),
            gapH8,
            ...recipe.ingredients.map((ingredient) {
              return IngredientRow(
                ingredient: ingredient,
              );
            }),
          ],
        ),
      ),
      spacing: Sizes.p16,
      endContent: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            ...recipe.steps.asMap().entries.map((entry) {
              int index = entry.key;
              String step = entry.value;
              return StepRow(step: step, stepNumber: index + 1);
            }),
          ],
        ),
      ),
    );
  }
}

class IngredientRow extends StatefulWidget {
  final Ingredient ingredient;
  const IngredientRow({
    super.key,
    required this.ingredient,
  });

  @override
  State<IngredientRow> createState() => _IngredientRowState();
}

class _IngredientRowState extends State<IngredientRow> {
  var ingredientStatus = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    widget.ingredient.quantity != null
                        ? Text(
                            widget.ingredient.quantity.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : gapW12,
                    gapW4,
                    widget.ingredient.quantity != null
                        ? Text(
                            widget.ingredient.unit ?? '',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : gapW12,
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  widget.ingredient.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Checkbox(
                  value: ingredientStatus,
                  onChanged: (value) {
                    setState(() {
                      ingredientStatus = value!;
                    });
                  }),
            ],
          ),
        ),
        Divider(color: Colors.grey[300]),
      ],
    );
  }
}

class StepRow extends StatelessWidget {
  final String step;
  final int stepNumber;

  const StepRow({
    super.key,
    required this.step,
    required this.stepNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step $stepNumber',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Divider(color: Colors.grey[300]),
        Text(
          step,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        gapH32,
      ],
    );
  }
}
