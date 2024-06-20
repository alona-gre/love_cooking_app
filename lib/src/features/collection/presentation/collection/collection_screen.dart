import 'package:love_cooking_app/src/common_widgets/async_value_widget.dart';
import 'package:love_cooking_app/src/common_widgets/primary_button.dart';
import 'package:love_cooking_app/src/features/collection/application/collection_service.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection.dart';
import 'package:love_cooking_app/src/features/collection/presentation/collection/collection_screen_controller.dart';
import 'package:love_cooking_app/src/features/collection/presentation/collection/collection_item.dart';
import 'package:love_cooking_app/src/features/collection/presentation/collection/collection_items_builder.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:love_cooking_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Collection screen showing the items in the collection (editable)
class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      collectionScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Collection'.hardcoded),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final collectionValue = ref.watch(collectionProvider);
          return AsyncValueWidget(
            value: collectionValue,
            data: (collection) => CollectionItemsBuilder(
              items: collection.toCollectionItemsList(),
              itemBuilder: (_, item, index) => CollectionItemWidget(
                collectionItem: item,
                itemIndex: index,
              ),
              // TODO: remove the button
              ctaBuilder: (_) => PrimaryButton(
                  text: 'Go to Cart'.hardcoded,

                  // isLoading: state.isLoading,
                  onPressed: () {}),
            ),
          );
        },
      ),
    );
  }
}
