import 'package:flutter/foundation.dart';
import 'package:love_cooking_app/src/features/filters/application/filtering_service.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtering_controller.g.dart';

@riverpod
class FilteringController extends _$FilteringController {
  bool mounted = true;
  FilteringService get filteringService => ref.watch(filteringServiceProvider);

  @override
  FutureOr<Filtering> build() async {
    ref.onDispose(() {
      mounted = false;
    });
    // Load initial state from the repository
    final initialFilters = await filteringService.fetchFiltering();
    debugPrint(initialFilters.toString());
    return initialFilters;
  }

  void setFilter(String filterName, bool isActive) {
    final currentState = state;
    debugPrint(currentState.toString());
    if (currentState is AsyncData<Filtering>) {
      final currentFilters = currentState.value.filters;
      final updatedFilters = {...currentFilters, filterName: isActive};
      debugPrint(updatedFilters.toString());
      state = AsyncData(Filtering(updatedFilters));
    }
  }

  void resetFilters() {
    final currentState = state;
    if (currentState is AsyncData<Filtering>) {
      final updatedFilters = {
        for (var filter in currentState.value.filters.keys) filter: false,
      };
      state = AsyncData(Filtering(updatedFilters));
    }
  }

  Future<void> saveFilters() async {
    final currentState = state;
    if (currentState is AsyncData<Filtering>) {
      state = const AsyncLoading<Filtering>().copyWithPrevious(state);
      final value = await AsyncValue.guard(
        () => filteringService.updateFiltering(currentState.value),
      );
      if (mounted) {
        // * only set the state if the controller hasn't been disposed
        if (value.hasError == false) {
          state = AsyncData(currentState.value);
        }
      }
    }
  }
}
