import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  breakfast,
  lunch,
  dinner,
  dessert,
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
  italian,
  quickEasy,
  hamburgers,
  german,
  exotic,
  light,
  asian,
  french,
  summer,
  sandwiches,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
          Filter.breakfast: false,
          Filter.lunch: false,
          Filter.dinner: false,
          Filter.dessert: false,
          Filter.italian: false,
          Filter.quickEasy: false,
          Filter.hamburgers: false,
          Filter.german: false,
          Filter.exotic: false,
          Filter.light: false,
          Filter.asian: false,
          Filter.french: false,
          Filter.summer: false,
          Filter.sandwiches: false,
        });

  // void saveFilters(Map<Filter, bool> chosenFilters) {
  //   state = chosenFilters;
  // }

  void resetFilters() {
    state = {
      for (var filter in Filter.values) filter: false,
    };
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);
