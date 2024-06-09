import 'package:flutter/material.dart';
import 'package:love_cooking_app/src/common_widgets/alert_dialogs.dart';
import 'package:love_cooking_app/src/common_widgets/custom_text_button.dart';
import 'package:love_cooking_app/src/common_widgets/primary_button.dart';
import 'package:love_cooking_app/src/constants/app_sizes.dart';
import 'package:love_cooking_app/src/localization/string_hardcoded.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 16.0),
            const FilterChipsRow(
              filterTitle: 'Categories',
              chipLabels: [
                'Breakfast',
                'Lunch',
                'Dinner',
                'Dessert',
                'Snack',
                'Beverage'
              ],
            ),
            gapH16,
            const FilterChipsRow(
              filterTitle: 'Diets',
              chipLabels: [
                'Lactose-free',
                'Gluten-free',
                'Vegetarian',
              ],
            ),
            gapH16,
            CustomTextButton(
              text: 'Reset filters'.hardcoded,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.red),
              onPressed: () => showNotImplementedAlertDialog(context: context),
            ),
            // TODO: reset button logic

            gapH12,
            PrimaryButton(
              text: 'Apply'.hardcoded,
              onPressed:
                  // TODO: apply filters
                  () => showNotImplementedAlertDialog(context: context),
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

class FilterChipsRow extends StatefulWidget {
  final String filterTitle;
  final List<String> chipLabels;

  const FilterChipsRow({
    super.key,
    required this.filterTitle,
    required this.chipLabels,
  });

  @override
  _FilterChipsRowState createState() => _FilterChipsRowState();
}

class _FilterChipsRowState extends State<FilterChipsRow> {
  final Set<String> _selectedChips = {};

  @override
  Widget build(BuildContext context) {
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
            children: widget.chipLabels.map((label) {
              return ChoiceChip(
                label: Text(label),
                selected: _selectedChips.contains(label),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedChips.add(label);
                    } else {
                      _selectedChips.remove(label);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
