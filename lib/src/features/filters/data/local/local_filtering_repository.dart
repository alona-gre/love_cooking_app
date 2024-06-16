import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_filtering_repository.g.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class LocalFilteringRepository {
  Future<Filtering> fetchFiltering();

  Stream<Filtering> watchFiltering();

  Future<void> updateFiltering(Filtering cart);
}

@Riverpod(keepAlive: true)
LocalFilteringRepository localFilteringRepository(
    LocalFilteringRepositoryRef ref) {
  // * Override this in the main method
  throw UnimplementedError();
}
