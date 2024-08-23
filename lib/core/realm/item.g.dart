// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../core/realm/item.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Item extends _Item with RealmEntity, RealmObjectBase, RealmObject {
  Item(
    String title,
    String description,
    String imageUrl,
    String price, {
    Iterable<String> images = const [],
  }) {
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set<RealmList<String>>(
        this, 'images', RealmList<String>(images));
  }

  Item._();

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String get imageUrl =>
      RealmObjectBase.get<String>(this, 'imageUrl') as String;
  @override
  set imageUrl(String value) => RealmObjectBase.set(this, 'imageUrl', value);

  @override
  String get price => RealmObjectBase.get<String>(this, 'price') as String;
  @override
  set price(String value) => RealmObjectBase.set(this, 'price', value);

  @override
  RealmList<String> get images =>
      RealmObjectBase.get<String>(this, 'images') as RealmList<String>;
  @override
  set images(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Item>> get changes =>
      RealmObjectBase.getChanges<Item>(this);

  @override
  Item freeze() => RealmObjectBase.freezeObject<Item>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Item._);
    return const SchemaObject(ObjectType.realmObject, Item, 'Item', [
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('imageUrl', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.string),
      SchemaProperty('images', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
