import 'package:love_cooking_app/src/features/collection/data/local/local_collection_repository.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection.dart';
import 'package:love_cooking_app/src/utils/delay.dart';
import 'package:love_cooking_app/src/utils/in_memory_store.dart';

class FakeLocalCollectionRepository implements LocalCollectionRepository {
  final bool addDelay;

  FakeLocalCollectionRepository({this.addDelay = true});

  final _collection = InMemoryStore<Collection>(const Collection());

  /// we fetch the latest version of the Collection
  @override
  Future<Collection> fetchCollection() => Future.value(_collection.value);

  /// we watch the changes to the Collection
  @override
  Stream<Collection> watchCollection() => _collection.stream;

  /// we set a new value of the Collection
  @override
  Future<void> setCollection(Collection collection) async {
    await delay(addDelay);
    _collection.value = collection;
  }
}
