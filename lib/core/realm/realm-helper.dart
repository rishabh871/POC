import 'package:jai_poc/core/realm/item.dart';
import 'package:realm/realm.dart';

class RealmHelper {
  static const int _schemaVersion = 1;

  static Future<Realm> openRealm() async {
    final config =
        Configuration.local([Item.schema], schemaVersion: _schemaVersion);
    return await Realm.open(config);
  }

  static Future<void> insertAllProduct(List<Item> product) async {
    final realm = await openRealm();
    realm.write(() {
      realm.addAll(product, update: true);
    });
    realm.close();
  }

  static Future<void> insertSingleProduct(Item product) async {
    final realm = await openRealm();
    realm.write(() {
      realm.add(product, update: true);
    });
    realm.close();
  }

  static Future<List<Item>> getAllProducts() async {
    final realm = await openRealm();
    final products = realm.all<Item>().toList();
    realm.close();
    return products;
  }

  static Future<void> deleteProduct(Item product) async {
    try {
      final realm = await openRealm();
      realm.write(() {
        realm.delete(product);
      });
      realm.close();
    } on RealmException catch (e) {
      print(e.message);
    }
  }
}
