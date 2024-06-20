import 'package:love_cooking_app/src/features/filters/application/category_filtering_service.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_filtering_controller.g.dart';

@riverpod
class CategoryFilteringController extends _$CategoryFilteringController {
  bool mounted = true;
  CategoryFilteringService get filteringService =>
      ref.read(categoryFilteringServiceProvider);

  @override
  FutureOr<Filtering> build() async {
    ref.onDispose(() {
      mounted = false;
    });
    // Load initial state from the repository
    final initialCategoryFilters = await filteringService.fetchFiltering();
    return initialCategoryFilters;
  }

  void setFilter(String filterName, bool isActive) {
    final currentState = state;
    if (currentState is AsyncData<Filtering>) {
      final currentFilters = currentState.value.filters;
      final updatedFilters = {...currentFilters, filterName: isActive};
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

  Future<void> saveFilters(Filtering currentFilters) async {
    state = const AsyncLoading<Filtering>().copyWithPrevious(state);

    final value = await AsyncValue.guard(
      () => filteringService.updateFiltering(currentFilters),
    );
    if (mounted) {
      // * only set the state if the controller hasn't been disposed
      if (value.hasError == false) {
        state = AsyncData(currentFilters);
      }
    }
  }

  Future<void> reloadState() async {
    state = const AsyncLoading<Filtering>();
    final initialFilters = await filteringService.fetchFiltering();
    state = AsyncData(initialFilters);
  }
}
