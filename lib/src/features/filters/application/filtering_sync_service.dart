import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/exceptions/error_logger.dart';
import 'package:love_cooking_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:love_cooking_app/src/features/authentication/domain/app_user.dart';
import 'package:love_cooking_app/src/features/filters/data/local/local_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/data/remote/remote_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:love_cooking_app/src/features/filters/domain/mutable_filtering.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filters_bottom_sheet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtering_sync_service.g.dart';

class FilteringSyncService {
  final Ref ref;

  FilteringSyncService(this.ref) {
    _init();
  }

  void _init() {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) {
      final previousUser = previous?.value;
      final user = next.value;
      if (previousUser == null && user != null) {
        // TODO:
        _moveItemsToRemoteFiltering(user.uid);
      }
    });
  }

  /// moves all items from the local to remote filtering
  void _moveItemsToRemoteFiltering(String uid) async {
    try {
      // get the local filtering data
      final localFilteringRepository =
          ref.read(localFilteringRepositoryProvider);
      final localFiltering = await localFilteringRepository.fetchFiltering();
      if (localFiltering.filters.isNotEmpty) {
        // get the remote filtering data
        final remoteFilteringRepository =
            ref.read(remoteFilteringRepositoryProvider);
        final remoteFiltering =
            await remoteFilteringRepository.fetchFiltering(uid);

        // add all the local filtering items to the remote filtering
        final updatedRemoteFiltering = remoteFiltering.addFilters(
          localFiltering.toItemsList(),
        );
        // write the updated remote filtering data to the repository
        await remoteFilteringRepository.updateFiltering(
            uid, updatedRemoteFiltering);
        // reset all the filters in the local filtering to default
        await localFilteringRepository
            .updateFiltering(Filtering(availableCategoryFilters));
      }
    } catch (e, st) {
      ref.read(errorLoggerProvider).logError(e, st);
    }
  }
}

@Riverpod(keepAlive: true)
FilteringSyncService filteringSyncService(FilteringSyncServiceRef ref) {
  return FilteringSyncService(ref);
}
