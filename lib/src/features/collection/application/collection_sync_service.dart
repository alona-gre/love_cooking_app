import 'package:love_cooking_app/src/exceptions/error_logger.dart';
import 'package:love_cooking_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:love_cooking_app/src/features/authentication/domain/app_user.dart';
import 'package:love_cooking_app/src/features/collection/data/local/local_collection_repository.dart';
import 'package:love_cooking_app/src/features/collection/data/remote/remote_collection_repository.dart';
import 'package:love_cooking_app/src/features/collection/domain/mutable_collection.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'collection_sync_service.g.dart';

class CollectionSyncService {
  final Ref ref;

  CollectionSyncService(this.ref) {
    _init();
  }

  void _init() {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) {
      final previousUser = previous?.value;
      final user = next.value;
      if (previousUser == null && user != null) {
        _moveItemsToRemoteCollection(user.uid);
      }
    });
  }

  /// moves all items from the local to remote collection
  void _moveItemsToRemoteCollection(String uid) async {
    try {
      // get the local collection data
      final localCollectionRepository =
          ref.read(localCollectionRepositoryProvider);
      final localCollection = await localCollectionRepository.fetchCollection();
      if (localCollection.items.isNotEmpty) {
        // get the remote collection data
        final remoteCollectionRepository =
            ref.read(remoteCollectionRepositoryProvider);
        final remoteCollection =
            await remoteCollectionRepository.fetchCollection(uid);
        // add all the local collection items to the remote collection
        final updatedRemoteCollection = remoteCollection.addCollectionItems(
          localCollection.toCollectionItemsList(),
        );
        // write the updated remote collection data to the repository
        await remoteCollectionRepository.setCollection(
            uid, updatedRemoteCollection);
        // remove all the items from the local collection
        await localCollectionRepository.setCollection(const Collection());
      }
    } catch (e, st) {
      ref.read(errorLoggerProvider).logError(e, st);
    }
  }
}

@Riverpod(keepAlive: true)
CollectionSyncService collectionSyncService(CollectionSyncServiceRef ref) {
  return CollectionSyncService(ref);
}
