import 'package:flutter/foundation.dart';
import 'package:love_cooking_app/src/features/filters/data/local/local_filtering_repository.dart';
import 'package:love_cooking_app/src/features/filters/domain/filtering.dart';
import 'package:love_cooking_app/src/features/filters/presentation/filters_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastFilteringRepository implements LocalFilteringRepository {
  SembastFilteringRepository(this.db);
  final Database db;
  final store = StoreRef.main();

  static Future<Database> createDatabase(String filename) async {
    if (!kIsWeb) {
      final appDocDir = await getApplicationDocumentsDirectory();
      return databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
    } else {
      return databaseFactoryWeb.openDatabase(filename);
    }
  }

  static Future<SembastFilteringRepository> makeDefault() async {
    return SembastFilteringRepository(await createDatabase('default.db'));
  }

  static const filteringItemsKey = 'filteringItems';

  @override
  Future<Filtering> fetchFiltering() async {
    final filteringJson =
        await store.record(filteringItemsKey).get(db) as String?;
    if (filteringJson != null) {
      return Filtering.fromJson(filteringJson);
    } else {
      return Filtering(availableCategoryFilters);
    }
  }

  @override
  Stream<Filtering> watchFiltering() {
    final record = store.record(filteringItemsKey);
    return record.onSnapshot(db).map((snapshot) {
      if (snapshot != null) {
        return Filtering.fromJson(snapshot.value as String);
      } else {
        return const Filtering();
      }
    });
  }

  @override
  Future<void> updateFiltering(Filtering filtering) {
    return store.record(filteringItemsKey).put(db, filtering.toJson());
  }
}
