import 'package:love_cooking_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:love_cooking_app/src/constants/breakpoints.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection_item.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:love_cooking_app/src/common_widgets/responsive_center.dart';
import 'package:love_cooking_app/src/constants/app_sizes.dart';

/// Responsive widget showing the collection items and the checkout button
class CollectionItemsBuilder extends StatelessWidget {
  const CollectionItemsBuilder({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.ctaBuilder,
  });
  final List<CollectionItem> items;
  final Widget Function(BuildContext, CollectionItem, int) itemBuilder;
  final WidgetBuilder ctaBuilder;

  @override
  Widget build(BuildContext context) {
    // If there are no items, show a placeholder
    if (items.isEmpty) {
      return EmptyPlaceholderWidget(
        message: 'Your collection is empty'.hardcoded,
      );
    }
    // ! MediaQuery is used on the assumption that the widget takes up the full
    // ! width of the screen. If that's not the case, LayoutBuilder should be
    // ! used instead.
    final screenWidth = MediaQuery.of(context).size.width;
    // * on wide layouts, show a list of items on the left and the checkout
    // * button on the right
    if (screenWidth >= Breakpoint.tablet) {
      return ResponsiveCenter(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Row(
          children: [
            Flexible(
              // use 3 flex units for the list of items
              flex: 3,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return itemBuilder(context, item, index);
                },
                itemCount: items.length,
              ),
            ),
            gapW16,
          ],
        ),
      );
    } else {
      // * on narrow layouts, show a [Column] with a scrollable list of items
      // * and a pinned box at the bottom with the checkout button
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(Sizes.p16),
              itemBuilder: (context, index) {
                final item = items[index];
                return itemBuilder(context, item, index);
              },
              itemCount: items.length,
            ),
          ),
        ],
      );
    }
  }
}
