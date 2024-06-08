import 'package:love_cooking_app/src/features/collection/domain/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_collection_repository.g.dart';

abstract class LocalCollectionRepository {
  /// API for reading, watching and writing local collection data (guest user)
  Future<Collection> fetchCollection();

  Stream<Collection> watchCollection();

  Future<void> setCollection(Collection collection);
}

@Riverpod(keepAlive: true)
LocalCollectionRepository localCollectionRepository(
    LocalCollectionRepositoryRef ref) {
  // * Override this in the main method
  throw UnimplementedError();
}
