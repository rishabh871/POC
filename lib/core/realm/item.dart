import 'package:realm/realm.dart';

part 'item.g.dart';

@RealmModel()
class _Item {
  late String title;
  late String description;
  late String imageUrl;
  late String price;
  late List<String> images;

}