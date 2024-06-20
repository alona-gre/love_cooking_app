import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/constants/test_filters.dart';
import 'package:love_cooking_app/src/exceptions/error_logger.dart';
import 'package:love_cooking_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:love_cooking_app/src/features/authentication/domain/app_user.dart';
import 'package:love_cooking_app/src/features/filters/data/local/category/local_category_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/data/local/diet/local_diet_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/data/remote/category/remote_category_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/data/remote/diet/remote_diet_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:love_cooking_app/src/features/filters/domain/mutable_filtering.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filtering_controller/category_filtering_controller.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filtering_controller/diet_filtering_controller.dart';
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
        _moveItemsToRemoteCategoryFiltering(user.uid);
        _moveItemsToRemoteDietFiltering(user.uid);
      }
    });
  }

  /// moves all category filters from the local to remote category filtering
  void _moveItemsToRemoteCategoryFiltering(String uid) async {
    try {
      // get the local filtering data
      final localFilteringRepository =
          ref.read(localCategoryFilteringRepositoryProvider);
      final localFiltering = await localFilteringRepository.fetchFiltering();
      if (localFiltering.filters.isNotEmpty) {
        // get the remote filtering data
        final remoteFilteringRepository =
            ref.read(remoteCategoryFilteringRepositoryProvider);
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
            .updateFiltering(const Filtering(availableCategoryFilters));
        // trigger the build method of FilteringController
        await ref
            .read(categoryFilteringControllerProvider.notifier)
            .reloadState();
      }
    } catch (e, st) {
      ref.read(errorLoggerProvider).logError(e, st);
    }
  }

  /// moves all diet filters from the local to remote diet filtering
  void _moveItemsToRemoteDietFiltering(String uid) async {
    try {
      // get the local filtering data
      final localFilteringRepository =
          ref.read(localDietFilteringRepositoryProvider);
      final localFiltering = await localFilteringRepository.fetchFiltering();
      if (localFiltering.filters.isNotEmpty) {
        // get the remote filtering data
        final remoteFilteringRepository =
            ref.read(remoteDietFilteringRepositoryProvider);
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
            .updateFiltering(const Filtering(availableDietFilters));
        // trigger the build method of FilteringController
        await ref.read(dietFilteringControllerProvider.notifier).reloadState();
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
