import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_cooking_app/src/features/filters/data/remote/category/fake_remote_category_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_category_filtering_repository.g.dart';

/// API for reading, watching and writing category filtering data for a specific user ID
abstract class RemoteCategoryFilteringRepository {
  Future<Filtering> fetchFiltering(String uid);

  Stream<Filtering> watchFiltering(String uid);

  Future<void> updateFiltering(String uid, Filtering filtering);
}

@Riverpod(keepAlive: true)
RemoteCategoryFilteringRepository remoteCategoryFilteringRepository(
    RemoteCategoryFilteringRepositoryRef ref) {
  // TODO: replace with "real" remote filtering repository
  return FakeRemoteCategoryFilteringRepository(addDelay: false);
}
