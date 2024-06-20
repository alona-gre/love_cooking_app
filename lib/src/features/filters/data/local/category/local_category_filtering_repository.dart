import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_category_filtering_repository.g.dart';

/// API for reading, watching and writing local category filtering data (guest user)
abstract class LocalCategoryFilteringRepository {
  Future<Filtering> fetchFiltering();

  Stream<Filtering> watchFiltering();

  Future<void> updateFiltering(Filtering filters);
}

@Riverpod(keepAlive: true)
LocalCategoryFilteringRepository localCategoryFilteringRepository(
    LocalCategoryFilteringRepositoryRef ref) {
  // * Override this in the main method
  throw UnimplementedError();
}
