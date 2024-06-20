import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_diet_filtering_repository.g.dart';

/// API for reading, watching and writing local diet filtering data (guest user)
abstract class LocalDietFilteringRepository {
  Future<Filtering> fetchFiltering();

  Stream<Filtering> watchFiltering();

  Future<void> updateFiltering(Filtering filtering);
}

@Riverpod(keepAlive: true)
LocalDietFilteringRepository localDietFilteringRepository(
    LocalDietFilteringRepositoryRef ref) {
  // * Override this in the main method
  throw UnimplementedError();
}
