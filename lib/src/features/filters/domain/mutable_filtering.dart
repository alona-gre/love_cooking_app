import 'package:love_cooking_app/src/features/filters/domain/filter_item.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';

/// Helper extension used to mutate the filters in the filtering settings.
extension MutableFiltering on Filtering {
  /// add an item to the cart by *overriding* the quantity if it already exists
  Filtering updateFilterItem(FilterItem filterItem) {
    final copy = Map<String, bool>.from(filters);
    copy[filterItem.filterName] = filterItem.isEnabled;
    return Filtering(copy);
  }

  /// add a list of new filter items to the filtering settings
  ///  by *updating* the values of filter items that
  /// already exist
  Filtering addFilter(FilterItem item) {
    final copy = Map<String, bool>.from(filters);
    copy.update(
      item.filterName,
      // if there is already a value, update it by adding the item quantity
      (value) => item.isEnabled,
      // otherwise, add the item with the given quantity
      ifAbsent: () => item.isEnabled,
    );

    return Filtering(copy);
  }

  /// add a list of new filter items to the filtering settings
  ///  by *updating* the values of filter items that
  /// already exist
  Filtering addFilters(List<FilterItem> filterItemsToAdd) {
    final copy = Map<String, bool>.from(filters);
    for (var item in filterItemsToAdd) {
      copy.update(
        item.filterName,
        // if there is already a value, take it.
        (value) => item.isEnabled ? true : value,
        // otherwise, set the filter value which was saved locally
        ifAbsent: () => item.isEnabled,
      );
    }
    return Filtering(copy);
  }

  /// if a filter item with the given name is found, remove it
  Filtering removeItemByFilterName(String filterName) {
    final copy = Map<String, bool>.from(filters);
    copy.remove(filterName);
    return Filtering(copy);
  }
}
