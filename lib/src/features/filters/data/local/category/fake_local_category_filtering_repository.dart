import 'package:love_cooking_app/src/features/filters/data/local/category/local_category_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:love_cooking_app/src/utils/delay.dart';
import 'package:love_cooking_app/src/utils/in_memory_store.dart';

class FakeLocalCategoryFilteringRepository
    implements LocalCategoryFilteringRepository {
  final bool addDelay;

  FakeLocalCategoryFilteringRepository({this.addDelay = true});

  final _filtering = InMemoryStore<Filtering>(const Filtering());

  @override
  Future<Filtering> fetchFiltering() {
    return Future.value(_filtering.value);
  }

  @override
  Future<void> updateFiltering(Filtering filters) async {
    await delay(addDelay);
    _filtering.value = filters;
  }

  @override
  Stream<Filtering> watchFiltering() {
    return _filtering.stream;
  }
}
