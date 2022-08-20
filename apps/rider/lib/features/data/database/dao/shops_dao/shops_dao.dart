import 'package:moor/moor.dart';

import '../../../../../common/utils/functions/functions.dart';
import '../../../models/shop_model.dart';
import '../../app_db.dart';
import '../../tables/shops_table.dart';

part 'shops_dao.g.dart';

@UseDao(
  tables: [
    Shops,
  ],
)
class ShopsDAO extends DatabaseAccessor<AppDatabase> with _$ShopsDAOMixin {
  final AppDatabase db;

  ShopsDAO(this.db) : super(db);

  Future insert(Insertable<Shop> shop) {
    return (transaction(() => batch((batch) => batch.insert(shops, shop))));
  }

  Stream<List<ShopModel>> watchAllWithLatLong() {
    final query = selectOnly(shops)
      ..addColumns(_getShopModelColumns(forMap: true));
    _shopsHasLocationWhereConditions(query);
    return query.map((e) => _mapShops(e, fromMap: true)).watch();
  }

  Future<List<ShopModel>> getAllWithLatLong() {
    final query = selectOnly(shops)
      ..addColumns(_getShopModelColumns(forMap: true));

    _shopsHasLocationWhereConditions(query);
    return query.map((e) => _mapShops(e, fromMap: true)).get();
  }

  Future insertAll(List<ShopsCompanion> shopsList) async {
    await (transaction(() => batch((batch) =>
        batch.insertAll(shops, shopsList, mode: InsertMode.insertOrReplace))));
  }

  Future<List<String>> getMapSuggestion(name) async {
    final query = selectOnly(shops)
      ..where((shops.name).contains(name))
      ..addColumns([shops.name]);
    _shopsHasLocationWhereConditions(query);

    return query.map((e) => (e.read(shops.name))!).get();
  }

  Future<List<Shop>> getShopByName(name) async {
    final query = select(shops)..where((tbl) => tbl.name.contains(name));
    _shopsHasLocationWhereConditions(query);
    return query.get();
  }

  Future<Shop?> getWithLatLongById(String? id) {
    final query = select(shops)..where((tbl) => tbl.id.equals(id));

    _shopsHasLocationWhereConditions(query);

    return query.getSingleOrNull();
  }

  Future<int> getCount() {
    final count = shops.id.count();
    final query = selectOnly(shops)..addColumns([count]);
    final result = query.map((e) => e.read(count)).getSingle();
    return result;
  }

  Future deleteShops(List<String> deletedId) =>
      (delete(shops)..where((tbl) => tbl.id.isIn(deletedId))).go();

//
  Stream<List<Shop>> watchAllLimit({int limit = 0}) {
    final query = select(shops);
    if (limit != 0) query.limit(limit);
    return query.watch();
  }

//
  Stream<List<Shop>> watchAll() => (select(shops)).watch();

  updateShop(Shop shop) {
    return (transaction(() =>
        batch((batch) => batch.update(shops, shop, where: ($ShopsTable t) {
              return t.id.equals(shop.id);
            }))));
  }

//
  Future<List<ShopModel>> getAllFilteredMap(List<int?> categoriesIds,
      List<int> areasIds, List<int?> citiesIds, String searchText) async {
    final JoinedSelectStatement query = _getFilterShopsJoinedQuery(
        categoriesIds, areasIds, citiesIds, searchText,
        forMap: true);
    if (searchText.isNotEmpty) {
      query.where(shops.name.contains(
        Functions.getSearchText(searchText) ?? '',
      ));
    }
    final result = query
      ..where((shops.lat).isNotNull())
      ..where((shops.long).isNotNull())
      ..where(shops.lat.like("").not())
      ..where(shops.long.like("").not())
      ..get();

    return result.map((e) => _mapShops(e, fromMap: true)).get();
  }

  Stream<List<ShopModel>> watchAllFiltered(List<int?> categoriesIds,
      List<int> areasIds, List<int?> citiesIds, String? searchText) {
    final JoinedSelectStatement query = _getFilterShopsJoinedQuery(
        categoriesIds, areasIds, citiesIds, searchText);
    return query.map(_mapShops).watch();
  }

  Future<int> getAllFilteredCount(List<int?> categoriesIds, List<int> areasIds,
      List<int?> citiesIds, String? searchText) {
    final JoinedSelectStatement query = _getFilterShopsJoinedQuery(
        categoriesIds, areasIds, citiesIds, searchText,
        count: true);
    return query.map((e) => e.read(shops.id.count(distinct: true))).getSingle();
  }

  List<GeneratedColumn<dynamic>> _getShopModelColumns(
      {bool forMap = false, bool subImage = false}) {
    final List<GeneratedColumn<dynamic>> list = [
      shops.id,
      shops.name,
      shops.description,
    ];

    list.add(shops.personalImage);

    if (forMap) list.addAll([shops.lat, shops.long]);
    return list;
  }

  JoinedSelectStatement _getFilterShopsJoinedQuery(List<int?> categoriesIds,
      List<int> areasIds, List<int?> citiesIds, String? searchText,
      {List<Join> joins = const [],
      List<GeneratedColumn> columns = const [],
      bool count = false,
      bool forMap = false,
      bool subImage = false}) {
    final JoinedSelectStatement query = (selectOnly(shops, distinct: true));
    if (joins.isNotEmpty) query.join(joins);
    if (searchText?.isNotEmpty ?? false) {
      query.where(shops.name
          .lower()
          .contains(Functions.getSearchText(searchText!) ?? ''));
    }
    if (!count) {
      query
          .addColumns(_getShopModelColumns(subImage: subImage, forMap: forMap));
    } else {
      query.addColumns([shops.id.count(distinct: true)]);
    }
    if (columns.isNotEmpty) query.addColumns(columns);
    return query;
  }

  ShopModel _mapShops(TypedResult e,
      {bool subImage = false, bool fromMap = false}) {
    final name = e.read(shops.name)!;
    final id = e.read(shops.id)!;
    late final String image;
    image = e.read(shops.personalImage)!;
    final shopModel = ShopModel(
      name: name,
      image: image,
      id: id,
    );
    if (fromMap) {
      shopModel.lat = e.read(shops.lat);
      shopModel.long = e.read(shops.long);
    }
    return shopModel;
  }

//

  Future<Shop?> getById(String? id) =>
      (select(shops)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  _shopsHasLocationWhereConditions(Query<$ShopsTable, Shop> query) {
    if (query is SimpleSelectStatement<$ShopsTable, Shop>) {
      query
        ..where((tbl) => (tbl.long).isNotNull())
        ..where((tbl) => (tbl.lat).isNotNull())
        ..where((tbl) => tbl.lat.like("").not())
        ..where((tbl) => tbl.long.like("").not());
    } else if (query is JoinedSelectStatement<$ShopsTable, Shop>) {
      query
        ..where((shops.long).isNotNull())
        ..where((shops.lat).isNotNull())
        ..where((shops.lat).like("").not())
        ..where((shops.long).like("").not());
    }
  }
}
