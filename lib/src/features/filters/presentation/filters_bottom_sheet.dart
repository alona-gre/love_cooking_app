import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/common_widgets/custom_text_button.dart';
import 'package:love_cooking_app/src/common_widgets/primary_button.dart';
import 'package:love_cooking_app/src/constants/app_sizes.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filtering_controller/filtering_controller.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';
import 'package:love_cooking_app/src/utils/async_value_ui.dart';

Map<String, bool> availableCategoryFilters = {
  // 'glutenFree': false,
  // 'lactoseFree': false,
  // 'vegetarian': false,
  // 'vegan': false,
  'breakfast': false,
  'lunch': false,
  'dinner': false,
  'dessert': false,
  'italian': false,
  'quickEasy': false,
  'hamburgers': false,
  'german': false,
  'exotic': false,
  'light': false,
  'asian': false,
  'french': false,
  'summer': false,
  'sandwiches': false,
};

class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFilters = ref.watch(filteringControllerProvider).value;

    ref.listen<AsyncValue<void>>(
      filteringControllerProvider,
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
              filterLabels: userFilters!.filters.keys.toList(),
            ),
            gapH16,
            // TODO add other filters
            // const DietFilterChipsRow(
            //   filterTitle: 'Diets',
            //   filters: [
            //     Filter.lactoseFree,
            //     Filter.glutenFree,
            //     Filter.vegetarian,
            //     Filter.vegan,
            //   ],
            //   filterLabels: {
            //     Filter.lactoseFree: 'Lactose-free',
            //     Filter.glutenFree: 'Gluten-free',
            //     Filter.vegetarian: 'Vegetarian',
            //     Filter.vegan: 'Vegan',
            //   },
            // ),
            gapH16,
            CustomTextButton(
              text: 'Reset filters'.hardcoded,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.red),
              onPressed: () {
                ref.read(filteringControllerProvider.notifier).resetFilters();
              },
            ),
            gapH12,
            PrimaryButton(
              text: 'Save'.hardcoded,
              onPressed: () {
                ref
                    .read(filteringControllerProvider.notifier)
                    .saveFilters(userFilters);
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
    final filters = ref.watch(filteringControllerProvider);
    final userFilters = filters.value == const Filtering({})
        ? Filtering(availableCategoryFilters)
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
                      .read(filteringControllerProvider.notifier)
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

// TODO add other filters
// class DietFilterChipsRow extends ConsumerStatefulWidget {
//   final String filterTitle;
//   final List<Filter> filters;
//   final Map<Filter, String> filterLabels;

//   const DietFilterChipsRow({
//     super.key,
//     required this.filterTitle,
//     required this.filters,
//     required this.filterLabels,
//   });

//   @override
//   DietFilterChipsRowState createState() => DietFilterChipsRowState();
// }

// class DietFilterChipsRowState extends ConsumerState<DietFilterChipsRow> {
//   @override
//   Widget build(BuildContext context) {
//     final activeFilters = ref.watch(filtersProvider);

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.filterTitle,
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           const SizedBox(height: 8.0),
//           Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             children: widget.filters.map((filter) {
//               final label = widget.filterLabels[filter] ?? filter.toString();
//               return ChoiceChip(
//                 label: Text(label),
//                 selected: activeFilters[filter] ?? false,
//                 onSelected: (selected) {
//                   ref
//                       .read(filtersProvider.notifier)
//                       .setFilter(filter, selected);
//                 },
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
