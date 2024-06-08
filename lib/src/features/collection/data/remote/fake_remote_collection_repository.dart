import 'package:love_cooking_app/src/features/collection/data/remote/remote_collection_repository.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection.dart';
import 'package:love_cooking_app/src/utils/delay.dart';
import 'package:love_cooking_app/src/utils/in_memory_store.dart';

class FakeRemoteCollectionRepository implements RemoteCollectionRepository {
  final bool addDelay;

  FakeRemoteCollectionRepository({this.addDelay = true});

  /// An InMemoryStore containing the shopping cart data for all users, where:
  /// key: uid of the user,
  /// value: Collection of that user
  final _collections = InMemoryStore<Map<String, Collection>>({});

  @override
  Future<Collection> fetchCollection(String uid) {
    return Future.value(_collections.value[uid] ?? const Collection());
  }

  @override
  Stream<Collection> watchCollection(String uid) {
    return _collections.stream
        .map((collectionData) => collectionData[uid] ?? const Collection());
  }

  @override
  Future<void> setCollection(String uid, Collection collection) async {
    await delay(addDelay);
    // First, get the current collections data for all users
    final collections = _collections.value;
    // Then, set the collection for the given uid
    collections[uid] = collection;
    // Finally, update the collections data (will emit a new value)
    _collections.value = collections;
  }
}
