import 'package:love_cooking_app/src/common_widgets/error_message_widget.dart';
import 'package:love_cooking_app/src/common_widgets/shimmer_loading_cart_items_list.dart';
import 'package:love_cooking_app/src/features/recipes/data/local/fake_recipes_repository.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection_item.dart';
import 'package:love_cooking_app/src/features/collection/presentation/collection/remove_from_collection_screen_widget.dart';
import 'package:love_cooking_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:love_cooking_app/src/common_widgets/custom_image.dart';
import 'package:love_cooking_app/src/common_widgets/responsive_two_column_layout.dart';
import 'package:love_cooking_app/src/constants/app_sizes.dart';
import 'package:love_cooking_app/src/features/recipes/domain/recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Shows a collection item (or loading/error UI if needed)
class CollectionItemWidget extends ConsumerWidget {
  const CollectionItemWidget({
    super.key,
    required this.collectionItem,
    required this.itemIndex,
  });
  final CollectionItem collectionItem;
  final int itemIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeValue = ref.watch(recipeProvider(collectionItem.recipeId));
    return recipeValue.when(
        data: (recipe) => InkWell(
              onTap: () => context.pushNamed(
                AppRoute.recipe.name,
                pathParameters: {'id': recipe.id},
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.p16),
                    child: CollectionItemContents(
                      recipe: recipe!,
                      collectionItem: collectionItem,
                      itemIndex: itemIndex,
                    ),
                  ),
                ),
              ),
            ),
        error: (e, st) => Center(child: ErrorMessageWidget(e.toString())),
        loading: () =>
            const ShimmerLoadingCartItem(height: 220.0, margin: 16.0));
  }
}

/// Shows a collection item for a given recipe
class CollectionItemContents extends ConsumerWidget {
  const CollectionItemContents({
    super.key,
    required this.recipe,
    required this.collectionItem,
    required this.itemIndex,
  });
  final Recipe recipe;
  final CollectionItem collectionItem;
  final int itemIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveTwoColumnLayout(
      startFlex: 1,
      endFlex: 2,
      breakpoint: 320,
      startContent: CustomImage(imageUrl: recipe.imageUrl),
      spacing: Sizes.p24,
      endContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(recipe.title,
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              RemoveFromCollectionScreenWidget(recipe: recipe),
            ],
          ),
          gapH24,
          gapH24,
        ],
      ),
    );
  }
}
