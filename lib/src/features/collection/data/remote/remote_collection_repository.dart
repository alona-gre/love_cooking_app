import 'package:love_cooking_app/src/features/collection/data/remote/fake_remote_collection_repository.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_collection_repository.g.dart';

abstract class RemoteCollectionRepository {
  /// API for reading, watching and writing collection data for a specific user ID
  Future<Collection> fetchCollection(String uid);
  Stream<Collection> watchCollection(String uid);
  Future<void> setCollection(String uid, Collection collection);
}

@Riverpod(keepAlive: true)
RemoteCollectionRepository remoteCollectionRepository(
    RemoteCollectionRepositoryRef ref) {
  // TODO: replace with "real" remote cart repository
  return FakeRemoteCollectionRepository(addDelay: false);
}
