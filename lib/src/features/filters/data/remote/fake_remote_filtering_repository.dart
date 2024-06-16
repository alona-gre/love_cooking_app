import 'package:flutter/foundation.dart';
import 'package:love_cooking_app/src/features/filters/data/remote/remote_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filters_bottom_sheet.dart';
import 'package:love_cooking_app/src/utils/delay.dart';
import 'package:love_cooking_app/src/utils/in_memory_store.dart';

class FakeRemoteFilteringRepository implements RemoteFilteringRepository {
  FakeRemoteFilteringRepository({this.addDelay = true});
  final bool addDelay;

  /// An InMemoryStore containing the shopping filtering data for all users, where:
  /// key: uid of the user
  /// value: Filtering of that user
  final _filterings = InMemoryStore<Map<String, Filtering>>({});

  @override
  Future<Filtering> fetchFiltering(String uid) {
    debugPrint(
        'fetched Filtering: $uid,  ${_filterings.value[uid]}'.toString());
    return Future.value(
        _filterings.value[uid] ?? Filtering(availableCategoryFilters));
  }

  @override
  Stream<Filtering> watchFiltering(String uid) {
    return _filterings.stream
        .map((filteringData) => filteringData[uid] ?? const Filtering());
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

    debugPrint('updated Filtering: $uid,  ${_filterings.value}'.toString());
  }
}
