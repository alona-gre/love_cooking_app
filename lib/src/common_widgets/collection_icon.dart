import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_cooking_app/src/constants/app_sizes.dart';
import 'package:love_cooking_app/src/features/collection/application/collection_service.dart';
import 'package:love_cooking_app/src/routing/app_router.dart';

/// Collection icon with items count badge
class CollectionIcon extends ConsumerWidget {
  const CollectionIcon({super.key});

  // * Keys for testing using find.byKey()
  static const collectionIconKey = Key('collection');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var collectionItemsCount = ref.watch(collectionItemsCountProvider);
    return Stack(
      children: [
        Center(
          child: IconButton(
            key: collectionIconKey,
            icon: const Icon(
              Icons.bookmark_added,
            ),
            onPressed: () => context.goNamed(AppRoute.collection.name),
          ),
        ),
        if (collectionItemsCount > 0)
          Positioned(
            top: Sizes.p4,
            right: Sizes.p4,
            child: CollectionIconBadge(itemsCount: collectionItemsCount),
          ),
      ],
    );
  }
}

/// Icon badge showing the items count
class CollectionIconBadge extends StatelessWidget {
  const CollectionIconBadge({super.key, required this.itemsCount});
  final int itemsCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.p16,
      height: Sizes.p16,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Text(
          '$itemsCount',
          textAlign: TextAlign.center,
          // * Force textScaleFactor to 1.0 irrespective of the device's
          // * textScaleFactor. This is to prevent the text from growing bigger
          // * than the available space.
          textScaler: const TextScaler.linear(1.0),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
