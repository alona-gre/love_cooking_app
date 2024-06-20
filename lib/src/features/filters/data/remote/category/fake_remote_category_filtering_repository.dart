import 'package:love_cooking_app/src/constants/test_filters.dart';
import 'package:love_cooking_app/src/features/filters/data/remote/category/remote_category_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:love_cooking_app/src/utils/delay.dart';
import 'package:love_cooking_app/src/utils/in_memory_store.dart';

class FakeRemoteCategoryFilteringRepository
    implements RemoteCategoryFilteringRepository {
  FakeRemoteCategoryFilteringRepository({this.addDelay = true});
  final bool addDelay;

  /// An InMemoryStore containing the category filtering data for all users, where:
  /// key: uid of the user
  /// value: Filtering of that user
  final _filterings = InMemoryStore<Map<String, Filtering>>({});

  @override
  Future<Filtering> fetchFiltering(String uid) {
    return Future.value(
        _filterings.value[uid] ?? const Filtering(availableCategoryFilters));
  }

  @override
  Stream<Filtering> watchFiltering(String uid) {
    return _filterings.stream.map((filteringData) =>
        filteringData[uid] ?? const Filtering(availableCategoryFilters));
  }

  @override
  Future<void> updateFiltering(String uid, Filtering filtering) async {
    await delay(addDelay);
    // First, get the current filterings data for all users
    final filterings = _filterings.value;
    // Then, set the filtering for the given uid
    filterings[uid] = filtering;
    // Finally, update the filterings data (will emit a new value)
    _filterings.value = filterings;
  }
}
