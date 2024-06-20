import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/common_widgets/custom_text_button.dart';
import 'package:love_cooking_app/src/common_widgets/primary_button.dart';
import 'package:love_cooking_app/src/constants/app_sizes.dart';
import 'package:love_cooking_app/src/constants/test_filters.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filtering_controller/category_filtering_controller.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filtering_controller/diet_filtering_controller.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:love_cooking_app/src/utils/async_value_ui.dart';

class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCategoryFilters =
        ref.watch(categoryFilteringControllerProvider).value;
    final userDietFilters = ref.watch(dietFilteringControllerProvider).value;

    ref.listen<AsyncValue<void>>(
      categoryFilteringControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    ref.listen<AsyncValue<void>>(
      dietFilteringControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 16.0),
            CategoryFilterChipsRow(
              filterTitle: 'Categories',
              filterLabels: userCategoryFilters!.filters.keys.toList(),
            ),
            gapH16,
            DietFilterChipsRow(
              filterTitle: 'Diets',
              filterLabels: userDietFilters!.filters.keys.toList(),
            ),
            gapH16,
            CustomTextButton(
              text: 'Reset filters'.hardcoded,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.red),
              onPressed: () {
                ref
                    .read(categoryFilteringControllerProvider.notifier)
                    .resetFilters();
                ref
                    .read(dietFilteringControllerProvider.notifier)
                    .resetFilters();
              },
            ),
            gapH12,
            PrimaryButton(
              text: 'Save'.hardcoded,
              onPressed: () {
                ref
                    .read(categoryFilteringControllerProvider.notifier)
                    .saveFilters(userCategoryFilters);
                ref
                    .read(dietFilteringControllerProvider.notifier)
                    .saveFilters(userDietFilters);
                Navigator.pop(context);
              },
            ),
            gapH32,
          ],
        ),
      ),
    );
  }
}

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const FilterBottomSheet();
    },
  );
}

class CategoryFilterChipsRow extends ConsumerStatefulWidget {
  final String filterTitle;
  final List<String> filterLabels;

  const CategoryFilterChipsRow({
    super.key,
    required this.filterTitle,
    required this.filterLabels,
  });

  @override
  CategoryFilterChipsRowState createState() => CategoryFilterChipsRowState();
}

class CategoryFilterChipsRowState
    extends ConsumerState<CategoryFilterChipsRow> {
  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(categoryFilteringControllerProvider);
    final userFilters = filters.value == const Filtering({})
        ? const Filtering(availableCategoryFilters)
        : filters.value as Filtering;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.filterTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: widget.filterLabels.map((filter) {
              final label = filter;
              return ChoiceChip(
                label: Text(label),
                selected: userFilters.filters[filter] ?? false,
                onSelected: (selected) {
                  ref
                      .read(categoryFilteringControllerProvider.notifier)
                      .setFilter(filter, selected);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DietFilterChipsRow extends ConsumerStatefulWidget {
  final String filterTitle;
  final List<String> filterLabels;

  const DietFilterChipsRow({
    super.key,
    required this.filterTitle,
    required this.filterLabels,
  });

  @override
  DietFilterChipsRowState createState() => DietFilterChipsRowState();
}

class DietFilterChipsRowState extends ConsumerState<DietFilterChipsRow> {
  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(dietFilteringControllerProvider);
    final userFilters = filters.value == const Filtering({})
        ? const Filtering(availableDietFilters)
        : filters.value as Filtering;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.filterTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: widget.filterLabels.map((filter) {
              final label = filter;
              return ChoiceChip(
                label: Text(label),
                selected: userFilters.filters[filter] ?? false,
                onSelected: (selected) {
                  ref
                      .read(dietFilteringControllerProvider.notifier)
                      .setFilter(filter, selected);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
