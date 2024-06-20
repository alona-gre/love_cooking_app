import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/features/filters/data/remote/diet/fake_remote_diet_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_diet_filtering_repository.g.dart';

/// API for reading, watching and writing diet filtering data for a specific user ID
abstract class RemoteDietFilteringRepository {
  Future<Filtering> fetchFiltering(String uid);

  Stream<Filtering> watchFiltering(String uid);

  Future<void> updateFiltering(String uid, Filtering filtering);
}

@Riverpod(keepAlive: true)
RemoteDietFilteringRepository remoteDietFilteringRepository(
    RemoteDietFilteringRepositoryRef ref) {
  // TODO: replace with "real" remote filtering repository
  return FakeRemoteDietFilteringRepository(addDelay: false);
}
