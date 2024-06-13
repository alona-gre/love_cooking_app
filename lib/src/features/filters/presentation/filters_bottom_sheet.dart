import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/common_widgets/custom_text_button.dart';
import 'package:love_cooking_app/src/constants/app_sizes.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filters_controller.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';

class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO  final chosenFilters = ref.watch(filtersProvider);
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 16.0),
            const CategoryFilterChipsRow(
              filterTitle: 'Categories',
              filters: [
                Filter.breakfast,
                Filter.lunch,
                Filter.dinner,
                Filter.dessert,
                Filter.italian,
                Filter.quickEasy,
                Filter.hamburgers,
                Filter.german,
                Filter.exotic,
                Filter.light,
                Filter.asian,
                Filter.french,
                Filter.summer,
                Filter.sandwiches,
              ],
              filterLabels: {
                Filter.breakfast: 'Breakfast',
                Filter.lunch: 'Lunch',
                Filter.dinner: 'Dinner',
                Filter.dessert: 'Dessert',
                Filter.italian: 'Italian',
                Filter.quickEasy: 'Quick&Easy',
                Filter.hamburgers: 'Hamburgers',
                Filter.german: 'German',
                Filter.exotic: 'Exotic',
                Filter.light: 'Lunch',
                Filter.asian: 'Asian',
                Filter.french: 'French',
                Filter.summer: 'Summer',
                Filter.sandwiches: 'Sandwiches',
              },
            ),
            gapH16,
            const DietFilterChipsRow(
              filterTitle: 'Diets',
              filters: [
                Filter.lactoseFree,
                Filter.glutenFree,
                Filter.vegetarian,
                Filter.vegan,
              ],
              filterLabels: {
                Filter.lactoseFree: 'Lactose-free',
                Filter.glutenFree: 'Gluten-free',
                Filter.vegetarian: 'Vegetarian',
                Filter.vegan: 'Vegan',
              },
            ),
            gapH16,
            CustomTextButton(
              text: 'Reset filters'.hardcoded,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.red),
              onPressed: () {
                ref.read(filtersProvider.notifier).resetFilters();
              },
            ),
            // gapH12,
            // PrimaryButton(
            //   text: 'Save'.hardcoded,
            //   onPressed: () {
            //     ref.read(filtersProvider.notifier).saveFilters(chosenFilters);
            //     Navigator.pop(context);
            //   },
            // ),
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
  final List<Filter> filters;
  final Map<Filter, String> filterLabels;

  const CategoryFilterChipsRow({
    super.key,
    required this.filterTitle,
    required this.filters,
    required this.filterLabels,
  });

  @override
  CategoryFilterChipsRowState createState() => CategoryFilterChipsRowState();
}

class CategoryFilterChipsRowState
    extends ConsumerState<CategoryFilterChipsRow> {
  @override
  Widget build(BuildContext context) {
    final activeFilters = ref.watch(filtersProvider);

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
            children: widget.filters.map((filter) {
              final label = widget.filterLabels[filter] ?? filter.toString();
              return ChoiceChip(
                label: Text(label),
                selected: activeFilters[filter] ?? false,
                onSelected: (selected) {
                  ref
                      .read(filtersProvider.notifier)
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
  final List<Filter> filters;
  final Map<Filter, String> filterLabels;

  const DietFilterChipsRow({
    super.key,
    required this.filterTitle,
    required this.filters,
    required this.filterLabels,
  });

  @override
  DietFilterChipsRowState createState() => DietFilterChipsRowState();
}

class DietFilterChipsRowState extends ConsumerState<DietFilterChipsRow> {
  @override
  Widget build(BuildContext context) {
    final activeFilters = ref.watch(filtersProvider);

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
            children: widget.filters.map((filter) {
              final label = widget.filterLabels[filter] ?? filter.toString();
              return ChoiceChip(
                label: Text(label),
                selected: activeFilters[filter] ?? false,
                onSelected: (selected) {
                  ref
                      .read(filtersProvider.notifier)
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
