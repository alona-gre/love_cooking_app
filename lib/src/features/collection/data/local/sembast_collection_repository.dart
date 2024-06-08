import 'package:love_cooking_app/src/features/collection/data/local/local_collection_repository.dart';
import 'package:love_cooking_app/src/features/collection/domain/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastCollectionRepository implements LocalCollectionRepository {
  final Database db;
  SembastCollectionRepository(this.db);

  final store = StoreRef.main();

  static Future<Database> createDatabase(String filename) async {
    if (!kIsWeb) {
      final appDocDir = await getApplicationDocumentsDirectory();
      return databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
    } else {
      return databaseFactoryWeb.openDatabase(filename);
    }
  }

  static Future<SembastCollectionRepository> makeDefault() async {
    return SembastCollectionRepository(await createDatabase('collection.db'));
  }

  static const collectionProductsKey = 'collectionProducts';

  @override
  Future<Collection> fetchCollection() async {
    final collectionJson =
        await store.record(collectionProductsKey).get(db) as String?;
    if (collectionJson != null) {
      return Collection.fromJson(collectionJson);
    } else {
      return const Collection();
    }
  }

  @override
  Future<void> setCollection(Collection collection) {
    //throw Exception('');
    return store.record(collectionProductsKey).put(db, collection.toJson());
  }

  @override
  Stream<Collection> watchCollection() {
    final record = store.record(collectionProductsKey);
    return record.onSnapshot(db).map((snapshot) {
      if (snapshot != null) {
        return Collection.fromJson(snapshot.value as String);
      } else {
        return const Collection();
      }
    });
  }
}
