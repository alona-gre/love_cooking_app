import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/features/filters/data/remote/fake_remote_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_filtering_repository.g.dart';

/// API for reading, watching and writing filtering data for a specific user ID
abstract class RemoteFilteringRepository {
  Future<Filtering> fetchFiltering(String uid);

  Stream<Filtering> watchFiltering(String uid);

  Future<void> updateFiltering(String uid, Filtering filtering);
}

@Riverpod(keepAlive: true)
RemoteFilteringRepository remoteFilteringRepository(
    RemoteFilteringRepositoryRef ref) {
  // TODO: replace with "real" remote filtering repository
  return FakeRemoteFilteringRepository(addDelay: false);
}
